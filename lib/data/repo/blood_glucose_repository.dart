import 'package:blood_glucose/data/remote/glucose_api_service.dart';
import 'package:blood_glucose/data/remote/model/glucose_samples_response.dart';
import 'package:blood_glucose/data/remote/utils/network_utils.dart';
import 'package:blood_glucose/core/model/resource.dart'; 
import 'package:blood_glucose/data/repo/utils/glucose_repo_utils.dart';
import 'package:blood_glucose/domain/model/filter_data_request.dart';
import 'package:blood_glucose/domain/repo/blood_glucose_repo.dart';
import 'package:injectable/injectable.dart';

import '../../injection.dart';
import '../../domain/model/repo_samples_data.dart';
import '../../domain/model/samples_data_model.dart';

@Singleton(as: BloodGlucoseRepository, env: [Env.prod])
class BloodGlucoseRepoImpl extends BloodGlucoseRepository {
  final GlucoseApiService apiService;
  RepoSamplesData cache;
  BloodGlucoseRepoImpl(this.apiService);

  @override
  Future<Resource<RepoSamplesData>> filterData(
      FilterDataRequest request) async {
    if (cache == null) return _loadSamples(request);
    var data = GlucoseRepoUtils.filterSamplesByDateRange(cache, request);
    return Future.value(SuccessResource(data));
  }

  Future<Resource<RepoSamplesData>> _loadSamples(
      FilterDataRequest request) async {
    var response = await RetrofitResponseHandler<GlucoseSamplesResponse>()
        .handle(apiService.getSamples());

    var result = GlucoseRepoUtils.getRepoSamplesData(response);

    if (result is SuccessResource) {
      var data = GlucoseRepoUtils.filterSamplesByDateRange(cache, request);
      return Future.value(SuccessResource(data));
    } else
      return result;
  }
}
