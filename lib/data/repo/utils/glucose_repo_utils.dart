import 'package:blood_glucose/core/model/resource.dart';
import 'package:blood_glucose/data/remote/model/blood_glucose_sample.dart';
import 'package:blood_glucose/data/remote/model/glucose_samples_response.dart';
import 'package:blood_glucose/domain/model/repo_samples_data.dart';
import 'package:blood_glucose/domain/model/filter_data_request.dart';
import 'package:blood_glucose/domain/model/samples_data_model.dart';

class GlucoseRepoUtils {
  static Resource<RepoSamplesData> getRepoSamplesData(
      Resource<GlucoseSamplesResponse> response) {
    try {
      if (response is SuccessResource) {
        var data = response.payload.data;
        return SuccessResource<RepoSamplesData>(
            RepoSamplesData(_adapteSamples(data), _getUnit(data)));
      } else {
        FailureResource resource = response as FailureResource;
        return FailureResource<RepoSamplesData, ErrorPayload>(
            resource.optionalErrorPayload, resource.msg);
      }
    } catch (e) {
      return FailureResource<RepoSamplesData, ErrorPayload>(null, e.toString());
    }
  }

  static RepoSamplesData filterSamplesByDateRange(
      RepoSamplesData cache, FilterDataRequest request) {
    DateTime startDate = request.startDate.subtract(Duration(days: 1));
    DateTime endDate = request.endDate.add(Duration(days: 1));
    var list = cache.samples
        .where((element) =>
            startDate.isBefore(element.timeStamp) &&
            endDate.isAfter(element.timeStamp))
        .toList();

    return RepoSamplesData(list, cache.unit);
  }

  static String _getUnit(List<BloodGlucoseSample> list) {
    try {
      return list[0].unit;
    } catch (e) {
      return "N/A";
    }
  }

  static List<BloodSample> _adapteSamples(List<BloodGlucoseSample> list) {
    var samples = list.map((element) {
      DateTime time;
      double value;
      try {
        value = double.parse(element.value);
        time = DateTime.parse(element.timestamp);
      } catch (e) {}

      return BloodSample(
        timeStamp: time,
        value: value,
      );
    });

    return samples;
  }
}
