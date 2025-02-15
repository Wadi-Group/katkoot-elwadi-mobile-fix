import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/week_data_table_item.dart';
import 'package:easy_localization/easy_localization.dart';
class WeekDataTableView extends StatelessWidget {
  final  List<WeekDataTableItem> tableItems;

  const WeekDataTableView({required this.tableItems});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildHorizontalTitles(),
          ...tableItems
        ],
      ),
    );
  }

  _buildHorizontalTitles(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: CustomText(
                    title: '',
                    textColor: AppColors.Dark_spring_green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                color: AppColors.Tea_green,
                child: Center(
                  child: CustomText(
                    title: 'actual'.tr(),
                    textColor: AppColors.Dark_spring_green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    padding: EdgeInsets.all(7),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Container(
                color: AppColors.Tea_green,
                child: Center(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    title: 'standard'.tr(),
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.Dark_spring_green,
                    fontSize: 14,
                    padding: EdgeInsets.all(7),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
