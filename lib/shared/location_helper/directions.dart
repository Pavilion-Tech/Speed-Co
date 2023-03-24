import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/directions_model.dart';
import '../components/constants.dart';

class DirectionsRepository{
  final String _url ='https://maps.googleapis.com/maps/api/directions/json?';
  Dio? _dio;

  DirectionsRepository({Dio? dio}): _dio = dio??Dio();

  Future<Directions?> getDirections ({
    required LatLng origin,
    required LatLng destination,
    String mode = 'driving'
  })async{
    final response = await _dio!.get(
        _url,
        queryParameters: {
          'origin':'${origin.latitude.toString()},${origin.longitude.toString()}',
          'destination':'${destination.latitude.toString()},${destination.longitude.toString()}',
          'mode':mode,
          'key':googleAPIKey
        }
    ).catchError((e)=>print(e.toString()));
    if(response.statusCode==200){
      return Directions.fromMap(response.data);
    }
    return null;
  }
}