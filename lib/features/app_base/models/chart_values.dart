import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartValues {
  List<FlSpot> spots;
  Color color;

  String chartTitle;
  bool? isStanderd;
  ChartValues(
      {required this.color,
      required this.spots,
      required this.chartTitle,
      this.isStanderd = false});
}
