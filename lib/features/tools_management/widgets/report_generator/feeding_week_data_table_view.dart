import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_view.dart';

class FeedingWeekDataTableView extends StatelessWidget {
  final PreviewData? weekPreviewData;

  const FeedingWeekDataTableView({required this.weekPreviewData});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern(context.locale.languageCode);
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: WeekDataTableView(
        tableItems: [
          WeekDataTableItem(
            title: 'female_feed'.tr(),
            value: weekPreviewData!.femaleFeed?.value != null
                ? formatter.format(double.parse(
                    weekPreviewData!.femaleFeed!.value!.toStringAsFixed(0)))
                : "0",
            standard: weekPreviewData!.femaleFeed?.standard != null
                ? formatter.format(double.parse(
                    weekPreviewData!.femaleFeed!.standard!.toStringAsFixed(0)))
                : "0",
          ),
          WeekDataTableItem(
            title: 'male_feed'.tr(),
            value: weekPreviewData!.maleFeed?.value != null
                ? formatter.format(double.parse(
                    weekPreviewData!.maleFeed!.value!.toStringAsFixed(0)))
                : "0",
            standard: weekPreviewData!.maleFeed?.standard != null
                ? formatter.format(double.parse(
                    weekPreviewData!.maleFeed!.standard!.toStringAsFixed(0)))
                : "0",
          ),
        ],
      ),
    );
  }
}
