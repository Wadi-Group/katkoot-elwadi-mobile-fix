import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_chart_widget.dart';
import 'package:katkoot_elwady/features/tools_management/entities/rearing_data_graph_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cycle.dart';

class RearingDataGraphViewModel
    extends StateNotifier<BaseState<RearingDataGraphState>> {
  CbCycle? _cycle;

  RearingDataGraphViewModel(this._cycle)
      : super(BaseState(data: RearingDataGraphState()));

  getRearingChartData() {
    List<FlSpot> femaleWeightPoints = [],
        femaleWeightStandardPoints = [],
        maleWeightPoints = [],
        maleWeightStandardPoints = [],
        cumulativeFemaleMortPercentagePoints = [],
        cumulativeFemaleMortPercentageStandardPoints = [];

    for (int index = (AppConstants.REARING_MIN_VALUE - 1);
        index < AppConstants.REARING_MAX_VALUE;
        index++) {
      var previewData = _cycle?.weeksList?[index].value?.previewData;
      femaleWeightPoints
          .add(FlSpot(index + 1, previewData?.femaleWeight?.value ?? 0));
      femaleWeightStandardPoints
          .add(FlSpot(index + 1, previewData?.femaleWeight?.standard ?? 0));
      maleWeightPoints
          .add(FlSpot(index + 1, previewData?.maleWeight?.value ?? 0));
      maleWeightStandardPoints
          .add(FlSpot(index + 1, previewData?.maleWeight?.standard ?? 0));
      cumulativeFemaleMortPercentagePoints.add(FlSpot(
          index + 1, previewData?.cumulativeFemaleMortPercentage?.value ?? 0));
      cumulativeFemaleMortPercentageStandardPoints.add(FlSpot(index + 1,
          previewData?.cumulativeFemaleMortPercentage?.standard ?? 0));
    }

    List<ChartValues> chartValues = [];
    List<ChartValues> secondChartValues = [];

    chartValues.add(ChartValues(
        chartTitle: 'female_weight'.tr(),
        spots: femaleWeightPoints,
        color: Colors.green));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'female_weight_standard'.tr(),
        spots: femaleWeightStandardPoints,
        color: Colors.green.withOpacity(0.5)));
    chartValues.add(ChartValues(
        chartTitle: 'male_weight'.tr(),
        spots: maleWeightPoints,
        color: Colors.red));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'male_weight_standard'.tr(),
        spots: maleWeightStandardPoints,
        color: Colors.red.withOpacity(0.5)));
    secondChartValues.add(ChartValues(
        chartTitle: 'cumulative_mort_percentage'.tr(),
        spots: cumulativeFemaleMortPercentagePoints,
        color: Colors.blue));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'cumulative_mort_percentage_standard'.tr(),
        spots: cumulativeFemaleMortPercentageStandardPoints,
        color: Colors.blue.withOpacity(0.5)));

    state = BaseState(
        data: state.data.copyWith(
            rearingChartValues: chartValues,
            secondRearingChartValues: secondChartValues));
  }

  getFeedingChartData() {
    List<FlSpot> femaleFeedPoints = [],
        femaleFeedStandardPoints = [],
        maleFeedPoints = [],
        maleFeedStandardPoints = [];

    for (int index = (AppConstants.REARING_MIN_VALUE - 1);
        index < AppConstants.REARING_MAX_VALUE;
        index++) {
      var previewData = _cycle?.weeksList?[index].value?.previewData;
      femaleFeedPoints
          .add(FlSpot(index + 1, previewData?.femaleFeed?.value ?? 0));
      femaleFeedStandardPoints
          .add(FlSpot(index + 1, previewData?.femaleFeed?.standard ?? 0));
      maleFeedPoints.add(FlSpot(index + 1, previewData?.maleFeed?.value ?? 0));
      maleFeedStandardPoints
          .add(FlSpot(index + 1, previewData?.maleFeed?.standard ?? 0));
    }

    List<ChartValues> chartValues = [];
    chartValues.add(ChartValues(
        chartTitle: 'female_feed'.tr(),
        spots: femaleFeedPoints,
        color: Colors.green));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'female_feed_standard'.tr(),
        spots: femaleFeedStandardPoints,
        color: Colors.green.withOpacity(0.5)));
    chartValues.add(ChartValues(
        chartTitle: 'male_feed'.tr(),
        spots: maleFeedPoints,
        color: Colors.red));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'male_feed_standard'.tr(),
        spots: maleFeedStandardPoints,
        color: Colors.red.withOpacity(0.5)));

    state =
        BaseState(data: state.data.copyWith(feedingChartValues: chartValues));
  }

  selectRearingTab() {
    state = BaseState(data: state.data.copyWith(rearingTabSelected: true));
  }

  selectFeedingTab() {
    state = BaseState(data: state.data.copyWith(rearingTabSelected: false));
  }

  changeSelectedChart(int selectedNumber) {
    state = BaseState(
        data: state.data.copyWith(selectedChartValue: selectedNumber));
    print(state.data);
  }

  List<ChartValues> getSelectedChartData() {
    int? selectedNumber = state.data.selectedChartValue;

    if (selectedNumber == 2)
      return state.data.secondRearingChartValues!;
    else
      return state.data.rearingChartValues!;
  }

  double getChartScrollViewOffSet(BuildContext context, int selectedWeek,
      ScrollController scrollController) {
    double horizontalChartPadding = 30;
    double chartHorizontalWidth = (MediaQuery.of(context).size.width *
            CustomLineChart.chartScrollingViewWidthMultiplier) -
        horizontalChartPadding;
    int sliderValuesNumber =
        AppConstants.REARING_MAX_VALUE - AppConstants.REARING_MIN_VALUE;
    double oneWeekWidthOnChartView = chartHorizontalWidth / sliderValuesNumber;
    double weekXOffset = oneWeekWidthOnChartView * selectedWeek;
    double halfTheScreenWidth = (MediaQuery.of(context).size.width / 2);
    double minXOffset = weekXOffset - halfTheScreenWidth;

    return minXOffset;
  }
}
