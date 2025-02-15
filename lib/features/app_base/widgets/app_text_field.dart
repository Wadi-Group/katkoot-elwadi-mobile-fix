import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
  Function? onChange;
  FocusNode? focusNode;
  String? errorMessage;
  int? maxLength;
  List<TextInputFormatter>? inputFormatter;
  //int? maxNumber;

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
    this.hintColor = AppColors.Liver,
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
    this.fillColor = AppColors.Tea_green,
    this.onChange,
    this.focusNode,
    this.errorMessage = "",
    this.maxLength,
    this.inputFormatter,
    //this.maxNumber
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding,
          child: TextFormField(
            inputFormatters: inputFormatter,
            maxLength: maxLength,
            textAlignVertical: TextAlignVertical.center,
            focusNode: focusNode,
            onChanged: (val) {
              if (onChange != null) {
                onChange!;
              }
              if (inputType == TextInputType.number ||
                  inputType == TextInputType.numberWithOptions(decimal: true)) {
                // if(maxNumber != null){
                //   if((double.tryParse(val) ?? maxNumber!) > maxNumber!){
                //     controller.text = maxNumber.toString();
                //     controller.selection = TextSelection.collapsed(offset: maxNumber.toString().length);
                //   }
                // }
                // if(val == '.'){
                //   String newVal = '0'+val;
                //   controller.text = newVal;
                //   controller.selection = TextSelection.collapsed(offset: newVal.length);
                // }
                // else if(val.isNotEmpty && (!RegExp(r"^([0-9]+\.?[0-9]*|\.[0-9]+)$").hasMatch(val) || !RegExp(r"^([\u0660-\u0669]+\,?[\u0660-\u0669]*|\,[\u0660-\u0669]+)$").hasMatch(val))){
                //   controller.text = val.substring(0, val.length - 1);
                //   controller.selection = TextSelection.collapsed(offset: val.length-1);
                // }
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
            obscureText: isSecured ? isSecured : false,
            textAlign: textAlign,
            cursorColor: textColor ?? AppColors.Liver,
            textInputAction: textInputAction ?? TextInputAction.next,
            style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                    color: textColor ?? AppColors.Liver)
                .apply(
                    fontSizeDelta:
                        context.locale.toString() == 'en' ? 0.0 : -2.0,
                    fontSizeFactor: 1.0),
            decoration: InputDecoration(
              isDense: isDense,
              counterText: "",
              fillColor: fillColor,
              filled:
                  true, //controller == null || (controller?.text.isEmpty ?? false),
              border: InputBorder.none,
              focusColor: AppColors.OFF_WHITE,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        showBorder ? AppColors.Tea_green : AppColors.Platinum),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        showBorder ? AppColors.Tea_green : AppColors.Platinum),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        showBorder ? AppColors.Tea_green : AppColors.Platinum),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: endWidget,

              contentPadding:
                  hasSuffixSecurityIcon ? EdgeInsets.zero : contentPadding,
              hintText: hintText,
              hintStyle: TextStyle(
                      color: hintColor,
                      fontFamily: fontFamily,
                      fontSize: fontSize)
                  .apply(
                      fontSizeDelta:
                          context.locale.toString() == 'en' ? 0.0 : -2.0,
                      fontSizeFactor: 1.0),
            ),
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
