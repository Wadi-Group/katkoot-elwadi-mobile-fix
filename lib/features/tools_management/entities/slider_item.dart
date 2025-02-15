import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class SliderItem {
  String duration;
  double min;
  double current;
  double max;
  double step;
  List<SliderIcon>? sliderIcons;
  List<SliderTrackColor>? sliderTrackColors;
  List<SliderInterval>? sliderIntervals;// note: if there is not interval keep it null.
  Color? handlerBorderColor;

  SliderItem(
      {
        required this.duration,
        this.min = 0,
        this.max = 1000,
        this.current = 500,
        this.step = 1,
        this.sliderIntervals,
        this.sliderIcons,
        this.sliderTrackColors,
        this.handlerBorderColor
      });
}

class SliderIcon {
  Widget icon;
  SliderInterval sliderInterval;

  SliderIcon(
      {this.icon =
          const Icon(Icons.adjust, size: 40, color: AppColors.Olive_Drab),
      required this.sliderInterval});
}

class SliderTrackColor {
  Color color;
  SliderInterval sliderInterval;

  SliderTrackColor(
      {this.color = AppColors.Olive_Drab,
        required this.sliderInterval});
}

class SliderInterval {
  int start;
  int end;

  SliderInterval({required this.start, required this.end});
}
