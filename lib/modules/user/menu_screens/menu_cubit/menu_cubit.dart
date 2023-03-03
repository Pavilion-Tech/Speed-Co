import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/shared/network/local/cache_helper.dart';
import 'package:speed_co/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../models/directions_model.dart';
import '../../../../models/notification_model.dart';
import '../../../../models/settings_model.dart';
import '../../../../models/static_page_model.dart';
import '../../../../models/user/orders_model.dart';
import '../../../../models/user/user_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/location_helper/directions.dart';
import '../../../../shared/network/remote/dio.dart';
import '../../../../shared/network/remote/end_point.dart';
import 'menu_states.dart';

class MenuCubit extends Cubit<MenuStates> {
  MenuCubit() : super(InitState());
  static MenuCubit get(context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  XFile? chatImage;
  XFile? profileImage;
  TextEditingController controller = TextEditingController();
  Position? position;
  Directions? directions;
  Marker? origin;
  Marker? distance;
  UserModel? userModel;
  OrdersModel? ordersModel;
  SettingsModel? settingsModel;
  StaticPageModel? staticPageModel;
  NotificationModel? notificationModel;
  ScrollController notificationScrollController = ScrollController();
  ScrollController orderScrollController = ScrollController();

  Future<XFile?> pick(ImageSource source) async {
    try {
      return await picker.pickImage(source: source, imageQuality: 20);
    } catch (e) {
      print(e.toString());
      emit(ImageWrong());
    }
  }

  void justEmit() {
    emit(JustEmitState());
  }

  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //  showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.', toastState: false);
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
      print(value);
      if (value != null) {
        position = value;
        emit(GetCurrentLocationState());
      }
    });
  }

  Future<void> getAddress(
      {LatLng? latLng, required TextEditingController controller}) async {
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      controller.text = placeMark.street!;
      controller.text += ', ${placeMark.country!}';
      emit(GetCurrentLocationState());
    }
  }

  void getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    await DirectionsRepository()
        .getDirections(origin: origin, destination: destination)
        .then((value) {
      directions = value;
      this.origin = Marker(
          position: origin,
          markerId: MarkerId('origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      distance = Marker(
          position: destination,
          markerId: MarkerId('destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
      emit(GetCurrentLocationState());
    }).catchError((e) {
      print(e.toString());
      showToast(msg: e.toString(), toastState: false);
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

  void getUser() {
    if (token != null)
      DioHelper.getData(url: userUrl, token: 'Bearer $token').then((value) {
        if (value.data['data'] != null) {
          userModel = UserModel.fromJson(value.data);
          emit(GetUserSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(GetUserWrongState());
        }
      }).catchError((e) {
        emit(GetUserErrorState());
      });
  }

  void updateUser({
  required String name,
  required String lat,
  required String lng,
  required String email,
}) async {
    emit(UpdateUserLoadingState());
    FormData formData = FormData.fromMap({
      'name':name,
      'current_latitude':lat,
      'current_longitude':lng,
      'email':email,
      'firebase_token':fcmToken,
      'current_language':myLocale,
    });
    if (profileImage != null)
      formData.files.addAll({
        MapEntry('personal_photo', await MultipartFile.fromFileSync(profileImage!.path,
                filename: profileImage!.path.split('/').last))});
    DioHelper.putData(
            url: updateUserUrl,
        token: 'Bearer $token',
        formData: formData
    ).then((value) {
      showToast(msg:value.data['message']);
      if(value.data['status'] == true){
        getUser();
        emit(UpdateUserSuccessState());
      }else{
        emit(UpdateUserWrongState());
      }
    }).catchError((e) {
      emit(UpdateUserErrorState());
    });
  }

  void getOrders({int page = 1}) {
    emit(GetOrderLoadingState());
    if(token!=null)
    DioHelper.getData(
          url: '$orderUrl$page',
          token: 'Bearer $token').then((value) {
            print(value.data);
        if (value.data['data'] != null) {
          if(page == 1) {
            ordersModel = OrdersModel.fromJson(value.data);
          }
          else{
            ordersModel!.data!.currentPage = value.data['data']['currentPage'];
            ordersModel!.data!.pages = value.data['data']['pages'];
            value.data['data']['data'].forEach((e){
              ordersModel!.data!.data!.add(OrderData.fromJson(e));
            });
          }
          emit(GetOrderSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(GetOrderWrongState());
        }
      }).catchError((e) {
        emit(GetOrderErrorState());
      });
  }

  void paginationOrders(){
    orderScrollController.addListener(() {
      if (orderScrollController.offset == orderScrollController.position.maxScrollExtent){
        if (ordersModel!.data!.currentPage != ordersModel!.data!.pages) {
          if(state is! GetOrderLoadingState){
            int currentPage = ordersModel!.data!.currentPage! +1;
            getOrders(page: currentPage);
          }
        }
      }
    });
  }
  void getSettings() {
      DioHelper.getData(url: 'settings').then((value) {
        if (value.data['data'] != null) {
          settingsModel = SettingsModel.fromJson(value.data);
          emit(GetUserSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(GetUserWrongState());
        }
      }).catchError((e) {
        emit(GetUserErrorState());
      });
  }
  void getStaticPages() {
      DioHelper.getData(url: 'static-pages/all').then((value) {
        if (value.data['data'] != null) {
          staticPageModel = StaticPageModel.fromJson(value.data);
          emit(GetUserSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(GetUserWrongState());
        }
      }).catchError((e) {
        emit(GetUserErrorState());
      });
  }
  void contactUs({
  required String subject,
  required String message,
}) {
    emit(ContactLoadingState());
    DioHelper.postData(
        url: contactUrl,
        token: 'Bearer $token',
        data: {
          'subject':subject,
          'message':message,
        }
      ).then((value) {
      showToast(msg: value.data['message']);
      if (value.data['data'] != null) {
          emit(ContactSuccessState());
        } else {
          emit(ContactWrongState());
        }
      }).catchError((e) {
        emit(ContactErrorState());
      });
  }
  void getNotification({int page = 1}) {
    emit(NotificationLoadingState());
    if(token!=null)
      DioHelper.getData(
          url: '$notificationUrl$page',
          token: 'Bearer $token').then((value) {
        print(value.data);
        if (value.data['data'] != null) {
          if(page == 1) {
            notificationModel = NotificationModel.fromJson(value.data);
          }
          else{
            notificationModel!.data!.currentPage = value.data['data']['currentPage'];
            notificationModel!.data!.pages = value.data['data']['pages'];
            value.data['data']['data'].forEach((e){
              notificationModel!.data!.data!.add(NotificationData.fromJson(e));
            });
          }
          emit(NotificationSuccessState());
        } else {
          showToast(msg: value.data['message']);
          emit(NotificationWrongState());
        }
      }).catchError((e) {
        emit(NotificationErrorState());
      });
  }

  void paginationNotification(){
    notificationScrollController.addListener(() {
      if (notificationScrollController.offset == notificationScrollController.position.maxScrollExtent){
        if (notificationModel!.data!.currentPage != notificationModel!.data!.pages) {
          if(state is! NotificationLoadingState){
            int currentPage = notificationModel!.data!.currentPage! +1;
            getNotification(page: currentPage);
          }
        }
      }
    });
  }

  void logout({int destroy = 1,required BuildContext context}){
    DioHelper.postData(
        url: logoutUrl,
      token: 'Bearer $token',
      data: {'destroy':destroy},
    );
    userModel = null;
    ordersModel = null;
    token = null;
    CacheHelper.removeData('token');
    navigateAndFinish(context, SplashScreen());
  }
}
