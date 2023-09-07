import 'dart:async';
import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init1() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://speed-co-api.wik.ydh.mybluehost.me/',
        receiveTimeout: 3000000,
        connectTimeout: 3000000,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
        followRedirects: true,
      ),
    );
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String? token,
        String? lang,
      }) async {

    dio.options.headers =
    {
      'Accept-Language' : myLocale,
      'Authorization':token ,
      'Content-Type': 'application/json'
    };
      return response = await dio.get(url, queryParameters: query);

  }

  static Future<Response> postData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,


  }) async {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'Accept-Language' : myLocale,

    };

    return response = await dio.post(url, data: data,);
  }

  static Future<Response> postData2({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,
    FormData? formData,


  }) async {

    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'Accept-Language' : myLocale,

    };

    return response = await dio.post(url, data: formData,);
  }


  static Future<Response> putData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String lang = 'en',
    FormData? formData,


  }) async {
    dio.options.headers =
    {
      'Accept-Language' : myLocale,
      'Authorization':token ,
      'Content-Type': 'application/json',
    };
    return response = await dio.put(url, data: formData??data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String lang = 'en',


  }) async {
    dio.options.headers =
    {
      'Accept-Language' : myLocale,
      'Authorization':token ,
      'Content-Type': 'application/json'
    };
    return response = await dio.delete(url, data: data);
  }
}
