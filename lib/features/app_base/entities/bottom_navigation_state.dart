import 'package:flutter/material.dart';

class BottomNavigationState {
  int selectedIndex;
  TabController? controller;


  BottomNavigationState({
    this.selectedIndex = 0,
    this.controller,
  });
}