import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  String title;
  double fontSize;
  final FontWeight fontWeight;
  Color? textColor;
  String? fontFamily;
  TextOverflow? textOverflow;
  double? lineSpacing;
  int? maxLines;
  TextAlign? textAlign;
  EdgeInsetsGeometry? padding;
  final bool underline;
  final bool italic;

  CustomText({
    required this.title,
    this.fontSize = 14,
    this.textOverflow,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.fontFamily,
    this.lineSpacing,
    this.padding,
    this.textAlign,
    this.underline = false,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        title,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        style: TextStyle(
          height: lineSpacing ?? null,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          color: textColor ?? AppColors.Liver,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
        ),
        overflow: textOverflow,
      ),
    );
  }
}
