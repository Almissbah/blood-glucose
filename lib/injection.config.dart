// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di/api_module.dart';
import 'data/repo/blood_glucose_repository.dart';
import 'domain/repo/blood_glucose_repo.dart';
import 'data/remote/glucose_api_service.dart';
import 'presentation/bloc/samples_bloc.dart';

/// Environment names
const _prod = 'prod';

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
  gh.factory<SamplesBloc>(() => SamplesBloc(get<BloodGlucoseRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<BloodGlucoseRepository>(
      BloodGlucoseRepoImpl(get<GlucoseApiService>()),
      registerFor: {_prod});
  return get;
}

class _$ApiModule extends ApiModule {}
