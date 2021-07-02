 import 'package:json_annotation/json_annotation.dart';

part 'blood_glucose_sample.g.dart';

@JsonSerializable()
class BloodGlucoseSample { 
  final String value; 
  final String timestamp; 
  final String unit;  
  
  BloodGlucoseSample(
   { this.value,
    this.timestamp,
    this.unit, }
  );

  factory BloodGlucoseSample.fromJson(Map<String, dynamic> json) =>
      _$BloodGlucoseSampleFromJson(json);
  Map<String, dynamic> toJson() => _$BloodGlucoseSampleToJson(this);
}
