import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/shared/network/remote/dio.dart';

import '../../../models/user/ads_model.dart';
import '../../../models/user/categoies_model.dart';
import '../../../models/user/date_model.dart';
import '../../../models/user/service_model.dart';
import '../../../modules/item_shared/wrong_screens/update_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/end_point.dart';
import '../user_layout.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit():super(InitState());

  static UserCubit get (context)=> BlocProvider.of(context);

  ImagePicker picker = ImagePicker();

  List<XFile> images = [];

  int currentIndex = 0;

  AdsModel? adsModel;

  CategoriesModel? categoriesModel;

  ServiceModel? serviceModel;
  ServiceModel? searchServiceModel;

  Position? position;

  DateModel? dateModel;

  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  Future<XFile?> pick() async {
    try {
      return await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    } catch (e) {
      print(e.toString());
      emit(ImageWrong());
    }
  }
  void emitState (){
    emit(EmitState());
  }

  void selectImages() async {
    images = await picker.pickMultiImage(imageQuality:10);
    emit(ImagesPickedState());
  }

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void checkUpdate(context) async{
    final newVersion =await NewVersionPlus().getVersionStatus();
    if(newVersion !=null){
      if(newVersion.canUpdate)navigateAndFinish(context, UpdateScreen(
          url:newVersion.appStoreLink,
          releaseNote:newVersion.releaseNotes??tr('update_desc')
      ));
    }
  }

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }
  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(msg: 'Location permissions are permanently denied, we cannot request permissions Open Location permissions from Setting', toastState: false);
      await Geolocator.openLocationSettings();
      emit(GetCurrentLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await checkPermissions();
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        position = value;
        emit(GetCurrentLocationState());
        getAddress(latLng: LatLng(position!.latitude,position!.longitude));
      }
    });
  }

  Future<void> getAddress({LatLng? latLng}) async {
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      addressController.text = placeMark.street!;
      addressController.text += ', ${placeMark.country!}';
      emit(GetCurrentLocationState());
    }
  }

  void getAds(){
    DioHelper.getData(
      url: getAdsUrl,
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        adsModel = AdsModel.fromJson(value.data);
        emit(GetHomeSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(GetHomeWrongState());
      }
    }).catchError((e){
      emit(GetHomeErrorState());
    });
  }


  void getCategories(){
    DioHelper.getData(
      url: getCategoriesUrl,
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(GetHomeSuccessState());
        getService(categoriesModel!.data![0].id??'');
      }else{
        showToast(msg: value.data['message']);
        emit(GetHomeWrongState());
      }
    }).catchError((e){
      emit(GetHomeErrorState());
    });
  }

  void getService(String id){
    emit(GetHomeLoadingState());
    DioHelper.getData(
      url: '$getServiceUrl$id',
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        serviceModel = ServiceModel.fromJson(value.data);
        emit(GetHomeSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(GetHomeWrongState());
      }
    }).catchError((e){
      emit(GetHomeErrorState());
    });
  }


  void getHomeData(){
    getAds();
    getCategories();
  }


  void placeOrder({
    String? desc,
    required String lat,
    required String lng,
    required String id,
    required String date,
    required String time,
    required BuildContext context,

})async{
    emit(PlaceOrderLoadingState());
    FormData formData = FormData.fromMap({
      'date':date,
      'time':time,
      'description':desc,
      'user_latitude':lat,
      'user_longitude':lng,
      'service_id':id,
    });

    if(images.isNotEmpty){
      for(var image in images){
        File file = await FlutterNativeImage.compressImage(image.path,quality:1,);
        var bytes = await file.readAsBytes();
        print(bytes.length);
        formData.files.addAll({
        MapEntry("images[]",MultipartFile.fromFileSync(file.path,
        filename: file.path.split('/').last))
        });
      }
    }
    DioHelper.postData2(
      url: placeOrderUrl,
      token: 'Bearer $token',
        lang: myLocale,
      formData:formData
    ).then((value) {
      print(value.data);
      showToast(msg: value.data['message']);
      if(value.data['data']!=null){
        MenuCubit.get(context).getOrders();
        emit(PlaceOrderSuccessState());
      }else{
        emit(PlaceOrderWrongState());
      }
    }).catchError((e){
      emit(PlaceOrderErrorState());
    });
  }

  void rate({
  required String providerId,
  required int rate,
  required String content,
}){
    emit(RateLoadingState());
    DioHelper.postData(
      url: rateUrl,
      token: 'Bearer $token',
        lang: myLocale,
      data: {
          'provider_id':providerId,
          'review_rate':rate,
          'review_content':content,
      }
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        emit(RateSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(RateWrongState());
      }
    }).catchError((e){
      emit(RateErrorState());
    });
  }

  void searchService(String text){
    emit(SearchLoadingState());
    DioHelper.getData(
        url: '$searchUrl$text',
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        searchServiceModel = ServiceModel.fromJson(value.data);
        emit(SearchSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(SearchWrongState());
      }
    }).catchError((e){
      emit(SearchErrorState());
    });
  }

  void getDate(){
    if(token!=null)
    DioHelper.getData(
        url: dateUrl,
      token: 'Bearer $token',
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        dateModel = DateModel.fromJson(value.data);
        emit(DateSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(DateWrongState());
      }
    }).catchError((e){
      emit(DateErrorState());
    });
  }

  void changeLang(BuildContext context){
    navigateAndFinish(context, UserLayout());
    DioHelper.putData(
        url: updateUserUrl,
        token: 'Bearer $token',
        formData: FormData.fromMap({'current_language':myLocale})
    ).then((value) {
      getHomeData();
    }).catchError((e)=>print(e.toString()));
  }


}