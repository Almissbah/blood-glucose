import 'dart:io';

import 'package:blood_glucose/core/model/resource.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart'; 

class RetrofitResponseHandler<T> {
  Future<Resource<T>> handle(Future<HttpResponse<T>> future) async {
    Resource<T> resource;
    var response;
    try {
      response = await future;

      resource = SuccessResource<T>(response.data);
    } catch (error) {
      if (error.runtimeType == DioError &&
          (error as DioError).response != null) {
        final res = (error as DioError).response;

        resource = _handleResponse(res);
      } else {
        resource = FailureResource<T, APIError>(
            APIError(APIErrorType.ConnectionError, 0),
            "Faild to connect, Please check your connection and try again!");
      }
    }

    return resource;
  }

  FailureResource<T, APIError> _handleResponse(Response res) {
    FailureResource failureResource;
     
    failureResource = FailureResource<T, APIError>(
        APIError(APIErrorType.HttpError, res.statusCode), "HTTP ERROR!");
    return failureResource;
  }
}
