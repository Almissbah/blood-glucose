import 'package:blood_glucose/data/remote/model/glucose_samples_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart'; 
part 'glucose_api_service.g.dart';

@RestApi(baseUrl: "https://s3-de-central.profitbricks.com")
abstract class GlucoseApiService {
  factory GlucoseApiService(Dio dio) = _GlucoseApiService;

  @GET("/una-health-frontend-tech-challenge/sample.json")
  Future<HttpResponse<GlucoseSamplesResponse>> getSamples(
  );
}
