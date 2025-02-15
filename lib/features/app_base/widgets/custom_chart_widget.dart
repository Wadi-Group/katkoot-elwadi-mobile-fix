import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_icons.dart';
import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CustomLineChart extends StatefulWidget {
  static const chartScrollingViewWidthMultiplier = 3;

  List<ChartValues> chartsValues;

  double minX;
  double maxX;
  double? chartSize;
  EdgeInsets? padding;
  EdgeInsets? margin;
  int currentSelectedIndex;
  List<String>? bottomTitles;
  List<String>? sideTitles;
  ScrollController? scrollController;

  CustomLineChart({
    required this.currentSelectedIndex,
    required this.chartsValues,
    required this.minX,
    required this.maxX,
    this.scrollController,
    this.chartSize,
    this.padding,
    this.margin,
    this.bottomTitles,
    this.sideTitles,
  });

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  Map<String, bool> chartsState = {};
  //double maxVisvibleY = 0;
  //TextDirection? direction = TextDirection.RTL;

  @override
  void initState() {
    super.initState();

    widget.chartsValues.forEach((element) {
      chartsState.putIfAbsent(element.chartTitle, () => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasNewCharts = false;
    widget.chartsValues.forEach((element) {
      var innerKey = chartsState.containsKey(element.chartTitle);
      if (!innerKey) {
        hasNewCharts = true;
      }
    });
    if (hasNewCharts) {
      chartsState.clear();

      widget.chartsValues.forEach((element) {
        chartsState.putIfAbsent(element.chartTitle, () => true);
      });
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Container(
        padding: widget.padding ?? EdgeInsets.zero,
        margin: widget.margin ?? EdgeInsets.zero,
        color: Colors.white,
        // ignore: prefer_if_null_operators
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ExpandablePanel(
              theme: ExpandableThemeData(hasIcon: false),
              header: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/group_3342.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("filter".tr(),
                          style:
                              TextStyle(color: AppColors.Liver, fontSize: 17)),
                    ],
                  )),
              collapsed: Container(
                height: widget.chartSize != null
                    ? widget.chartSize
                    : MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.7
                        : MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        CustomLineChart.chartScrollingViewWidthMultiplier,
                    child: InteractiveViewer(
                      child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 15, bottom: 10, end: 15),
                          child: LineChart(
                            sampleData1,
                            // swapAnimationDuration:
                            //     const Duration(milliseconds: 250),
                          )),
                    ),
                  ),
                ),
              ),
              expanded: Column(
                children: [
                  Container(
                    height: widget.chartSize != null
                        ? widget.chartSize
                        : MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.7
                            : MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      controller: widget.scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            CustomLineChart.chartScrollingViewWidthMultiplier,
                        child: InteractiveViewer(
                          child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 15, bottom: 10, end: 15),
                              child: LineChart(
                                sampleData1,
                                // swapAnimationDuration:
                                //     const Duration(milliseconds: 250),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      ...widget.chartsValues
                          .map((e) => TextButton.icon(
                              onPressed: chartsState[e.chartTitle] != null
                                  ? () => setState(() {
                                        chartsState[e.chartTitle] =
                                            !chartsState[e.chartTitle]!;
                                      })
                                  : null,
                              icon: Icon(AppIcons.chart,
                                  size: 12,
                                  color: (chartsState[e.chartTitle] != null &&
                                          chartsState[e.chartTitle] == true)
                                      ? e.color
                                      : AppColors.Ash_grey),
                              label: Container(
                                padding: EdgeInsetsDirectional.only(start: 15),
                                child: CustomText(
                                  title: e.chartTitle,
                                  textColor:
                                      (chartsState[e.chartTitle] != null &&
                                              chartsState[e.chartTitle] == true)
                                          ? e.color
                                          : AppColors.Ash_grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              )))
                          .toList()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData get sampleData1 {
    List<LineBarSpot> spotsBars = [];

    widget.chartsValues.forEach((e) {
      if (chartsState[e.chartTitle] != null &&
          chartsState[e.chartTitle] == true) {
        spotsBars.add(LineBarSpot(
            lineChartBarData1_1(e.spots, e.color, e.isStanderd!),
            widget.currentSelectedIndex,
            e.spots[widget.currentSelectedIndex]));
      }
    });

    return LineChartData(
      // showingTooltipIndicators: [ShowingTooltipIndicators(spotsBars)],
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: widget.minX,
      maxX: widget.maxX,
      // maxY: maxVisvibleY != 0 ? maxVisvibleY : 100,
      minY: 0,
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        enabled: false,
        // handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor:   (spot) => Colors.blueGrey.withValues(alpha:  .3),
          // tooltipBgColor: Colors.blueGrey.withOpacity(0.3),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles:  AxisTitles( sideTitles:  bottomTitles) ,
    rightTitles: AxisTitles( sideTitles:  SideTitles(showTitles: false)),
    topTitles: AxisTitles( sideTitles:  SideTitles(showTitles: false)),
        // leftTitles: sideTitles(getTitles: (value) {
        //   var maxY = widget.chartsValues
        //       .map((e) =>
        //       e.spots.reduce((curr, next) => curr.y > next.y ? curr : next))
        //       .map((e) => e.y)
        //       .reduce((curr, next) => curr > next ? curr : next);
        //
        //   int interval = (maxY / 8).toInt();
        //   if (value % interval == 0) {
        //     return value.toString();
        //   }
        //   return "";
        // })
      );

  List<LineChartBarData> get lineBarsData1 {
    return widget.chartsValues.map((e) {
      if (chartsState[e.chartTitle] != null &&
          chartsState[e.chartTitle] == true) {
        return lineChartBarData1_1(e.spots, e.color, e.isStanderd!);
      }
      return LineChartBarData();
    }).toList();
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 14,
    // margin: 10,
    interval: 1,
    // getTextStyles: (context, value) => const TextStyle(
    //   color: Color(0xff72719b),
    //   fontSize: 14,
    // ),
    getTitlesWidget: (value , index)  {
      // print(value);
      return  CustomText(
        title: value.toString(),
        textColor: Color(0xff72719b),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );
    },
  );

  FlGridData get gridData => FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.blueGrey,
          strokeWidth: 0.2,
          dashArray: [4, 8],
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.blueGrey,
          strokeWidth: 0.2,
          dashArray: [4, 8],
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 1),
          left: BorderSide(color: Color(0xff4e4965), width: 1),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData lineChartBarData1_1(
          List<FlSpot> spots, Color? lineColor, bool isStanderd) =>
      LineChartBarData(
          isCurved: false,
          showingIndicators: [widget.currentSelectedIndex],
          color: lineColor ?? Colors.green,
          barWidth: 1.5,
          dashArray: isStanderd ? [5] : null,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            checkToShowDot: (spot, barData) =>
                spot == barData.spots[widget.currentSelectedIndex],
          ),
          belowBarData: BarAreaData(show: false),
          spots: spots);
}
