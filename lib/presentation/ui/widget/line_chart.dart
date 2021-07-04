import 'package:blood_glucose/domain/model/samples_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GlucoseLineChart extends StatefulWidget {
  final SamplesDataModel data;
  const GlucoseLineChart(this.data, {Key key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<GlucoseLineChart> {
  bool heightlightMax = true;
  bool heightlightMin = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 500,
      child: LineChart(
        LineChartData(
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                  dotData: FlDotData(
                    checkToShowDot: (spot, barData) {
                      return true;
                    },
                    getDotPainter: (spot, percent, barData, index) {
                      if (barData.spots[index].y == widget.data.maxValue &&
                          heightlightMax) {
                        return FlDotCirclePainter(
                            radius: 0,
                            color: Colors.white,
                            strokeWidth: 8,
                            strokeColor: Colors.green);
                      } else if (barData.spots[index].y ==
                              widget.data.minValue &&
                          heightlightMin) {
                        return FlDotTringlePainter(
                          size: 16,
                          color: Colors.white,
                          strokeWidth: 5,
                          strokeColor: Colors.deepOrange,
                        );
                      }
                      return FlDotCirclePainter(
                          radius: 2,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: Colors.deepOrange);
                    },
                  ),
                  spots: _get100ItemsList())
            ],
            titlesData: FlTitlesData(
              show: false,
              bottomTitles: SideTitles(showTitles: true, interval: 2),
            ),
            axisTitleData: FlAxisTitleData(
                bottomTitle: AxisTitle(titleText: "Time", showTitle: true),
                leftTitle: AxisTitle(titleText: "value", showTitle: true))),
      ),
    );
  }

  highlightMax() {
    setState(() {
      heightlightMax = true;
    });
  }

  highlightMin() {
    setState(() {
      heightlightMin = true;
    });
  }

  resetHighlight() {
    setState(() {
      heightlightMax = false;
      heightlightMin = false;
    });
  }

List<FlSpot>  _get100ItemsList() {
    var list = widget.data.samples
        .map((e) => FlSpot(
            (e.timeStamp.millisecondsSinceEpoch/1000000)
                .toDouble(),
            e.value))
        .toList()
        .getRange(0, 100)
        .toList();
    return list;
  }
}

class FlDotTringlePainter extends FlDotPainter {
  Color color;

  double size;

  Color strokeColor;

  double strokeWidth;
  FlDotTringlePainter({
    Color color,
    double size,
    Color strokeColor,
    double strokeWidth,
  })  : color = color ?? Colors.green,
        size = size ?? 4.0,
        strokeColor = strokeColor ?? Colors.green,
        strokeWidth = strokeWidth ?? 1.0;

  Path getTrianglePath(double x, double y, {double width = 10}) {
    return Path()
      ..moveTo(x, y - width * 2)
      ..lineTo(x - width * 2, y + width)
      ..lineTo(x + width * 2, y + width)
      ..close();
  }

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    canvas.drawPath(
        getTrianglePath(offsetInCanvas.dx, offsetInCanvas.dy),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill);
  }

  @override
  Size getSize(FlSpot spot) {
    return Size(size, size);
  }

  @override
  List<Object> get props => [
        color,
        size,
        strokeColor,
        strokeWidth,
      ];
}
