import 'package:blood_glucose/core/model/resource.dart';

abstract class BaseUseCase<T,P>{
Future<Resource<T>> excute(P params);

}