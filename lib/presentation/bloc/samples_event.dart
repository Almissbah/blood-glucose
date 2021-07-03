part of 'samples_bloc.dart';

@immutable
abstract class SamplesEvent {}

class FilterDateEvent extends SamplesEvent{
  final DateTime startDate,endDate;

  FilterDateEvent({this.startDate, this.endDate});
}
