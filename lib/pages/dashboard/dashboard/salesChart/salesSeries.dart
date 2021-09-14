import 'package:charts_flutter/flutter.dart' as charts;

class SalesSeries {
  final String category;
  final int sales;
  final charts.Color barColor;

  SalesSeries(
    {
      required this.category,
      required this.sales,
      required this.barColor
    }
  );
}