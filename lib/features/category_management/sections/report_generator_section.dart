import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../app_base/widgets/custom_text.dart';
import '../widgets/reusable_container_widget.dart';

class ReportGeneratorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportGenerator(
          title: "cb_report_generator".tr(),
          onTap: () {
            // Navigator.of(context).pushNamed(CBReportGeneratorScreen.routeName);
          },
          icon: RotatedBox(
            quarterTurns: context.locale.languageCode == "en" ? 0 : 2,
            child: Icon(
              Icons.east,
              color: AppColors.APP_BLUE,
            ),
          ),
        ),
        SizedBox(height: 20),
        ReportGenerator(
          title: "ps_report_generator".tr(),
          subtitle: "str_add_new_cycle".tr(),
          onTap: () {},
          icon: Image.asset(
            'assets/images/add_cycle.png',
            color: AppColors.APP_BLUE,
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}

class ReportGenerator extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? icon;

  const ReportGenerator({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ReusableContainer(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15),
        borderRadius: BorderRadius.circular(12), // Optional border radius
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between text & icon
          children: [
            Image.asset(
              "assets/images/elite_logo.png",
              width: 30,
              height: 30,
              color: AppColors.APPLE_GREEN,
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomText(
                title: title,
                textColor: AppColors.APP_BLUE,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                lineSpacing: 1,
              ),
            ),
            CustomText(
              title: subtitle ?? "",
              textColor: AppColors.APP_BLUE,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(width: 10),
            icon ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
