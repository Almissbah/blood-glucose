import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blood_glucose/core/model/resource.dart';
import 'package:blood_glucose/domain/model/filter_data_request.dart';
import 'package:blood_glucose/domain/model/samples_data_model.dart';
import 'package:blood_glucose/domain/repo/blood_glucose_repo.dart';
import 'package:blood_glucose/domain/usecases/load_samples_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'samples_event.dart';
part 'samples_state.dart';


@injectable
class SamplesBloc extends Bloc<SamplesEvent, SamplesState> {
  final BloodGlucoseRepository repository;
  SamplesBloc(this.repository) : super(SamplesInitial());

  @override
  Stream<SamplesState> mapEventToState(
    SamplesEvent event,
  ) async* {
    if (event is FilterDateEvent) {
      yield SamplesLoadingState();
      var result = await LoadSamples(this.repository).excute(FilterDataRequest(
          startDate: event.startDate, endDate: event.endDate));
      if (result is SuccessResource) {
        yield SamplesSuccessState(data: result.payload);
      } else if (result is FailureResource) {
        yield SamplesFailureState(msg: (result as FailureResource).msg);
      }
    }
  }

  loadSamples({@required DateTime startDate, @required DateTime endDate}) {
    add(FilterDateEvent(startDate: startDate, endDate: endDate));
  }
}
