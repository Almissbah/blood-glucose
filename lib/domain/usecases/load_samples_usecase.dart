import 'package:blood_glucose/core/model/resource.dart';
import 'package:blood_glucose/core/usecase/base_usecase.dart';
import 'package:blood_glucose/domain/model/filter_data_request.dart';
import 'package:blood_glucose/domain/model/repo_samples_data.dart';
import 'package:blood_glucose/domain/model/samples_data_model.dart';
import 'package:blood_glucose/domain/repo/blood_glucose_repo.dart';

class LoadSamples extends BaseUseCase<SamplesDataModel, FilterDataRequest> {
  final BloodGlucoseRepository repository;
  LoadSamples(this.repository);

  @override
  Future<Resource<SamplesDataModel>> excute(FilterDataRequest params) async {
    var result = await repository.filterData(params);

    if (result is SuccessResource) {
      RepoSamplesData data = result.payload;
      var samplesData = SamplesDataModel(
          samples: data.samples,
          startDate: _getStartDate(params, data),
          endDate: _getEndDate(params, data),
          maxValue: _getMaxValue(data.samples),
          minValue: _getMinValue(data.samples),
          avrageValue: _getAvarageValue(data.samples),
          medianValue: _getMedianValue(data.samples),
          unit: data.unit);

      return SuccessResource(samplesData);
    } else {
      return FailureResource<SamplesDataModel, ErrorPayload>(
          null, (result as FailureResource).msg);
    }
  }

  double _getAvarageValue(List<BloodSample> list) {
    double sum = 0;

    list.forEach((element) {
      sum += element.value;
    });

    return ((sum / list.length)*100).round()/100;
  }

  double _getMinValue(List<BloodSample> list) {
    double currentMinValue = double.maxFinite;

    list.forEach((element) {
      if (element.value <= currentMinValue) {
        currentMinValue = element.value;
      }
    });
    return currentMinValue;
  }

  double _getMaxValue(List<BloodSample> list) {
    double currentMaxValue = double.minPositive;

    list.forEach((element) {
      if (element.value >= currentMaxValue) {
        currentMaxValue = element.value;
      }
    });
    return currentMaxValue;
  }

  double _getMedianValue(List<BloodSample> mList) {
    List<double> doubleList = mList.map((e) => e.value).toList();

    doubleList.sort((a, b) => a.compareTo(b));

    double median;

    int middle = doubleList.length ~/ 2;
    if (doubleList.length % 2 == 1) {
      median = doubleList[middle];
    } else {
      median = ((doubleList[middle - 1] + doubleList[middle]) / 2.0);
    }

    return median;
  }

  _getStartDate(FilterDataRequest params, RepoSamplesData data) {
    try {
      return params.startDate ?? data.samples[0].timeStamp;
    } catch (e) {
      return DateTime.now().subtract(Duration(days: 30));
    }
  }

  _getEndDate(FilterDataRequest params, RepoSamplesData data) {
    try {
      return params.endDate ?? data.samples.last.timeStamp;
    } catch (e) {
      return DateTime.now().subtract(Duration(days: 30));
    }
  }
}
