import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/decimal_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CbCycleWeekDataItem extends StatefulWidget {
  final String? title, errorMessage;
  final TextEditingController controller;
  bool? hasDecimal;

  CbCycleWeekDataItem({
    required this.title,
    required this.controller,
    this.hasDecimal = false,
    this.errorMessage,
  });

  @override
  State<CbCycleWeekDataItem> createState() => _CbCycleWeekDataItemState();
}

class _CbCycleWeekDataItemState extends State<CbCycleWeekDataItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.Tea_green.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: widget.title ?? '',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: AppColors.DARK_SPRING_GREEN,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: AppColors.SHADOW_GREY,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: CustomTextField(
                  contentPadding: EdgeInsets.all(10),
                  borderRadius: 3,
                  isDense: true,
                  inputType: widget.hasDecimal!
                      ? TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.number,
                  inputFormatter: widget.hasDecimal!
                      ? [DecimalTextInputFormatter(maxDecimalDigits: 2)]
                      : [FilteringTextInputFormatter.digitsOnly],
                  hintColor: AppColors.Pastel_gray,
                  fillColor: Colors.white,
                  controller: widget.controller,
                  hintText: "0",
                ),
              )
            ],
          ),
        ),
        if (widget.errorMessage?.isNotEmpty ?? false)
          Container(
            width: MediaQuery.of(context).size.width,
            child: CustomText(
              textAlign: TextAlign.start,
              padding: EdgeInsetsDirectional.only(top: 5),
              title: widget.errorMessage ?? '',
              textColor: AppColors.ERRORS_RED,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              maxLines: 2,
            ),
          ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
