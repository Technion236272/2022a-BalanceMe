// ================= Ring Pie Chart Widget =================
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:balance_me/global/constants.dart' as gc;

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

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
      children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  _totalPercentage!.toString() + "%",
                  style: TextStyle(fontSize: 50, color: gc.pieChartCenterText),
                ),
              ),
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
