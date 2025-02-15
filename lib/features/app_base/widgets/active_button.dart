import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  Function onPressed;
  String title;
  double fontSize;
  FontWeight fontWeight;
  Color? textColor;
  Color? backgroundColor;
  String? fontFamily;
  bool? isShrinkable;
  double? lineSpacing;
  bool? borderAsText;
  int? maxLines;
  TextAlign? textAlign;
  EdgeInsetsGeometry? padding;
  double radiusCorners;

  CustomElevatedButton(
      {required this.title,
      required this.onPressed,
      this.fontSize = 20,
      this.isShrinkable,
      this.maxLines,
      this.fontWeight = FontWeight.normal,
      this.textColor,
      this.fontFamily,
      this.borderAsText,
      this.lineSpacing,
      this.backgroundColor,
      this.padding,
      this.textAlign,
      this.radiusCorners = 30});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
            border: Border.all(
              color: (borderAsText != null && borderAsText == true)
                  ? textColor ?? AppColors.white
                  : backgroundColor ?? AppColors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(radiusCorners)),
            color: backgroundColor),
        padding: padding ?? EdgeInsets.all(10),
        child: Text(
          title,
          textAlign: textAlign ?? TextAlign.center,
          maxLines: maxLines,
          style: TextStyle(
              height: lineSpacing ?? null,
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor ?? AppColors.Liver),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
