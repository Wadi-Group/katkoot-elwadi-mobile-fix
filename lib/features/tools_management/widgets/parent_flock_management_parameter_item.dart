import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/flock_management_custom_slider.dart';

class ParentFlockManagementParameterItem extends StatelessWidget {
  final int? min,max,step,value;
  final String? unit,title;
  final Function onDrag;

  ParentFlockManagementParameterItem({
    required this.title,
    required this.onDrag,
    required this.min,
    required this.max,
    required this.step,
    required this.value,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [new BoxShadow(
            color: AppColors.SHADOW_GREY,
            blurRadius: 5.0,
          )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title ?? '',
            textColor: AppColors.Liver,
            fontWeight: FontWeight.bold,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: unit ?? ''),
                CustomText(
                  title: (value ?? 0).toString(),
                  textColor: AppColors.OLIVE_DRAB,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ],
            ),
          ),
          FlockManagementCustomSlider(
              min: min ?? 0,
              current: value ?? min ?? 0,
              step: step ?? 1,
              max: max ?? 0,
              onDrag: onDrag
          ),
        ],
      ),
    );
  }

}