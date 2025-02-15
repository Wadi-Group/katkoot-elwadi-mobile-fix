// ============================= VIDEO SECTION =============================
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../app_base/widgets/custom_text.dart';

class VideoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomText(
            title: "videos".tr(),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: AppColors.APP_BLUE,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.APPLE_GREEN,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "الإحتفال بمرور ٣٠ عامًا من الشراكة مع شركة أفيجان",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Icon(Icons.play_circle_filled, size: 50, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}
