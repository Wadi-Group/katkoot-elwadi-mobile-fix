import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/utils/numbers_manager.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class FlockManagementCustomSlider extends StatefulWidget {
  final Function onDrag;
  final int? min,max,step,current;

  FlockManagementCustomSlider({required this.onDrag,required this.min,required this.max,required this.step,required this.current});

  @override
  State<FlockManagementCustomSlider> createState() => _FlockManagementCustomSliderState();
}

class _FlockManagementCustomSliderState extends State<FlockManagementCustomSlider> {
  final locale = AppConstants.navigatorKey.currentContext?.locale.toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterSlider(
            max: (widget.max ?? 0).toDouble(),
            min: (widget.min ?? 0).toDouble(),
            rtl: locale == 'ar' ? true : false,
            handlerHeight: 22,
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(
                  color: AppColors.Tea_green,
                  shape: BoxShape.rectangle,
                  borderRadius:
                  BorderRadius.all(Radius.circular(30))),
              inactiveTrackBar: BoxDecoration(
                  color: AppColors.Tea_green,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              activeTrackBarHeight: 1.5,
              inactiveTrackBarHeight: 1.5,
            ),
            handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.3,
                      color: AppColors.Olive_Drab,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    color: Colors.white),
                child: Container()
            ),
            step: FlutterSliderStep(
                step: widget.step == 0 ? 1 : (widget.step ?? 0).toDouble()),
            values: [(widget.current ?? widget.min ?? 0).toDouble()],
            onDragging: (handlerIndex, lowerValue, upperValue) =>
                widget.onDrag(lowerValue)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: NumbersManager.getThousandFormat(widget.min ?? 0),fontSize: 16,textColor: AppColors.Liver),
                CustomText(title: NumbersManager.getThousandFormat(widget.max ?? 0),fontSize: 16,textColor: AppColors.Liver),
              ]
          ),
        )
      ],
    );
  }
}
