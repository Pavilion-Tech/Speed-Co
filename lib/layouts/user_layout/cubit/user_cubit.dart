import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/shared/network/remote/dio.dart';

import '../../../models/user/ads_model.dart';
import '../../../models/user/categoies_model.dart';
import '../../../models/user/service_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/end_point.dart';

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

  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

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
      url: getAdsUrl
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
      url: getCategoriesUrl
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
      url: '$getServiceUrl$id'
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

})async{
    emit(PlaceOrderLoadingState());
    FormData formData = FormData.fromMap({
      'date':'date',
      'time':'time',
      'description':desc,
      'user_latitude':lat,
      'user_longitude':lng,
      'service_id':id,
    });

    if(images.isNotEmpty){
      for(var image in images){
        formData.files.addAll({
        MapEntry("images[]", await MultipartFile.fromFileSync(image.path,
        filename: image.path.split('/').last))
        });
      }
    }
    DioHelper.postData2(
      url: placeOrderUrl,
      token: 'Bearer $token',
      formData:formData
    ).then((value) {
      showToast(msg: value.data['message']);
      if(value.data['data']!=null){
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
      data: {
          'provider_id':providerId,
          'review_rate':rate,
          'review_content':content,
      }
    ).then((value) {
      if(value.data['status']==true){
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
        url: '$searchUrl$text'
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


}