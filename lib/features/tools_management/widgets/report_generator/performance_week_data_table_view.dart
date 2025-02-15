import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_view.dart';

class PerformanceWeekDataTableView extends StatelessWidget {
  final  PreviewData? weekPreviewData;

  const PerformanceWeekDataTableView({required this.weekPreviewData});

  @override
  Widget build(BuildContext context) {
    return WeekDataTableView(
      tableItems: [
        WeekDataTableItem(
          title: 'Egg Mass',
          value: weekPreviewData?.eggMass?.value.toString(),
          standard: weekPreviewData?.eggMass?.standard.toString(),
        ),
        WeekDataTableItem(
          title: 'Total Egg Per Hatched Hen',
          value: weekPreviewData?.totalEggPerHatchedHen?.value.toString(),
          standard: weekPreviewData?.totalEggPerHatchedHen?.standard.toString(),
        ),
        WeekDataTableItem(
          title: 'Hatched Egg Per Hatched Hen',
          value: weekPreviewData?.hatchedEggPerHatchedHen?.value.toString(),
          standard: weekPreviewData?.hatchedEggPerHatchedHen?.standard.toString(),
        ),
        WeekDataTableItem(
          title: 'Weekly Utilization',
          value: weekPreviewData?.cumulativeUtilize?.value.toString(),
          standard: weekPreviewData?.cumulativeUtilize?.standard.toString(),
        ),
      ],
    );
  }
}
