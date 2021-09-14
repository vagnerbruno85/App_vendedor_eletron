import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'progressSeries.dart';
import 'progressChart.dart';

class ProgressLineChart extends StatelessWidget {
  final List<ProgressSeries> data = [

    ProgressSeries(
      day: firstOne,
      progress: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: secondOne,
      progress: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: thirdOne,
      progress: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: fourthOne,
      progress: 3500,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: fifthOne,
      progress: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: sixthOne,
      progress: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ProgressSeries(
      day: lastOne,
      progress: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
     child: ProgressChart(
          data: data,
        ),
    );
  }
}