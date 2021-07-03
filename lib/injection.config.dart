// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di/api_module.dart';
import 'data/remote/glucose_api_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  gh.factory<Dio>(() => apiModule.getDio());
  gh.factory<GlucoseApiService>(
      () => apiModule.getShortlyApiService(get<Dio>()));
  return get;
}

class _$ApiModule extends ApiModule {}
