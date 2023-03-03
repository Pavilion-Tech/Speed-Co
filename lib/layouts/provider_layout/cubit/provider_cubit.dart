import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/network/remote/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/directions_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/location_helper/directions.dart';
import '../../../shared/network/remote/end_point.dart';

class ProviderCubit extends Cubit<ProviderStates>{
  ProviderCubit():super(InitState());
  static ProviderCubit get(context)=>BlocProvider.of(context);

  Position? position;
  TextEditingController addressController = TextEditingController();
  Directions? directions;
  Marker? origin;
  Marker? distance;




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
  })async{
    await  DirectionsRepository()
        .getDirections(origin: origin, destination: destination)
        .then((value) {
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

  void getRequests({page = 1}){
    DioHelper.getData(
        url: '${pRequestsUrl}status=$status&page=$page',
      token: 'Bearer $pToken'
    ).then((value) {
      print(value.data);
    }).catchError((e){

    });
  }
}