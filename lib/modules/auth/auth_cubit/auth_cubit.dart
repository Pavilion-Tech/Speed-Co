import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_states.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/network/local/cache_helper.dart';
import 'package:speed_co/shared/network/remote/dio.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/remote/end_point.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit ():super(InitState());
  static AuthCubit get (context)=> BlocProvider.of(context);

  XFile? image;
  ImagePicker picker = ImagePicker();
  TextEditingController phoneC = TextEditingController();


  void justEmit(){
    emit(JustEmitState());
  }

  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 25);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }


  Position? position;
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
      }
    });
  }


  void createUser({
  required String phone,
  required String name,
  required String lat,
  required String lng,
}){
    emit(CreateUserLoadingState());
    DioHelper.postData(
      url: createUserUrl,
      data: {
        'phone_number':phone,
        'firebase_token':'',
        'current_language':myLocale,
        'name':name,
        'current_latitude':lat,
        'current_longitude':lng,
      }
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        emit(CreateUserSuccessState());
      }else{
        if(value.data['data']!=null){
          showToast(msg: value.data['data'].toString());
        }else{
          showToast(msg: value.data['message']);
        }
        emit(CreateUserWrongState());
      }
    }).catchError((e){
      emit(CreateUserErrorState());
    });
  }

  void createProvider({
  required String phone,
  required String name,
  required String email,
  required String lat,
  required String lng,
}){
    FormData formData = FormData.fromMap({
      'phone_number':phone,
      'email':email,
      'firebase_token':'',
      'current_language':myLocale,
      'name':name,
      'current_latitude':lat,
      'current_longitude':lng,
      'certificate_file':MultipartFile.fromFileSync(image!.path,
          filename: image!.path.split('/').last),
    });
    emit(CreateProviderLoadingState());
    DioHelper.postData2(
      url: createProviderUrl,
      formData:formData
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        emit(CreateProviderSuccessState());
      }else{
        if(value.data['data']!=null){
          showToast(msg: value.data['data'].toString());
        }else{
          showToast(msg: value.data['message']);
        }
        emit(CreateProviderWrongState());
      }        
    }).catchError((e){
      emit(CreateProviderErrorState());
    });
  }

  void login(){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: pLoginUrl,
        //pLoginUrl,
        //loginUrl,
        data:{'phone_number':phoneC.text.trim()}
    ).then((value) {
      print(value.data);
      if(value.data['data'] !=null){
        code = value.data['data']['code'];
        userId = value.data['data']['user_id'];
        emit(LoginSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(LoginWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(LoginErrorState());
    });
  }

  void verify(BuildContext context){
    emit(VerifyLoadingState());
    DioHelper.postData(
        url: verifyUrl,
        data:{'user_id':userId,'code':code}
    ).then((value) {
      phoneC.text = '';
      if(value.data['data'] !=null){
        if(value.data['data']['user_type'] == 'user'){
          token = value.data['data']['token'];
          CacheHelper.saveData(key: 'token', value: token);
          if(UserCubit.get(context).adsModel!=null){
            var cubit =MenuCubit.get(context);
            cubit.getOrders();
            cubit.getUser();
          }
          emit(VerifyUserSuccessState());
        }else{
          pToken = value.data['data']['token'];
          CacheHelper.saveData(key: 'pToken', value: pToken);
          emit(VerifyProviderSuccessState());
        }
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(VerifyWrongState());
      }
    }).catchError((e){
      emit(VerifyErrorState());
    });
  }
}