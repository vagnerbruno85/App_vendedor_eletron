import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'salesSeries.dart';

class SalesChart extends StatelessWidget {
  final List<SalesSeries> data;

  SalesChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesSeries, String>> series = [
      charts.Series(
        id: "sales",
        data: data,
        domainFn: (SalesSeries series, _) => series.category,
        measureFn: (SalesSeries series, _) => series.sales,
        colorFn: (SalesSeries series, _) => series.barColor,
        labelAccessorFn: (SalesSeries series, _) => '${series.category}',
      )
    ];

    return Container(
      height: 400,
      width: 400,
      padding: EdgeInsets.all(15),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Text("Vendas Por Categoria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Expanded(
                child: charts.PieChart(
                  series, 
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig<Object>(
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside,
                        insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15, color: charts.Color.fromHex(code: '#FFFFFF'))
                      )
                    ] //arcRendererDecorators
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}