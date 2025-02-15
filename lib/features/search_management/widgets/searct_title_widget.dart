import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchTitleWidget extends StatelessWidget {
  String title;
  bool showViewAll;
  Function ontap;

  SearchTitleWidget(
      {required this.title, required this.ontap, required this.showViewAll});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: title,
            textColor: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
              onTap: () {
                print("tab");
                ontap();
              },
              child: showViewAll
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomText(
                          textColor: AppColors.Dim_gray,
                          fontSize: 15,
                          title: "str_view_all".tr()),
                    )
                  : Container())
        ],
      ),
    );
  }
}
