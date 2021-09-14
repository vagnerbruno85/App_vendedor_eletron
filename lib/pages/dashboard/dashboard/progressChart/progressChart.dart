import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'progressSeries.dart';

class ProgressChart extends StatelessWidget {
  final List<ProgressSeries> data;
  ProgressChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ProgressSeries, num>> series = [
      charts.Series(
        id: "progress",
        data: data,
        domainFn: (ProgressSeries series, _) => series.day,
        measureFn: (ProgressSeries series, _) => series.progress,
        colorFn: (ProgressSeries series, _) => series.barColor,
        labelAccessorFn: (ProgressSeries series, _) => '${series.day}',
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(15),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Text("Progresso De Vendas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Expanded(
                child: charts.LineChart(series,
                domainAxis: new charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
                  viewport: charts.NumericExtents(firstOne, lastOne),
                  ),
                animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}