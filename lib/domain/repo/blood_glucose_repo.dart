import 'package:blood_glucose/core/model/resource.dart';
import 'package:blood_glucose/domain/model/filter_data_request.dart';
import 'package:blood_glucose/domain/model/repo_samples_data.dart';

abstract class BloodGlucoseRepository {
  Future<Resource<RepoSamplesData>> filterData(FilterDataRequest request);
}
