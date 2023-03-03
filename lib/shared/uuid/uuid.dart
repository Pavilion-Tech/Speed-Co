// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
//
//
// class Uuid{
//
//   static Future<String?> getUuid()async{
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if(Platform.isAndroid){
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//      return androidInfo.id;
//     }
//     if(Platform.isIOS){
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       return iosInfo.identifierForVendor;
//     }
//   }
// }