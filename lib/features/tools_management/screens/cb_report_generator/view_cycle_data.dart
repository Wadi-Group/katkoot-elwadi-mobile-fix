import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cycle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/cycle_data_item.dart';

class ViewCycleData extends StatefulWidget {
  CbCycle cbcycle;

  ViewCycleData({required this.cbcycle});

  @override
  State<ViewCycleData> createState() => _ViewCycleDataState();
}

class _ViewCycleDataState extends State<ViewCycleData> with BaseViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'cycle_data'.tr(),
        onBackClick: () => Navigator.of(context).pop(),
        //widget.tool!.title
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: 'cycle_data'.tr(),
                      fontSize: 18,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CbCycleDataItem(
                            title: "str_farm_name".tr(),
                            value: widget.cbcycle.farmName),
                        CbCycleDataItem(
                            title: "str_room_name".tr(),
                            value: widget.cbcycle.location),
                        CbCycleDataItem(
                            title: "str_arrival_date".tr(),
                            value: DateFormat('yMMMd').format(DateTime.parse(
                                widget.cbcycle.arrivalDate ?? ""))),
                        CbCycleDataItem(
                            title: "str_male_number".tr(),
                            value: widget.cbcycle.male.toString()),
                        // CycleDataItem(
                        //     title: "str_female_number".tr(),
                        //     value: widget.cycle.female.toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
