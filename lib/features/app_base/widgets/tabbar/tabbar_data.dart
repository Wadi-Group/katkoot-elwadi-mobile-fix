import 'package:flutter/material.dart';

class TabbarData<T> {
  final Widget? activeWidget;
  final Widget inActiveWidget;
  bool isFromSearchAppBar;
  final T key;
  TabbarData(
      {this.activeWidget,
      required this.inActiveWidget,
      required this.key,
      this.isFromSearchAppBar = false});
}
