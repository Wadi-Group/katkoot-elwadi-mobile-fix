import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  Widget? startIcon;
  Widget? endIcon;
  String title;
  double fontSize;
  final FontWeight fontWeight;
  Color? textColor;
  Color? backgroundColor;
  String? fontFamily;
  TextOverflow? textOverflow;
  double? lineSpacing;
  int? maxLines;
  double? border;
  TextAlign? textAlign;
  EdgeInsetsGeometry? padding;
  final bool underline;
  Function? onTap;

  CustomTextButton({required this.title,
    this.fontSize = 18,
    this.startIcon,
    this.endIcon,
    this.backgroundColor,
    this.textOverflow,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.border,
    this.fontFamily,
    this.lineSpacing,
    this.padding,
    this.textAlign,
    required this.onTap,
    this.underline = false});

  @override
  Widget build(BuildContext context) {
    return
      TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(border ?? 0),
                )),
            backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? AppColors.Olive_Drab)),
        onPressed: ()=> onTap != null ? onTap!() : (){},
        child: Padding(
          padding: padding ?? EdgeInsets.all(0),
          child: Row(
            children: [
              if(startIcon != null || endIcon != null) Expanded(flex:1,child: startIcon ?? Container()),
              Expanded(
                flex:3,
                child: Text(
                  title,
                  textAlign: textAlign ?? TextAlign.center,
                  maxLines: maxLines,
                  style: TextStyle(
                    height: lineSpacing ?? null,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                    color: textColor ?? AppColors.white,
                    decoration:
                    underline ? TextDecoration.underline : TextDecoration.none,
                  ),
                  overflow: textOverflow,
                ),
              ),
              if(startIcon != null || endIcon != null) Expanded(flex:1,child: endIcon ?? Container()),
            ],
          ),
        ),

      );
  }
}
