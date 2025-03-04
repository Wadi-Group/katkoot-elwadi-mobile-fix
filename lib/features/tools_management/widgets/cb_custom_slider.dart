import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CustomSlider extends ConsumerWidget with BaseViewModel {
  final Function onDrag;
  final bool isNumeric;

  CustomSlider({required this.onDrag, this.isNumeric = false});

  var sliderViewModelProvider;
  var sliderViewModelProviderActions;
  final locale = AppConstants.navigatorKey.currentContext?.locale.toString();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (_, watch, __) {
        sliderViewModelProvider = ref.watch(di.customSliderViewModelProvider);
        sliderViewModelProviderActions =
            ref.watch(di.customSliderViewModelProvider.notifier);

        return ((sliderViewModelProvider.data.sliderIntervals != null &&
                        sliderViewModelProvider
                            .data.sliderIntervals.isNotEmpty) &&
                    (sliderViewModelProvider.data.sliderIcons != null &&
                        sliderViewModelProvider.data.sliderIcons.isNotEmpty) ||
                isNumeric)
            ? Container(
                padding: EdgeInsets.only(
                    top: !isNumeric ? 30 : 0, right: 10, left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlutterSlider(
                        handlerWidth: 50,
                        handlerHeight: 50,
                        tooltip: FlutterSliderTooltip(
                          positionOffset: FlutterSliderTooltipPositionOffset(
                              top: isNumeric ? 15 : -20),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: context.locale.toString() == 'en'
                                  ? "Arial"
                                  : "Almarai",
                              //height: .6,
                              fontSize: 14,
                              color: AppColors.Dark_spring_green),
                          boxStyle: FlutterSliderTooltipBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.Dim_gray.withOpacity(.3),
                                  width: 1),
                              color: AppColors.white,
                            ),
                          ),
                          format: (value) {
                            return "${sliderViewModelProvider.data.duration} ${(sliderViewModelProvider.data.current).toInt().toString()}";
                          },
                          alwaysShowTooltip: isNumeric ? false : true,
                        ),
                        values: [sliderViewModelProvider.data.current],
                        max: sliderViewModelProvider.data.max,
                        min: sliderViewModelProvider.data.min,
                        rtl: locale == 'ar' ? true : false,
                        trackBar: FlutterSliderTrackBar(
                            activeTrackBar: BoxDecoration(
                                color: detectSliderTrackColor() ??
                                    AppColors.Olive_Drab,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            activeTrackBarHeight: 5),
                        step: FlutterSliderStep(
                            step: sliderViewModelProvider.data.step),
                        handler: FlutterSliderHandler(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: detectSliderTrackColor() ??
                                    AppColors.Olive_Drab,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: AppColors.white),
                          child: Center(
                              child: !isNumeric
                                  ? Container(
                                      padding: EdgeInsetsDirectional.all(5),
                                      child: detectSliderIcon(),
                                    )
                                  : getSliderTextWidget()),
                        ),
                        onDragging: (handlerIndex, lowerValue, upperValue) =>
                            onDrag(lowerValue),
                      ),
                      if (isNumeric)
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getSliderDurationTextWidget(),
                              SizedBox(
                                width: 20,
                              ),
                              getSliderMaxTextWidget(),
                            ],
                          ),
                        )
                    ]),
                decoration: new BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: AppColors.white_smoke,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(
                color: AppColors.OLIVE_DRAB,
              );
      },
    );
  }

  Widget? detectSliderIcon() {
    Widget? icon;
    if (sliderViewModelProvider.data.sliderIcons != null) {
      for (var item in sliderViewModelProvider.data.sliderIcons) {
        if (item.sliderInterval.start <= sliderViewModelProvider.data.current &&
            sliderViewModelProvider.data.current <= item.sliderInterval.end) {
          icon = item.icon;
        }
      }
    }
    return icon;
  }

  Widget? getSliderTextWidget() {
    return CustomText(
        textAlign: TextAlign.start,
        padding: EdgeInsetsDirectional.all(5),
        textColor: AppColors.Dark_spring_green,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        maxLines: 2,
        title: sliderViewModelProvider.data.current.toInt().toString());
  }

  Widget getSliderDurationTextWidget() {
    return CustomText(
        italic: true,
        lineSpacing: 0,
        textColor: AppColors.Liver,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        maxLines: 1,
        title: sliderViewModelProvider.data.duration);
  }

  Widget getSliderMaxTextWidget() {
    return CustomText(
        lineSpacing: 0,
        textColor: AppColors.Liver,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        maxLines: 1,
        title: sliderViewModelProvider.data.max.toInt().toString());
  }

  Color? detectSliderTrackColor() {
    Color? color;
    if (sliderViewModelProvider.data.sliderTrackColors != null) {
      for (var item in sliderViewModelProvider.data.sliderTrackColors) {
        if (item.sliderInterval.start <= sliderViewModelProvider.data.current &&
            sliderViewModelProvider.data.current <= item.sliderInterval.end) {
          color = item.color;
        }
      }
    }
    return color;
  }
}
