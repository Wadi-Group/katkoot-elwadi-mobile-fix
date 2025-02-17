import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

import 'custom_text.dart';

class CustomTextField extends StatelessWidget {
  final double fontSize;
  final double titleFontSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry contentPadding;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextInputType? inputType;
  final String hintText;
  final Color? textColor;
  final TextAlign textAlign;
  final Color? titleTextColor;
  final bool isSecured;
  final bool isEnabled;
  final bool hasSuffixSecurityIcon;
  final Color hintColor;
  final String? fontFamily;
  final FontWeight titleFontWeight;
  final FontWeight fontWeight;
  final Color? backgroundColor;
  final Widget? endWidget;
  final TextInputAction? textInputAction;
  final bool showBorder;
  final bool isDense;
  final Function? onSubmitted;
  final Color fillColor;
  final Function? onChange;
  final FocusNode? focusNode;
  final String? errorMessage;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;
  final bool isMandatory;

  CustomTextField({
    this.titleTextColor,
    this.backgroundColor,
    this.textColor,
    this.onSubmitted,
    this.textInputAction,
    required this.controller,
    this.inputType = TextInputType.text,
    this.fontSize = 15,
    this.titleFontSize = 18,
    this.isSecured = false,
    this.isDense = false,
    this.hasSuffixSecurityIcon = false,
    this.borderRadius = 12,
    this.hintColor = AppColors.TEXTFIELD_HINT,
    this.padding = EdgeInsetsDirectional.zero,
    this.titlePadding = const EdgeInsetsDirectional.only(top: 5, bottom: 5),
    this.contentPadding = const EdgeInsetsDirectional.only(start: 10, end: 10),
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.hintText = "",
    this.titleFontWeight = FontWeight.bold,
    this.fontWeight = FontWeight.bold,
    this.isEnabled = true,
    this.endWidget,
    this.showBorder = true,
    this.fontFamily,
    this.fillColor = AppColors.white,
    this.onChange,
    this.focusNode,
    this.errorMessage = "",
    this.maxLength,
    this.inputFormatter,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.APP_CARDS_BLUE.withAlpha(25),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              TextFormField(
                inputFormatters: inputFormatter,
                maxLength: maxLength,
                textAlignVertical: TextAlignVertical.center,
                focusNode: focusNode,
                onChanged: (val) {
                  if (onChange != null) {
                    onChange!(val);
                  }
                },
                keyboardType: inputType,
                enabled: isEnabled,
                onFieldSubmitted: (val) {
                  if (onSubmitted != null) {
                    onSubmitted!();
                  }
                },
                controller: controller,
                obscureText: isSecured,
                textAlign: textAlign,
                cursorColor: textColor ?? AppColors.Liver,
                textInputAction: textInputAction ?? TextInputAction.next,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                  color: textColor ?? AppColors.Liver,
                ).apply(
                  fontSizeDelta: context.locale.toString() == 'en' ? 0.0 : -2.0,
                  fontSizeFactor: 1.0,
                ),
                decoration: InputDecoration(
                  isDense: isDense,
                  counterText: "",
                  border: InputBorder.none,
                  prefixIcon: prefixIcon,
                  suffixIcon: endWidget,
                  contentPadding:
                      hasSuffixSecurityIcon ? EdgeInsets.zero : contentPadding,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: hintColor,
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                  ).apply(
                    fontSizeDelta:
                        context.locale.toString() == 'en' ? 0.0 : -2.0,
                    fontSizeFactor: 1.0,
                  ),
                ),
              ),
              if (isMandatory)
                Positioned(
                  left: prefixIcon == null ? 10 : 60,
                  top: 10,
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (errorMessage!.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width,
            child: CustomText(
              textAlign: TextAlign.start,
              padding: EdgeInsetsDirectional.only(top: 5),
              title: errorMessage!,
              textColor: AppColors.ERRORS_RED,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              maxLines: 2,
            ),
          ),
      ],
    );
  }
}
