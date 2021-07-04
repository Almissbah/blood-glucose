import 'package:blood_glucose/domain/model/samples_data_model.dart';
import 'package:blood_glucose/presentation/bloc/samples_bloc.dart';
import 'package:blood_glucose/presentation/ui/widget/line_chart.dart';
import 'package:blood_glucose/presentation/utils/date_time_utils.dart';
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
  DateTime _startDate;
  DateTime _endDate;
  @override
  void initState() {
    _samplesBloc = BlocProvider.of<SamplesBloc>(context);
    _loadSamples();
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

  Widget _datePickerWidget(
      {Function(DateTime date) onPicked, String label, DateTime currentDate}) {
    return InkWell(
      onTap: () {
        DateTimeUtils.showDatePicker(context, onConfirm: onPicked,currentTime:currentDate );
      },
      child: Container(
        child: Column(
          children: [
            Text(label),
            Text(
              " ${currentDate != null ? DateTimeUtils.formatDate(currentDate) : ""}",
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  _loadSamples() {
    _samplesBloc.loadSamples(startDate: _startDate, endDate: _endDate);
  }

  Column _buildSuccessState(SamplesSuccessState state) {
    return Column(
      children: [
        _buildDatePickers(state.data),
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

  Widget _buildLoadingState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Container(child: CircularProgressIndicator())],
    );
  }

  _buildDatePickers(SamplesDataModel data) {
    _startDate = data.startDate;
    _endDate = data.endDate;
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _datePickerWidget(
              label: "START DATE",
              currentDate: _startDate,
              onPicked: (date) {
                setState(() {
                  _startDate = date;
                  _loadSamples();
                });
              },
            ),
            _datePickerWidget(
              label: "END DATE",
              currentDate: _endDate,
              onPicked: (date) {
                setState(() {
                  _endDate = date;
                  _loadSamples();
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _buildFailuerState {}
