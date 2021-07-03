part of 'samples_bloc.dart';

@immutable
abstract class SamplesState {}

class SamplesInitial extends SamplesState {}

class SamplesLoadingState extends SamplesState {}

class SamplesSuccessState extends SamplesState {
  final SamplesDataModel data;

  SamplesSuccessState({@required this.data});
}

class SamplesFailureState extends SamplesState {
  final String msg;

  SamplesFailureState({@required this.msg});
}
