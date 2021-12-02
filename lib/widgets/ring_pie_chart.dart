// ================= Ring Pie Chart Widget =================
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:balance_me/global/constants.dart' as gc;

/*
* The widget receives a List of Json, each includes 'name' [String], 'percentage' [num], and 'color' [Color]:
* [{"name": [String], 'percentage': [num], 'color': [Color]}, ... ]
* The widgets presents a ring pie chart and the total percentage (can be above 100%) in the middle.
* If the total percentage is below 100%, the widgets complete it to 100% automatically.
* For presenting a legend (names fields in data), pass legendTitle to the constructor- else pass null.
*/

class RingPieChart extends StatelessWidget {
  RingPieChart(List<Map<String, Object>> chartDataList, this._legendTitle, {Key? key}) : super(key: key) {
    parseChartData(chartDataList);
  }

  final String? _legendTitle;
  List<ChartData>? _chartData;
  double? _totalPercentage;

  void parseChartData(List<Map<String, Object>> chartDataList) {
    List<ChartData> chartData = [];
    double totalPercentage = 0;

    for (var data in chartDataList) {
      totalPercentage += (data['percentage'] as num).toDouble();
      chartData.add(ChartData(data['name'] as String, (data['percentage'] as num).toDouble(), data['color'] as Color));
    }

    if (totalPercentage < 100) {
      chartData.add(ChartData(gc.pieCharDefaultCategory, 100 - totalPercentage, gc.pieCharDefaultCategoryColor));
    }

    _chartData = chartData;
    _totalPercentage = totalPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(child: Text(
          _totalPercentage!.toInt().toString() + "%",
          style: TextStyle(fontSize: 50, color: gc.pieChartCenterText),
        )),
        SfCircularChart(
            legend: Legend(
              isVisible: _legendTitle != null,
              position: gc.pieChartLegendPosition,
              title: LegendTitle(
                text: _legendTitle,
              ),
            ),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                  dataSource: _chartData!,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  innerRadius: gc.pieChartInnerRadius),
            ]),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
