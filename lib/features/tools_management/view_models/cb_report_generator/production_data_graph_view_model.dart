import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_chart_widget.dart';
import 'package:katkoot_elwady/features/tools_management/entities/production_data_graph_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cycle.dart';

class ProductionDataGraphViewModel
    extends StateNotifier<BaseState<ProductionDataGraphState>> {
  CbCycle? _CbCycle;

  ProductionDataGraphViewModel(this._CbCycle)
      : super(BaseState(data: ProductionDataGraphState()));

  getProductionChartData() {
    List<FlSpot> femaleWeightPoints = [],
        femaleWeightStandardPoints = [],
        maleWeightPoints = [],
        maleWeightStandardPoints = [],
        femaleFeedPoints = [],
        femaleFeedStandardPoints = [],
        maleFeedPoints = [],
        maleFeedStandardPoints = [],
        eggWeightPoints = [],
        eggWeightStandardPoints = [],
        hatchedHenPercentagePoints = [],
        hatchedHenPercentageStandardPoints = [],
        hatchedWeightPercentagePoints = [],
        hatchedWeightPercentageStandardPoints = [],
        cumulativeFemaleMortPercentagePoints = [],
        cumulativeFemaleMortPercentageStandardPoints = [],
        lightingProgramPoints = [],
        lightingProgramStandardPoints = [];

    for (int index = (AppConstants.PRODUCTION_MIN_VALUE - 1);
        index < AppConstants.PRODUCTION_MAX_VALUE;
        index++) {
      var previewData = _CbCycle?.weeksList?[index].value?.previewData;

      femaleWeightPoints
          .add(FlSpot(index + 1, previewData?.femaleWeight?.value ?? 0));
      femaleWeightStandardPoints
          .add(FlSpot(index + 1, previewData?.femaleWeight?.standard ?? 0));
      maleWeightPoints
          .add(FlSpot(index + 1, previewData?.maleWeight?.value ?? 0));
      maleWeightStandardPoints
          .add(FlSpot(index + 1, previewData?.maleWeight?.standard ?? 0));
      femaleFeedPoints
          .add(FlSpot(index + 1, previewData?.femaleFeed?.value ?? 0));
      femaleFeedStandardPoints
          .add(FlSpot(index + 1, previewData?.femaleFeed?.standard ?? 0));
      maleFeedPoints.add(FlSpot(index + 1, previewData?.maleFeed?.value ?? 0));
      maleFeedStandardPoints
          .add(FlSpot(index + 1, previewData?.maleFeed?.standard ?? 0));
      eggWeightPoints
          .add(FlSpot(index + 1, previewData?.eggWeight?.value ?? 0));
      eggWeightStandardPoints
          .add(FlSpot(index + 1, previewData?.eggWeight?.standard ?? 0));
      hatchedHenPercentagePoints.add(
          FlSpot(index + 1, previewData?.hatchedHenPercentage?.value ?? 0));
      hatchedHenPercentageStandardPoints.add(
          FlSpot(index + 1, previewData?.hatchedHenPercentage?.standard ?? 0));
      hatchedWeightPercentagePoints.add(
          FlSpot(index + 1, previewData?.hatchedWeightPercentage?.value ?? 0));
      hatchedWeightPercentageStandardPoints.add(FlSpot(
          index + 1, previewData?.hatchedWeightPercentage?.standard ?? 0));
      cumulativeFemaleMortPercentagePoints.add(FlSpot(
          index + 1, previewData?.cumulativeFemaleMortPercentage?.value ?? 0));
      cumulativeFemaleMortPercentageStandardPoints.add(FlSpot(index + 1,
          previewData?.cumulativeFemaleMortPercentage?.standard ?? 0));
      lightingProgramPoints
          .add(FlSpot(index + 1, previewData?.lightingProgram?.value ?? 0));
      lightingProgramStandardPoints
          .add(FlSpot(index + 1, previewData?.lightingProgram?.standard ?? 0));
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
    chartValues.add(ChartValues(
        chartTitle: 'female_feed'.tr(),
        spots: femaleFeedPoints,
        color: Colors.blueAccent));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'female_feed_standard'.tr(),
        spots: femaleFeedStandardPoints,
        color: Colors.blueAccent.withOpacity(0.5)));
    chartValues.add(ChartValues(
        chartTitle: 'male_feed'.tr(),
        spots: maleFeedPoints,
        color: Colors.blueGrey));
    chartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'male_feed_standard'.tr(),
        spots: maleFeedStandardPoints,
        color: Colors.blueGrey.withOpacity(0.5)));

    secondChartValues.add(ChartValues(
        chartTitle: 'egg_weight'.tr(),
        spots: eggWeightPoints,
        color: Colors.yellow));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'egg_weight_standard'.tr(),
        spots: eggWeightStandardPoints,
        color: Colors.yellow.withOpacity(0.5)));
    secondChartValues.add(ChartValues(
        chartTitle: 'hatched_hen_percentage'.tr(),
        spots: hatchedHenPercentagePoints,
        color: Colors.deepPurpleAccent));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'hatched_hen_percentage_standard'.tr(),
        spots: hatchedHenPercentageStandardPoints,
        color: Colors.deepPurpleAccent.withOpacity(0.5)));
    secondChartValues.add(ChartValues(
        chartTitle: 'hatched_weight_percentage'.tr(),
        spots: hatchedWeightPercentagePoints,
        color: Colors.black));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'hatched_weight_percentage_standard'.tr(),
        spots: hatchedWeightPercentageStandardPoints,
        color: Colors.black.withOpacity(0.5)));
    secondChartValues.add(ChartValues(
        chartTitle: 'cumulative_mort_percentage'.tr(),
        spots: cumulativeFemaleMortPercentagePoints,
        color: Colors.orange));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'cumulative_mort_percentage_standard'.tr(),
        spots: cumulativeFemaleMortPercentageStandardPoints,
        color: Colors.orange.withOpacity(0.5)));
    secondChartValues.add(ChartValues(
        chartTitle: 'lighting_program'.tr(),
        spots: lightingProgramPoints,
        color: Colors.purpleAccent));
    secondChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'lighting_program_standard'.tr(),
        spots: lightingProgramStandardPoints,
        color: Colors.purpleAccent.withOpacity(0.5)));

    state = BaseState(
        data: state.data.copyWith(
            productionChartValues: chartValues,
            secondProductionChartValues: secondChartValues));
  }

  getPerformanceChartsData() {
    List<FlSpot> eggMassPoints = [],
        eggMassStandardPoints = [],
        totalEggPerHatchedHenPoints = [],
        totalEggPerHatchedHenStandardPoints = [],
        hatchedEggPerHatchedHenPoints = [],
        hatchedEggPerHatchedHenStandardPoints = [],
        cumulativeUtilizePoints = [],
        cumulativeUtilizeStandardPoints = [];

    for (int index = (AppConstants.PRODUCTION_MIN_VALUE - 1);
        index < AppConstants.PRODUCTION_MAX_VALUE;
        index++) {
      var previewData = _CbCycle?.weeksList?[index].value?.previewData;
      eggMassPoints.add(FlSpot(index + 1, previewData?.eggMass?.value ?? 0));
      eggMassStandardPoints
          .add(FlSpot(index + 1, previewData?.eggMass?.standard ?? 0));

      totalEggPerHatchedHenPoints.add(
          FlSpot(index + 1, previewData?.totalEggPerHatchedHen?.value ?? 0));
      totalEggPerHatchedHenStandardPoints.add(
          FlSpot(index + 1, previewData?.totalEggPerHatchedHen?.standard ?? 0));

      hatchedEggPerHatchedHenPoints.add(
          FlSpot(index + 1, previewData?.hatchedEggPerHatchedHen?.value ?? 0));
      hatchedEggPerHatchedHenStandardPoints.add(FlSpot(
          index + 1, previewData?.hatchedEggPerHatchedHen?.standard ?? 0));

      cumulativeUtilizePoints
          .add(FlSpot(index + 1, previewData?.cumulativeUtilize?.value ?? 0));
      cumulativeUtilizeStandardPoints.add(
          FlSpot(index + 1, previewData?.cumulativeUtilize?.standard ?? 0));
    }

    List<ChartValues> eggMassChartValues = [];
    eggMassChartValues.add(ChartValues(
        chartTitle: 'egg_mass'.tr(),
        spots: eggMassPoints,
        color: Colors.blueAccent));
    eggMassChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'egg_mass_standard'.tr(),
        spots: eggMassStandardPoints,
        color: Colors.blueAccent.withOpacity(0.5)));

    List<ChartValues> totalEggPerHatchedHenChartValues = [];
    totalEggPerHatchedHenChartValues.add(ChartValues(
        chartTitle: 'total_egg_per_hatched_hen'.tr(),
        spots: totalEggPerHatchedHenPoints,
        color: Colors.red));
    totalEggPerHatchedHenChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'total_egg_per_hatched_hen_standard'.tr(),
        spots: totalEggPerHatchedHenStandardPoints,
        color: Colors.red.withOpacity(0.5)));

    List<ChartValues> hatchedEggPerHatchedHenChartValues = [];
    hatchedEggPerHatchedHenChartValues.add(ChartValues(
        chartTitle: 'hatched_egg_per_hatched_hen'.tr(),
        spots: hatchedEggPerHatchedHenPoints,
        color: Colors.purpleAccent));
    hatchedEggPerHatchedHenChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'hatched_egg_per_hatched_hen_standard'.tr(),
        spots: hatchedEggPerHatchedHenStandardPoints,
        color: Colors.purpleAccent.withOpacity(0.5)));

    List<ChartValues> cumulativeUtilizeChartValues = [];
    cumulativeUtilizeChartValues.add(ChartValues(
        chartTitle: 'cumulative_utilize'.tr(),
        spots: cumulativeUtilizePoints,
        color: Colors.green));
    cumulativeUtilizeChartValues.add(ChartValues(
        isStanderd: true,
        chartTitle: 'cumulative_utilize_standard'.tr(),
        spots: cumulativeUtilizeStandardPoints,
        color: Colors.green.withOpacity(0.5)));

    state = BaseState(
        data: state.data.copyWith(
            eggMassChartValues: eggMassChartValues,
            totalEggPerHatchedHenChartValues: totalEggPerHatchedHenChartValues,
            hatchedEggPerHatchedHenChartValues:
                hatchedEggPerHatchedHenChartValues,
            cumulativeUtilizeChartValues: cumulativeUtilizeChartValues));
  }

  selectProductionTab() {
    state = BaseState(data: state.data.copyWith(productionTabSelected: true));
  }

  selectPerformanceTab() {
    state = BaseState(data: state.data.copyWith(productionTabSelected: false));
  }

  List<ChartValues> getSelectedChartData() {
    if (!(state.data.productionTabSelected ?? true)) {
      int? selectedNumber = state.data.selectedChartNumber;
      if (selectedNumber == 2)
        return state.data.totalEggPerHatchedHenChartValues!;
      else if (selectedNumber == 3)
        return state.data.hatchedEggPerHatchedHenChartValues!;
      else if (selectedNumber == 4)
        return state.data.cumulativeUtilizeChartValues!;
      else
        return state.data.eggMassChartValues!;
    } else {
      int? selectedNumber = state.data.selectedProductionChartNumber;

      if (selectedNumber == 2)
        return state.data.secondProductionChartValues!;
      else
        return state.data.productionChartValues!;
    }
  }

  changeSelectedChart(int selectedNumber) {
    state = BaseState(
        data: state.data.copyWith(selectedChartNumber: selectedNumber));
    print(state.data);
  }

  changeSelectedProductionChart(int selectedNumber) {
    state = BaseState(
        data:
            state.data.copyWith(selectedProductionChartNumber: selectedNumber));
    print(state.data);
  }

  double getChartScrollViewOffSet(BuildContext context, int selectedWeek,
      ScrollController scrollController) {
    double horizontalChartPadding = 30;
    double chartHorizontalWidth = (MediaQuery.of(context).size.width *
            CustomLineChart.chartScrollingViewWidthMultiplier) -
        horizontalChartPadding;
    int sliderValuesNumber =
        AppConstants.PRODUCTION_MAX_VALUE - AppConstants.PRODUCTION_MIN_VALUE;
    double weekNumberFromZero =
        selectedWeek - AppConstants.PRODUCTION_MIN_VALUE + 1;
    double oneWeekWidthOnChartView = chartHorizontalWidth / sliderValuesNumber;
    double weekXOffset = oneWeekWidthOnChartView * weekNumberFromZero;
    double halfTheScreenWidth = (MediaQuery.of(context).size.width / 2);
    double minXOffset = weekXOffset - halfTheScreenWidth;

    return minXOffset;
  }
}
