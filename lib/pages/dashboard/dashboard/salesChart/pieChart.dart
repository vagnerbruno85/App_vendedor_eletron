import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'salesSeries.dart';
import 'salesChart.dart';

class SalesPieChart extends StatelessWidget {
  final List<SalesSeries> data = [

    SalesSeries(
      category: "Celulares",
      sales: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    SalesSeries(
      category: "Notebooks",
      sales: 5000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SalesSeries(
      category: "Televisões",
      sales: 4000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesSeries(
      category: "Video-games",
      sales: 3500,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
     child: SalesChart(
          data: data,
        ),
    );
  }
}