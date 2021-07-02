// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GlucoseApiService implements GlucoseApiService {
  _GlucoseApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://s3-de-central.profitbricks.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HttpResponse<GlucoseSamplesResponse>> getSamples() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/una-health-frontend-tech-challenge/sample.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GlucoseSamplesResponse.fromJson(_result.data);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
