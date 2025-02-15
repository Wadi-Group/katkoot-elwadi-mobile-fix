import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/week_data_table_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/week_data_table_view.dart';
import 'package:easy_localization/easy_localization.dart';

class RearingWeekDataTableView extends StatelessWidget {
  final PreviewData? weekPreviewData;

  const RearingWeekDataTableView({required this.weekPreviewData});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern(context.locale.languageCode);
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: WeekDataTableView(
        tableItems: [
          WeekDataTableItem(
              title: 'female_weight'.tr(),
              value: weekPreviewData!.femaleWeight?.value != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.femaleWeight!.value!.toStringAsFixed(0)))
                  : "0",
              standard: weekPreviewData!.femaleWeight?.standard != null
                  ? formatter.format(double.parse(weekPreviewData!
                      .femaleWeight!.standard!
                      .toStringAsFixed(0)))
                  : "0"),
          WeekDataTableItem(
            title: 'male_weight'.tr(),
            value: weekPreviewData!.maleWeight?.value != null
                ? formatter.format(double.parse(
                    weekPreviewData!.maleWeight!.value!.toStringAsFixed(0)))
                : "0",
            standard: weekPreviewData!.maleWeight?.standard != null
                ? formatter.format(double.parse(
                    weekPreviewData!.maleWeight!.standard!.toStringAsFixed(0)))
                : "0",
          ),
          WeekDataTableItem(
            title: 'cumulative_mort_percentage'.tr(),
            value:
                weekPreviewData!.cumulativeFemaleMortPercentage?.value != null
                    ? formatter.format(double.parse(weekPreviewData!
                        .cumulativeFemaleMortPercentage!.value!
                        .toStringAsFixed(2)))
                    : "0.00",
            standard:
                weekPreviewData!.cumulativeFemaleMortPercentage?.standard !=
                        null
                    ? formatter.format(double.parse(weekPreviewData!
                        .cumulativeFemaleMortPercentage!.standard!
                        .toStringAsFixed(2)))
                    : "0.00",
          )
        ],
      ),
    );
  }
}
