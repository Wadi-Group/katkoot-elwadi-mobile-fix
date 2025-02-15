import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/app_base/entities/tab_bar_item.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

class AppBarState {
  Category? category;
  TabBarItem? tabBarItem;
  List<TabbarData<TabBarItem>>?  tabs;


  AppBarState({
    this.category,
    this.tabBarItem,
    this.tabs
  });
}