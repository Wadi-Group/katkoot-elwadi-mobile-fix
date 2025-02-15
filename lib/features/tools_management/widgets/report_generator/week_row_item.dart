import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class WeekRowItem extends StatelessWidget {
  String week;
  Function onTap;
  bool hasData;

  WeekRowItem({required this.week, required this.onTap, required this.hasData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color:
              AppColors.white,
          border: Border(
            bottom: BorderSide(
              width: .5,
              color: AppColors.Ash_grey.withOpacity(.5),
            ),
          ),
        ),
        padding: EdgeInsetsDirectional.fromSTEB(15, 8, 15, 8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: CustomText(
            title: week,
            maxLines: 1,
            textColor: hasData ? AppColors.Gamboge : AppColors.black,
            fontSize: 14,
            fontWeight:  hasData ? FontWeight.bold : FontWeight.w400,
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
        ),
      ),
    );
  }
}
