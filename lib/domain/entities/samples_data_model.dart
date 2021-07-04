import 'package:flutter/material.dart';

class SamplesDataModel{
  final DateTime startDate;
  final DateTime endDate;
  final double minValue,maxValue,avrageValue,medianValue;
  final List<BloodSample> samples;
  final String unit;
  SamplesDataModel( { @required this.unit, @required this.minValue,@required  this.maxValue,@required  this.avrageValue,@required  this.medianValue,@required  this.samples,@required this.startDate,@required this.endDate});
}

 class BloodSample{
  final double value;
  final DateTime timeStamp;

  BloodSample({@required this.value, @required this.timeStamp});
  
 }