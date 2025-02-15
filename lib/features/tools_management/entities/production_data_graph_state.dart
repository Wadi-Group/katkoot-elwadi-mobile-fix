import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';

class ProductionDataGraphState {
  List<ChartValues>? productionChartValues;

  List<ChartValues>? secondProductionChartValues;
  List<ChartValues>? eggMassChartValues;
  List<ChartValues>? totalEggPerHatchedHenChartValues;
  List<ChartValues>? hatchedEggPerHatchedHenChartValues;
  List<ChartValues>? cumulativeUtilizeChartValues;
  bool? productionTabSelected;
  int? selectedChartNumber;
  int? selectedProductionChartNumber;

  ProductionDataGraphState(
      {this.productionChartValues,
      this.secondProductionChartValues,
      this.eggMassChartValues,
      this.totalEggPerHatchedHenChartValues,
      this.hatchedEggPerHatchedHenChartValues,
      this.cumulativeUtilizeChartValues,
      this.productionTabSelected = true,
      this.selectedChartNumber,
      this.selectedProductionChartNumber});

  ProductionDataGraphState copyWith(
      {List<ChartValues>? productionChartValues,
      List<ChartValues>? secondProductionChartValues,
      List<ChartValues>? eggMassChartValues,
      List<ChartValues>? totalEggPerHatchedHenChartValues,
      List<ChartValues>? hatchedEggPerHatchedHenChartValues,
      List<ChartValues>? cumulativeUtilizeChartValues,
      bool? productionTabSelected,
      int? selectedWeekNumber,
      int? selectedProductionChartNumber,
      int? selectedChartNumber}) {
    return ProductionDataGraphState(
        productionChartValues:
            productionChartValues ?? this.productionChartValues,
        secondProductionChartValues:
            secondProductionChartValues ?? this.secondProductionChartValues,
        eggMassChartValues: eggMassChartValues ?? this.eggMassChartValues,
        totalEggPerHatchedHenChartValues: totalEggPerHatchedHenChartValues ??
            this.totalEggPerHatchedHenChartValues,
        hatchedEggPerHatchedHenChartValues:
            hatchedEggPerHatchedHenChartValues ??
                this.hatchedEggPerHatchedHenChartValues,
        cumulativeUtilizeChartValues:
            cumulativeUtilizeChartValues ?? this.cumulativeUtilizeChartValues,
        productionTabSelected:
            productionTabSelected ?? this.productionTabSelected,
        selectedChartNumber: selectedChartNumber ?? this.selectedChartNumber,
        selectedProductionChartNumber: selectedProductionChartNumber ??
            this.selectedProductionChartNumber);
  }
}
