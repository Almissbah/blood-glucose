import 'package:blood_glucose/data/remote/glucose_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart'; 

@module
abstract class ApiModule {
  @preResolve
  Dio getDio() {
    var dio = Dio(); 
    return dio;
  }

  @preResolve
  GlucoseApiService getShortlyApiService(Dio dio) {
    return GlucoseApiService(dio);
  } 
}
