import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_data_table_view.dart';

class ProductionWeekDataTableView extends StatelessWidget {
  final PreviewData? weekPreviewData;

  const ProductionWeekDataTableView({required this.weekPreviewData});

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
                : "0",
          ),
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
              title: 'female_feed'.tr(),
              value: weekPreviewData!.femaleFeed?.value != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.femaleFeed!.value!.toStringAsFixed(0)))
                  : "0",
              standard: weekPreviewData!.femaleFeed?.standard != null
                  ? formatter.format(double.parse(weekPreviewData!
                      .femaleFeed!.standard!
                      .toStringAsFixed(0)))
                  : "0"),
          WeekDataTableItem(
              title: 'male_feed'.tr(),
              value: weekPreviewData!.maleFeed?.value != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.maleFeed!.value!.toStringAsFixed(0)))
                  : "0",
              standard: weekPreviewData!.maleFeed?.standard != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.maleFeed!.standard!.toStringAsFixed(0)))
                  : "0"),
          WeekDataTableItem(
              title: 'egg_weight'.tr(),
              value: weekPreviewData!.eggWeight?.value != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.eggWeight!.value!.toStringAsFixed(2)))
                  : "0.00",
              standard: weekPreviewData!.eggWeight?.standard != null
                  ? formatter.format(double.parse(
                      weekPreviewData!.eggWeight!.standard!.toStringAsFixed(2)))
                  : '0.00'),
          WeekDataTableItem(
              title: 'hatched_hen_percentage'.tr(),
              value: weekPreviewData!.hatchedHenPercentage?.value != null
                  ? formatter.format(double.parse(weekPreviewData!
                      .hatchedHenPercentage!.value!
                      .toStringAsFixed(2)))
                  : "0.00",
              standard: weekPreviewData!.hatchedHenPercentage?.standard != null
                  ? formatter.format(double.parse(weekPreviewData!
                      .hatchedHenPercentage!.standard!
                      .toStringAsFixed(2)))
                  : "0.00"),
          WeekDataTableItem(
            title: 'hatched_weight_percentage'.tr(),
            value: weekPreviewData!.hatchedWeightPercentage?.value != null
                ? formatter.format(double.parse(weekPreviewData!
                    .hatchedWeightPercentage!.value!
                    .toStringAsFixed(2)))
                : "0.00",
            standard: weekPreviewData!.hatchedWeightPercentage?.standard != null
                ? formatter.format(double.parse(weekPreviewData!
                    .hatchedWeightPercentage!.standard!
                    .toStringAsFixed(2)))
                : "0.00",
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
          ),
          WeekDataTableItem(
            title: 'lighting_program'.tr(),
            value: weekPreviewData!.lightingProgram?.value != null
                ? formatter.format(double.parse(weekPreviewData!
                    .lightingProgram!.value!
                    .toStringAsFixed(0)))
                : "0",
            standard: weekPreviewData!.lightingProgram?.standard != null
                ? formatter.format(double.parse(weekPreviewData!
                    .lightingProgram!.standard!
                    .toStringAsFixed(0)))
                : "0",
          ),
        ],
      ),
    );
  }
}
