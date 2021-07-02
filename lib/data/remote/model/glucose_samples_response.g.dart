// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose_samples_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlucoseSamplesResponse _$GlucoseSamplesResponseFromJson(
    Map<String, dynamic> json) {
  return GlucoseSamplesResponse(
    data: (json['bloodGlucoseSamples'] as List)
        ?.map((e) => e == null
            ? null
            : BloodGlucoseSample.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GlucoseSamplesResponseToJson(
        GlucoseSamplesResponse instance) =>
    <String, dynamic>{
      'bloodGlucoseSamples': instance.data,
    };
