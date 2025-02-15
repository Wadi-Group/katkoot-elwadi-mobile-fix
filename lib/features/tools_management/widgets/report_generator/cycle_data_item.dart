import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/decimal_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CycleDataItem extends StatefulWidget {
  final String? title, value;

  CycleDataItem({required this.title, required this.value});

  @override
  State<CycleDataItem> createState() => _CycleDataItemState();
}

class _CycleDataItemState extends State<CycleDataItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 5),
      decoration: BoxDecoration(
          color: AppColors.Tea_green.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              title: widget.title ?? '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: AppColors.DARK_SPRING_GREEN,
              maxLines: 3,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: CustomText(
              textOverflow: TextOverflow.ellipsis,
              title: widget.value ?? "",
              fontSize: 16,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
