import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ReusableContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;

  const ReusableContainer({
    Key? key,
    required this.child,
    this.height = 50,
    this.borderRadius,
    this.boxShadow,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(8)),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
        color: Colors.white,
      ),
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}
