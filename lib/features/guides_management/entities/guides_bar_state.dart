import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

import 'guides_tab_bar_item.dart';

class GuidesTabBarState {
  Category? category;
  GuidesTabBarItem? guidesTabBarItem;
  List<TabbarData<GuidesTabBarItem>>?  tabs;


  GuidesTabBarState({
    this.category,
    this.guidesTabBarItem,
    this.tabs
  });
}