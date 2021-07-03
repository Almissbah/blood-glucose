import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart'; 

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(String environment) =>
    $initGetIt(getIt, environment: environment);

abstract class Env {
  static const test = 'test';
  static const prod = 'prod'; 
}
