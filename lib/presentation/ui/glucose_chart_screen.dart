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
  DateTime startDate;
  DateTime endDate;
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("START DATE"), Text("END DATE")],
          ),
          SizedBox(height: 20,),
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
      ),
    );
  }

  Column _buildSuccessState(SamplesSuccessState state) {
    return Column(
      children: [
        GlucoseLineChart(state.data),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildValueWidget(label: "Minimum", value: state.data.minValue),
            _buildValueWidget(label: "Maximum", value: state.data.maxValue),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildValueWidget(label: "Avarage", value: state.data.avrageValue),
            _buildValueWidget(label: "Median", value: state.data.medianValue),
          ],
        )
      ],
    );
  }

  Widget _buildValueWidget({String label, double value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${value}",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
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
