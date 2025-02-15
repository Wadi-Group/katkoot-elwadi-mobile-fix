import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:katkoot_elwady/core/constants/app_colors.dart';

import 'animated_interpolation.dart';
import 'tabbar_data.dart';
import 'tabbar_item.dart';

class AppTabbar extends StatefulWidget implements PreferredSizeWidget {
  final TabController? tabController;
  final Function()? onTapPressed;
  final List<TabbarData> tabs;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  AppTabbar({
    Key? key,
    this.tabController,
    this.onTapPressed,
    required this.tabs,
    this.decoration,
    this.backgroundColor,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  _AppTabbarState createState() => _AppTabbarState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppTabbarState extends State<AppTabbar>
    with SingleTickerProviderStateMixin {
  TabController? get controller =>
      widget.tabController ?? DefaultTabController.of(context);
  Animation<double> get animation =>
      controller?.animation ?? AnimationController(vsync: this);
  List<TabbarData> get tabs => widget.tabs;

  onSelectTab(int index) {
    controller?.animateTo(index);
    if (widget.onTapPressed != null) {
      widget.onTapPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(controller != null,
        "you need to provide tabcontroller or use default tab controller widget");
    assert(controller?.length == tabs.length,
        "tabs length not equal controller length");
    var width = MediaQuery.of(context).size.width -
        (widget.padding?.horizontal ?? 4) -
        (widget.margin?.horizontal ?? 30);
    var tabWidth = width / tabs.length;
    return DefaultTextStyle(
      style: Theme.of(context).tabBarTheme.labelStyle ?? const TextStyle(),
      child: Container(
        color: widget.backgroundColor ?? Colors.transparent,
        height: 55,
        child: Padding(
          padding: widget.margin ??
              const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Material(
            borderRadius: BorderRadius.circular(60), // Creates border
            color: AppColors.white,
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(2),
              child: Stack(
                children: [
                  AlignTransition(
                      alignment: animation.drive(AlignmentTween(
                        begin: AlignmentDirectional.topStart
                            .resolve(Directionality.of(context)),
                        end: AlignmentDirectional(
                                lerpDouble(
                                    -1,
                                    1,
                                    tabs.length > 1
                                        ? 1 / (tabs.length - 1)
                                        : 0)!,
                                -1)
                            .resolve(Directionality.of(context)),
                      )),
                      child: DecoratedBox(
                        decoration: widget.decoration ??
                            BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    100), // Creates border
                                color: AppColors.Olive_Drab),
                        child: SizedBox(
                          height: double.infinity,
                          width: tabWidth,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: tabs
                          .mapIndexed((index, e) => Expanded(
                                  child: InkWell(
                                onTap: () => onSelectTab(index),
                                borderRadius: BorderRadius.circular(60),
                                child: TabBarItem(
                                  data: e,
                                  animation: animation.drive(InterpolationTween(
                                    inputRange: [
                                      // index - 1,
                                      index - 0.1,
                                      index.toDouble(),
                                      index + 0.1
                                    ],
                                    outputRange: [0.0, 1.0, 0.0],
                                  )),
                                ),
                              )))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
