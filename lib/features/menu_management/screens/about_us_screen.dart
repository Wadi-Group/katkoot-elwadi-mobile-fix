import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

import '../../app_base/widgets/custom_app_bar.dart';
import '../view_models/navigation_drawer_mixin.dart';

class AboutUsScreen extends StatelessWidget with NavigationDrawerMixin {
  static const routeName = '/about_us';

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      appBar: CustomAppBar(
        showNotificationsButton: true,
        showDrawer: true,
        hasbackButton: true,

        // onBackClick: () => context.read(di.contentProvider).state =
        //     DrawerItemType.drawer.index
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            CustomText(
              title: "about_us".tr(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: AppColors.APP_BLUE,
            ),
            SizedBox(height: 25),
            CustomText(
              textAlign: TextAlign.center,
              title:
                  "katkoot al wadi broiler is the best broiler in the world, katkoot "
                      .tr(),
              fontSize: 16,
              fontWeight: FontWeight.normal,
              textColor: AppColors.APP_BLUE,
            ),
          ],
        ),
      )),
    );
  }
}
