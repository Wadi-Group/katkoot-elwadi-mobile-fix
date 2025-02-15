import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CycleContextMenuItem extends StatelessWidget {
  String title;
  bool? hasUnderLine;
  IconData icon;

  CycleContextMenuItem(
      {required this.icon, required this.title, this.hasUnderLine = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(children: [
              Icon(
                icon,
                color: AppColors.ICON_GREY,
              ),
              SizedBox(
                width: 20,
              ),
              CustomText(
                title: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
            ]),
            SizedBox(
              height: 15,
            ),
            if (hasUnderLine!)
              Container(
                height: 1,
                color: AppColors.ICON_GREY,
              )
          ],
        ));
  }
}
