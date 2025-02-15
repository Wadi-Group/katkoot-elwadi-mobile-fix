import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

import 'custom_text.dart';

class AppNoConnection extends StatelessWidget {
  final void Function()? onTap;
  final bool hasBackground;

  AppNoConnection({this.onTap, this.hasBackground = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsetsDirectional.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Icon(
                  Icons.wifi_off,
                  size: 125,
                  color: AppColors.Tea_green,
                ),
              ),
              CustomText(
                title: "str_no_connection".tr(),
                fontSize: 17,
                textColor: AppColors.APPLE_GREEN,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
