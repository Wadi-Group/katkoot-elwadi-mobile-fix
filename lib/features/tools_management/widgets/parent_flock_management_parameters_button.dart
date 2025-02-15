import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class ParentFlockManagementParametersButton extends StatelessWidget {
  final Function()? onClick;

  ParentFlockManagementParametersButton({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        color: AppColors.Card_Color.withOpacity(0.6),
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: 'parameters'.tr(),
              fontWeight: FontWeight.bold,
              fontSize: 22,
              textColor: AppColors.Liver,
            ),
            Image.asset(
              "assets/images/parameters.png",
              height: 25,
              width: 25,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

}