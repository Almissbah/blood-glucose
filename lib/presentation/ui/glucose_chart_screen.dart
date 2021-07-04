import 'package:blood_glucose/presentation/bloc/samples_bloc.dart';
import 'package:blood_glucose/presentation/ui/widget/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlucoseChartScreen extends StatefulWidget {
  static String routeName = "GlucoseChartScreen";
  const GlucoseChartScreen({Key key}) : super(key: key);

  @override
  _GlucoseChartScreenState createState() => _GlucoseChartScreenState();
}

class _GlucoseChartScreenState extends State<GlucoseChartScreen> {
  SamplesBloc _samplesBloc;
  @override
  void initState() {
    _samplesBloc = BlocProvider.of<SamplesBloc>(context);
    _samplesBloc.loadSamples(startDate: null, endDate: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
                  child: BlocBuilder<SamplesBloc, SamplesState>(
            builder: (context, state) {
              if (state is SamplesSuccessState) {
                return _buildSuccessState(state);
              } else if (state is SamplesFailureState) {
                return _buildFailuerState(state);
              } else {
                return _buildLoadingState();
              }
            },
          ),
        ),
      ],
    );
  }

  Column _buildSuccessState(SamplesSuccessState state) {
    return Column(
      children: [
        GlucoseLineChart(state.data),
        Row(children: [
          Text("max ${state.data.maxValue}")
        ],)
      ],
    );
  }

  Column _buildFailuerState(SamplesFailureState state) {
    return Column(
      children: [
        Text(state.msg),
      ],
    );
  }

  Column _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [CircularProgressIndicator()],
    );
  }
}

class _buildFailuerState {}
