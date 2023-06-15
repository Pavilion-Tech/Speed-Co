import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_states.dart';

import '../../../../models/chat_history_model.dart';
import '../../../../models/chat_model.dart';
import '../../../../models/notification_model.dart';
import '../../../../models/settings_model.dart';
import '../../../../models/static_page_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../../../splash_screen.dart';

class ProviderMenuCubit extends Cubit<ProviderMenuStates>{
  ProviderMenuCubit():super(InitState());
  static ProviderMenuCubit get (context)=>BlocProvider.of(context);

  XFile? profileImage;
  ImagePicker picker = ImagePicker();
  XFile? chatImage;
  ScrollController notificationScrollController = ScrollController();
  NotificationModel? notificationModel;
  SettingsModel? settingsModel;
  StaticPageModel? staticPageModel;
  ChatHistoryModel? chatHistoryModel;
  ChatModel? chatModel;
  TextEditingController controller = TextEditingController();

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }


  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 1);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }
  void justEmit(){
    emit(JustEmitState());
  }
  void logout({int destroy = 1,required BuildContext context}){
    DioHelper.postData(
      url: pLogoutUrl,
      token: 'Bearer $pToken',
      data: {'destroy':destroy},
    );
    pToken = null;
    CacheHelper.removeData('pToken');
    navigateAndFinish(context, SplashScreen());
  }
  void getNotification({int page = 1}) {
    emit(NotificationLoadingState());
      DioHelper.getData(
          url: '$notificationUrl$page',
          lang: myLocale,
          token: 'Bearer $pToken').then((value) {
        print(value.data);
        if (value.data['data'] != null) {
          if(page == 1) {
            notificationModel = NotificationModel.fromJson(value.data);
          }else{
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

  void updateProvider({
  required String name,
  required String email,
  required BuildContext context,
})async{
    emit(UpdateProviderLoadingState());
    FormData formData = FormData.fromMap({
      'name':name,
      'email':email,
    });
    if (profileImage != null){
      File file = await FlutterNativeImage.compressImage(profileImage!.path,quality:1,);
      var enc = await file.readAsBytes();
      print(enc.length);
      formData.files.addAll({
        MapEntry('personal_photo', await MultipartFile.fromFileSync(file.path,
            filename: file.path.split('/').last))});
    }

    DioHelper.putData(
        url: '$updateProviderUrl$userId',
      token: 'Bearer $pToken',
        lang: myLocale,
      formData:formData
    ).then((value) {
      if(value.data['status'] == true){
        ProviderCubit.get(context).getProvider();
        showToast(msg: value.data['message']);
        emit(UpdateProviderSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UpdateProviderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(UpdateProviderErrorState());
    });
  }

  void getSettings() {
    DioHelper.getData(url: 'settings',lang: myLocale).then((value) {
      if (value.data['data'] != null) {
        settingsModel = SettingsModel.fromJson(value.data);
        emit(GetSettingsSuccessState());
      } else {
        showToast(msg: value.data['message']);
        emit(GetSettingsWrongState());
      }
    }).catchError((e) {
      emit(GetSettingsErrorState());
    });
  }
  void getStaticPages() {
    DioHelper.getData(url: 'static-pages/all',lang: myLocale).then((value) {
      if (value.data['data'] != null) {
        staticPageModel = StaticPageModel.fromJson(value.data);
        emit(GetSettingsSuccessState());
      } else {
        showToast(msg: value.data['message']);
        emit(GetSettingsWrongState());
      }
    }).catchError((e) {
      emit(GetSettingsErrorState());
    });
  }
  void contactUs({
    required String subject,
    required String message,
  }) {
    emit(ContactLoadingState());
    DioHelper.postData(
        url: contactUrl,
        lang: myLocale,
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

  void chatHistory(){
    emit(ChatHistoryLoadingState());
    DioHelper.getData(
        url:chatHistoryUrl,
        lang: myLocale,
        token: 'Bearer $pToken'
    ).then((value) {
      if(value.data['data']!=null){
        chatHistoryModel = ChatHistoryModel.fromJson(value.data);
        emit(ChatHistorySuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(ChatHistoryWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(ChatHistoryErrorState());
    });
  }

  void chat(String id){
    DioHelper.getData(
        url:'$chatUrl$id',
        lang: myLocale,
        token: 'Bearer $pToken'
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        chatModel = ChatModel.fromJson(value.data);
        emit(ChatHistorySuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(ChatHistoryWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(ChatHistoryErrorState());
    });
  }

  void sendMessage({
    required String id,
    String? message,
    required int type
  })async{
    emit(SendMessageLoadingState());
    FormData formData = FormData.fromMap({
      'order_id':chatModel!.data!.id!,
      'message_type':type
    });
    if(chatImage!=null){
      File file = await FlutterNativeImage.compressImage(chatImage!.path,quality:1,);
      formData.files.addAll({
        MapEntry('uploaded_message_file', MultipartFile.fromFileSync(
            file.path,filename: file.path.split('/').last
        ))
      });
    }else{
      formData.fields.addAll({
        MapEntry('message',message!)
      });
    }
    DioHelper.postData2(
        url: sendMessageUrl,
        formData:formData,
        lang: myLocale,
        token: 'Bearer $pToken'
    ).then((value) {
      if(value.data['status'] == true){
        if(controller.text.isNotEmpty)controller.text = '';
        chat(id);
        emit(SendMessageSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(SendMessageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(SendMessageErrorState());
    });
  }

  void sendMessageWithFile({
    required String id,
    required int type,
    required File file,
  }){
    FormData formData = FormData.fromMap({
      'order_id':id,
      'message_type':type,
      'uploaded_message_file':MultipartFile.fromFileSync(file.path,
          filename: file.path.split('/').last),
    });
    emit(SendMessageWithFileLoadingState());
    DioHelper.postData2(
        url: sendMessageUrl,
        token: 'Bearer $token',
        lang: myLocale,
        formData:formData
    ).then((value) {
      if(value.data['status']==true){
        chat(id);
        emit(SendMessageSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(SendMessageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(SendMessageErrorState());
    });
  }

}