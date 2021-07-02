 
import 'package:json_annotation/json_annotation.dart';

import 'blood_glucose_sample.dart';

part 'glucose_samples_response.g.dart';

@JsonSerializable()
class GlucoseSamplesResponse { 
  @JsonKey(name: 'bloodGlucoseSamples')
  final List<BloodGlucoseSample> data;

  GlucoseSamplesResponse({
    this.data,
  });

  factory GlucoseSamplesResponse.fromJson(Map<String, dynamic> json) =>
      _$GlucoseSamplesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GlucoseSamplesResponseToJson(this);
}
