import 'package:katkoot_elwady/features/app_base/models/chart_values.dart';

class RearingDataGraphState {
  List<ChartValues>? rearingChartValues;

  List<ChartValues>? secondRearingChartValues;
  List<ChartValues>? feedingChartValues;
  int? selectedChartValue;

  bool? rearingTabSelected;

  RearingDataGraphState({
    this.rearingChartValues,
    this.secondRearingChartValues,
    this.feedingChartValues,
    this.selectedChartValue,
    this.rearingTabSelected = true,
  });

  RearingDataGraphState copyWith(
      {List<ChartValues>? rearingChartValues,
      List<ChartValues>? secondRearingChartValues,
      List<ChartValues>? feedingChartValues,
      bool? rearingTabSelected,
      int? selectedChartValue,
      int? selectedWeekNumber}) {
    return RearingDataGraphState(
      rearingChartValues: rearingChartValues ?? this.rearingChartValues,
      selectedChartValue: selectedChartValue ?? this.selectedChartValue,
      secondRearingChartValues:
          secondRearingChartValues ?? this.secondRearingChartValues,
      feedingChartValues: feedingChartValues ?? this.feedingChartValues,
      rearingTabSelected: rearingTabSelected ?? this.rearingTabSelected,
    );
  }
}
