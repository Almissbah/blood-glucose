import 'package:blood_glucose/domain/model/samples_data_model.dart';

class RepoSamplesData{
  final List<BloodSample> samples;
  final String unit;

  RepoSamplesData(this.samples, this.unit);
}