import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/week_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/production_results_table_row_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/rear_table_row_item.dart';

class RearingDataScreen extends StatefulWidget {
  static const routeName = "./view_rearing_data_screen";
  final int? weekNumber;
  final CbWeekData? weekData;
  final String? cycleName;
  final bool hasData;

  const RearingDataScreen(
      {this.weekNumber, this.weekData, this.hasData = true, this.cycleName});

  @override
  _RearingDataScreenState createState() => _RearingDataScreenState();
}

class _RearingDataScreenState extends State<RearingDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          (widget.hasData)
              ? Consumer(builder: (_, watch, __) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: CustomText(
                              title: "${widget.cycleName}",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.Dark_spring_green,
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: CustomText(
                              title: "str_week".tr() + " ${widget.weekNumber}",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.Dark_spring_green,
                            ),
                          ),
                          buiTableHeader(context),
                          RearingViewTableRowItem(
                              title: "Female feed".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.femaleFeed?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.femaleFeed?.standard),
                          RearingViewTableRowItem(
                              title: "Male feed".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.maleFeed?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.maleFeed?.standard),
                          RearingViewTableRowItem(
                              title: "Female weight".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.femaleWeight?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.femaleWeight?.standard),
                          RearingViewTableRowItem(
                            title: "Male weight".tr(),
                            actual: widget.weekData?.value?.previewData
                                ?.maleWeight?.value,
                            standard: widget.weekData?.value?.previewData
                                ?.maleWeight?.standard,
                          ),
                          // RearingViewTableRowItem(title: "cumulative_female_mort_percentage",actual: widget.weekData?.value?.previewData?.cumulativeFemaleMortPercentage?.value,standard: widget.weekData?.value?.previewData?.cumulativeFemaleMortPercentage?.standard),
                          RearingViewTableRowItem(
                              title: "Mort".tr(),
                              actual:
                                  widget.weekData?.value?.params?.femaleMort,
                              standard: null),
                          RearingViewTableRowItem(
                            title: "Sex errors".tr(),
                            actual: widget.weekData?.value?.params?.sexErrors,
                            standard: null,
                          ),
                          RearingViewTableRowItem(
                              title: "Culls".tr(),
                              actual: widget.weekData?.value?.params?.culls,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "cumulated Mort".tr(),
                              actual: widget.weekData?.value?.params
                                  ?.cumulativeFemaleMort,
                              standard: null),
                          // RearingViewTableRowItem(title: "cumulated Male Mort",actual: widget.weekData?.value?.params!.cumulativeMaleMort,standard: 0),
                          RearingViewTableRowItem(
                              title: "week loses".tr(),
                              actual: widget.weekData?.value?.params
                                  ?.lastWeekCumulativeLoses,
                              standard: null), // check
                          RearingViewTableRowItem(
                              title: "Mort.Wk%".tr(),
                              hasDecimal: true,
                              actual: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.standard),
                          RearingViewTableRowItem(
                              title: "num/week".tr(),
                              actual:
                                  widget.weekData?.value?.params?.femaleBalance,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "CM%".tr(),
                              hasDecimal: true,
                              actual: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.standard),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  );
                })
              : Expanded(
                  child: Container(
                    child: Center(
                      child: CustomText(
                        title: "str_no_data_prov".tr(),
                        fontSize: 17,
                        textColor: AppColors.APPLE_GREEN,
                      ),
                    ),
                  ),
                ),
          // ScreenHandler(
          //   screenProvider: _viewModelProvider,
          //   onDeviceReconnected: getCycleData,
          // ),
        ],
      ),
    );
  }

  Widget buiTableHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 0, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.Tea_green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: CustomText(
              textColor: AppColors.Dark_spring_green,
              title: "",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textOverflow: TextOverflow.visible),
        ),
        Expanded(
          flex: 1,
          child: CustomText(
              textColor: AppColors.Dark_spring_green,
              title: "actual".tr(),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible),
        ),
        SizedBox(
          width: 25,
        ),
        Expanded(
          flex: 1,
          child: CustomText(
              maxLines: 1,
              textColor: AppColors.Dark_spring_green,
              title: "standard".tr(),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible),
        ),
        SizedBox(
          width: 18,
        ),
      ]),
    );
  }
}
