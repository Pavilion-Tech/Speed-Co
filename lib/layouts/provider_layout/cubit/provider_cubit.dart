import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/network/remote/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/directions_model.dart';
import '../../../models/provider/provider_model.dart';
import '../../../models/provider/request_model.dart';
import '../../../modules/item_shared/wrong_screens/update_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/location_helper/directions.dart';
import '../../../shared/network/remote/end_point.dart';
import '../provider_layout.dart';

class ProviderCubit extends Cubit<ProviderStates>{
  ProviderCubit():super(InitState());
  static ProviderCubit get(context)=>BlocProvider.of(context);

  Position? position;
  TextEditingController addressController = TextEditingController();
  Directions? directions;
  Marker? origin;
  Marker? distance;
  ProviderModel? providerModel;
  RequestModel? requestModel;
  ScrollController requestScrollController = ScrollController();


  void checkUpdate(context) async{
    final newVersion =await NewVersionPlus().getVersionStatus();
    if(newVersion !=null){
      if(newVersion.canUpdate){
        navigateAndFinish(context, UpdateScreen(
            url:newVersion.appStoreLink,
            releaseNote:newVersion.releaseNotes??tr('update_desc')
        ));
      }
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
  void getDirection({
    required LatLng origin,
    required LatLng destination,
    String mode = 'driving'
  })async{
    await  DirectionsRepository()
        .getDirections(origin: origin, destination: destination,mode: mode)
        .then((value) {
          print(value!.totalDuration);
      directions = value;
      this.origin = Marker(
          position: origin,
          markerId: MarkerId('origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
      );
      distance = Marker(
          position: destination,
          markerId: MarkerId('destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
      );
      emit(GetCurrentLocationState());
    }).catchError((e){
      print(e.toString());
      showToast(msg: e.toString(),toastState: false);
    });
  }

  Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=${origin!.position.latitude},${origin!.position.longitude}&destination=${distance!.position.latitude},${distance!.position.longitude}';
    print(googleUrl);
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  int status = 1;

  void getProvider(){
    DioHelper.getData(
        url: '$providerUrl$userId',
        token: 'Bearer $pToken',
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        providerModel = ProviderModel.fromJson(value.data);
        emit(GetProviderSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(GetProviderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      print(e.toString());
      emit(GetProviderErrorState());
    });
  }

  void getRequests({int page = 1,int status = 1}) {
    emit(GetRequestLoadingState());
      DioHelper.getData(
          url: '$pOrderUrl$page&status=$status',
          lang: myLocale,
          token: 'Bearer $pToken').then((value) {
            print(value.data);
        if (value.data['data'] != null) {
          if(page == 1) {
            requestModel = RequestModel.fromJson(value.data);
          }
          else{
            requestModel!.data!.currentPage = value.data['data']['currentPage'];
            requestModel!.data!.pages = value.data['data']['pages'];
            value.data['data']['data'].forEach((e){
              requestModel!.data!.data!.add(RequestData.fromJson(e));
            });
          }
          emit(GetRequestSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(GetRequestWrongState());
        }
      }).catchError((e) {
        emit(GetRequestErrorState());
      });
  }

  void paginationRequest(){
    requestScrollController.addListener(() {
      if (requestScrollController.offset == requestScrollController.position.maxScrollExtent){
        if (requestModel!.data!.currentPage != requestModel!.data!.pages) {
          if(state is! GetRequestLoadingState){
            int currentPage = requestModel!.data!.currentPage! +1;
            getRequests(page: currentPage);
          }
        }
      }
    });
  }

  void changeLang(BuildContext context){
    navigateAndFinish(context, ProviderLayout());
    DioHelper.putData(
        url: updateUserUrl,
        token: 'Bearer $token',
        formData: FormData.fromMap({'current_language':myLocale})
    ).then((value) {
      getRequests();
    }).catchError((e)=>print(e.toString()));
  }
}