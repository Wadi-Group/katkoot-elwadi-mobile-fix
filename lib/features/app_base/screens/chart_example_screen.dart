import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_chart_widget.dart';

// this screen is only for test as a demo for charts and is not related to the project

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  @override
  void initState() {
    super.initState();
  }

  var val = [
    ChartValues(
        color: Colors.green,
        spots: [
          FlSpot(1, 1),
          FlSpot(2, 4),
          FlSpot(3, 9),
          FlSpot(5, 16),
          FlSpot(6, 16),
          FlSpot(7, 9),
          FlSpot(8, 20),
          FlSpot(9, 30),
        ],
        chartTitle: "title random 3"),
    ChartValues(
        color: Colors.red,
        spots: [
          FlSpot(1, 1),
          FlSpot(2, 2),
          FlSpot(3, 7),
          FlSpot(4, 14),
          FlSpot(5, 14),
          FlSpot(6, 7),
          FlSpot(7, 2),
          FlSpot(8, 10),
        ],
        chartTitle: "title random 2"),
    ChartValues(
        color: Colors.blue,
        spots: [
          FlSpot(1, 4),
          FlSpot(2, 7),
          FlSpot(3, 2),
          FlSpot(5, 5),
          FlSpot(7, 25),
          FlSpot(8, 7),
          FlSpot(9, 9),
          FlSpot(10, 10),
        ],
        chartTitle: "title random 1"),
    ChartValues(
        color: Colors.yellow,
        spots: [
          FlSpot(1, 5),
          FlSpot(2, 9),
          FlSpot(3, 12),
          FlSpot(5, 19),
          FlSpot(7, 10),
          FlSpot(8, 5),
          FlSpot(9, 3),
          FlSpot(10, 1),
        ],
        chartTitle: "title random 4"),
    ChartValues(
        color: Colors.indigo,
        spots: [
          FlSpot(1, 7),
          FlSpot(2, 4),
          FlSpot(3, 9),
          FlSpot(5, 5),
          FlSpot(7, 5),
          FlSpot(8, 3),
          FlSpot(9, 8),
          FlSpot(10, 2),
        ],
        chartTitle: "title random 5"),
    ChartValues(
        color: Colors.black,
        spots: [
          FlSpot(1, 20),
          FlSpot(2, 23),
          FlSpot(3, 12),
          FlSpot(5, 14),
          FlSpot(7, 17),
          FlSpot(8, 1),
          FlSpot(9, 5),
          FlSpot(10, 7),
        ],
        chartTitle: "title random 6"),
    ChartValues(
        color: Colors.cyanAccent,
        spots: [
          FlSpot(1, 7),
          FlSpot(2, 2),
          FlSpot(3, 8),
          FlSpot(5, 25),
          FlSpot(7, 5),
          FlSpot(8, 4),
          FlSpot(9, 1),
          FlSpot(10, 8),
        ],
        chartTitle: "title random 7"),
    ChartValues(
        color: Colors.orangeAccent,
        spots: [
          FlSpot(1, 8),
          FlSpot(2, 12),
          FlSpot(3, 14),
          FlSpot(5, 18),
          FlSpot(7, 11),
          FlSpot(8, 5),
          FlSpot(9, 1),
          FlSpot(10, 26),
        ],
        chartTitle: "title random 8"),
    ChartValues(
        color: Colors.teal,
        spots: [
          FlSpot(1, 15),
          FlSpot(2, 12),
          FlSpot(3, 4),
          FlSpot(5, 5),
          FlSpot(7, 8),
          FlSpot(8, 9),
          FlSpot(9, 1),
          FlSpot(10, 20),
        ],
        chartTitle: "title random 9"),
    ChartValues(
        color: Colors.purple,
        spots: [
          FlSpot(0, 1),
          FlSpot(2, 4),
          FlSpot(3, 13),
          FlSpot(5, 17),
          FlSpot(7, 19),
          FlSpot(8, 25),
          FlSpot(9, 6),
          FlSpot(10, 20),
        ],
        chartTitle: "title random 10"),
  ];
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomLineChart(
             chartSize: MediaQuery.of(context).size.height * 0.4,
            currentSelectedIndex: ind,
            chartsValues: val,
            minX: 0,
            maxX: 10,
          ),
          ElevatedButton(onPressed: changePlusIndex, child: Text("increase")),
          ElevatedButton(onPressed: changeSubIndex, child: Text("decrease")),
          ElevatedButton(onPressed: changeData, child: Text("change data")),
        ],
      ),
    );
  }

  changePlusIndex() {
    setState(() {
      ind = ind + 1;
    });
  }

  changeSubIndex() {
    setState(() {
      ind = ind - 1;
    });
  }

  changeData() {
    setState(() {
      val = [
        ChartValues(
            color: Colors.cyanAccent,
            spots: [
              FlSpot(1, 7),
              FlSpot(2, 2),
              FlSpot(3, 8),
              FlSpot(5, 25),
              FlSpot(7, 5),
              FlSpot(8, 4),
              FlSpot(9, 1),
              FlSpot(10, 8),
            ],
            chartTitle: "title random 7"),
        ChartValues(
            color: Colors.orangeAccent,
            spots: [
              FlSpot(1, 8),
              FlSpot(2, 12),
              FlSpot(3, 14),
              FlSpot(5, 18),
              FlSpot(7, 11),
              FlSpot(8, 5),
              FlSpot(9, 1),
              FlSpot(10, 26),
            ],
            chartTitle: "title random 8"),
        ChartValues(
            color: Colors.teal,
            spots: [
              FlSpot(1, 15),
              FlSpot(2, 12),
              FlSpot(3, 4),
              FlSpot(5, 5),
              FlSpot(7, 8),
              FlSpot(8, 9),
              FlSpot(9, 1),
              FlSpot(10, 20),
            ],
            chartTitle: "title random 9")
      ];
    });
  }
}
