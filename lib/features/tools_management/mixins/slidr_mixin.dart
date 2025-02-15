import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:math' as math;

mixin SliderMixin{
  Widget createSliderIcon(String iconPath, Color iconColor){
    final locale = AppConstants.navigatorKey.currentContext?.locale.toString();

    return Transform(
      child: ImageIcon(
        AssetImage("assets/images/"+iconPath),
        size: 40,
        color: iconColor,
      ),
      alignment: Alignment.center,
      transform: Matrix4.rotationY(locale == "en"
          ? 0
          : math.pi),
    );
  }
}