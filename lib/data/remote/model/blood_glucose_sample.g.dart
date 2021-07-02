// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_glucose_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodGlucoseSample _$BloodGlucoseSampleFromJson(Map<String, dynamic> json) {
  return BloodGlucoseSample(
    value: json['value'] as String,
    timestamp: json['timestamp'] as String,
    unit: json['unit'] as String,
  );
}

Map<String, dynamic> _$BloodGlucoseSampleToJson(BloodGlucoseSample instance) =>
    <String, dynamic>{
      'value': instance.value,
      'timestamp': instance.timestamp,
      'unit': instance.unit,
    };
