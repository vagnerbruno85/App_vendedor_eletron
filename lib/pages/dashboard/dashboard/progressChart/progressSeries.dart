import 'package:charts_flutter/flutter.dart' as charts;

DateTime now = DateTime.now();
int currentDay = now.weekday;
DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
DateTime secondDayOfWeek = now.subtract(Duration(days: currentDay - 1));
DateTime thirdDayOfWeek = now.subtract(Duration(days: currentDay - 2));
DateTime fourthDayOfWeek = now.subtract(Duration(days: currentDay - 3));
DateTime fifthDayOfWeek = now.subtract(Duration(days: currentDay - 4));
DateTime sixthDayOfWeek = now.subtract(Duration(days: currentDay - 5));
DateTime lastDayOfWeek = now.subtract(Duration(days: currentDay - 6));

int firstOne = firstDayOfWeek.day;
int secondOne = secondDayOfWeek.day;
int thirdOne = thirdDayOfWeek.day;
int fourthOne = fourthDayOfWeek.day;
int fifthOne = fifthDayOfWeek.day;
int sixthOne = sixthDayOfWeek.day;
int lastOne = lastDayOfWeek.day;

class ProgressSeries {
  final int day;
  final int progress;
  final charts.Color barColor;

  ProgressSeries(
    {
      required this.day,
      required this.progress,
      required this.barColor
    }
  );
}