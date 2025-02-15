import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class FlexibleTapBarDelegate extends SliverPersistentHeaderDelegate {
  FlexibleTapBarDelegate({
    required this.body,
    required this.preferredSize,
    this.padding = const EdgeInsets.only(top: 10)
  });

  final Widget body;
  final double preferredSize;
  final EdgeInsets? padding;

  @override
  double get minExtent => preferredSize + 10;
  @override
  double get maxExtent => preferredSize + 10;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: AppColors.DARK_SPRING_GREEN,
      padding: padding,
      child: body,
    );
  }

  @override
  bool shouldRebuild(FlexibleTapBarDelegate oldDelegate) {
    return false;
  }
}