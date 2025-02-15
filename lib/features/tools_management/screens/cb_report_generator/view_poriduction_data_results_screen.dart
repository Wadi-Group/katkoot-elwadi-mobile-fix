import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/week_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/rear_table_row_item.dart';

class ProductionDataResultsScreen extends StatefulWidget {
  static const routeName = "./view_production_results_data";

  final int? weekNumber;
  final CbWeekData? weekData;
  final String? cycleName;
  final bool hasData;

  const ProductionDataResultsScreen(
      {this.weekNumber, this.weekData, this.cycleName, this.hasData = true});

  @override
  _ProductionDataResultsState createState() => _ProductionDataResultsState();
}

class _ProductionDataResultsState extends State<ProductionDataResultsScreen> {
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
                                vertical: 10, horizontal: 30),
                            child: CustomText(
                              title: "${widget.cycleName}",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.Dark_spring_green,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.Mansuel),
                            child: CustomText(
                              title: "str_week".tr() + " ${widget.weekNumber}",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.Liver,
                            ),
                          ),
                          buiTableHeader(context),
                          RearingViewTableRowItem(
                              title: "Female Mort".tr(),
                              actual:
                                  widget.weekData?.value?.params?.femaleMort,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "Mort %".tr(),
                              actual: widget.weekData?.value?.params
                                  ?.cumulativeFemaleMortPercentage,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "cumulated Mort".tr(),
                              actual: widget.weekData?.value?.params
                                  ?.cumulativeFemaleMort,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "cumulated mort %".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.cumulativeFemaleMortPercentage?.standard),
                          RearingViewTableRowItem(
                              title: "Balance".tr(),
                              actual:
                                  widget.weekData?.value?.params?.femaleBalance,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "Total egg".tr(),
                              actual: widget.weekData?.value?.params?.totalEgg,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "cumulated total egg".tr(),
                              actual: widget
                                  .weekData?.value?.params?.cumulativeTotalEggs,
                              standard: null),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "total egg /hen hatched".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.totalEggPerHatchedHen?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.totalEggPerHatchedHen?.standard),
                          RearingViewTableRowItem(
                              title: "Hatched egg".tr(),
                              actual:
                                  widget.weekData?.value?.params?.hatchedEgg,
                              standard: null),
                          RearingViewTableRowItem(
                              title: "cumulated hatch egg".tr(),
                              actual: widget.weekData?.value?.params
                                  ?.cumulativeHatchedEgg,
                              standard: null),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "hatch egg/hen housed".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.hatchedEggPerHatchedHen?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.hatchedEggPerHatchedHen?.standard),
                          RearingViewTableRowItem(
                              title: "Utiliz wk".tr(),
                              hasDecimal: true,
                              actual: widget.weekData?.value?.params?.utilize,
                              standard: null),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "Utiliz cum".tr(),
                              actual: widget
                                  .weekData?.value?.previewData?.utilize?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.utilize?.standard),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "HH%".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.hatchedHenPercentage?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.hatchedHenPercentage?.standard),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "HW%".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.hatchedPercentage?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.hatchedPercentage?.standard),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "Egg weight".tr(),
                              actual: widget.weekData?.value?.previewData
                                  ?.eggWeight?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.eggWeight?.standard),
                          RearingViewTableRowItem(
                              hasDecimal: true,
                              title: "Egg Mass".tr(),
                              actual: widget
                                  .weekData?.value?.previewData?.eggMass?.value,
                              standard: widget.weekData?.value?.previewData
                                  ?.eggMass?.standard),
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
