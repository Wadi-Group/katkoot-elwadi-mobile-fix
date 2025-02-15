import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/entities/app_bar_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/tab_bar_item.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class AppBarTabsViewModel extends StateNotifier<BaseState<AppBarState?>>
    with BaseViewModel {
  Repository _repository;
  AppBarTabsViewModel(this._repository)
      : super(BaseState(data: AppBarState(tabBarItem: TabBarItem.home)));

  changeTabSelection(TabBarItem item) {
    // var item = tab;
    if (item == this.state.data?.tabBarItem) {
      // Navigator.of(AppConstants.navigatorKey.currentContext!).pop();
      return;
    }
    UserData? userData = ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
        listen: false).read(di.userViewModelProvider);
    // if (userData == null && item == TabBarItem.tool) {
    //   Navigator.of(AppConstants.navigatorKey.currentContext!).pop();
    //   navigateToScreen(LoginScreen.routeName);
    // }
    this.state = BaseState(
        data: AppBarState(
            tabBarItem: item,
            tabs: state.data?.tabs,
            category: state.data?.category));
    // Navigator.of(AppConstants.navigatorKey.currentContext!).pop();
  }

  getTabFromKey(String tabName) {
    switch (tabName) {
      case "TabBarItem.home":
        return TabBarItem.home;
      case "TabBarItem.tool":
        return TabBarItem.tool;
      case "TabBarItem.guides":
        return TabBarItem.guides;
    }
  }

  List<TabbarData<TabBarItem>> getTabs(Category category) {
    state.data?.category = category;
    var list = [
      TabbarData<TabBarItem>(
          key: TabBarItem.home,
          activeWidget: Icon(
            KatkootELWadyIcons.house_2,
            color: Colors.white,
            size: 20,
          ),
          inActiveWidget: CustomText(
            title: "str_tab_home".tr(),
            textColor: AppColors.Liver,
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          )),
      if (category.haveTools!)
        TabbarData(
          key: TabBarItem.tool,
          inActiveWidget: CustomText(
            title: "str_tab_tool".tr(),
            textColor: AppColors.Liver,
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          activeWidget: Icon(
            KatkootELWadyIcons.tool_nr,
            color: Colors.white,
            size: 20,
          ),
        ),
      if (category.haveVideos! || category.haveGuides! || category.haveFaqs!)
        TabbarData(
          key: TabBarItem.guides,
          inActiveWidget: CustomText(
            title: "str_tab_guides".tr(),
            textColor: AppColors.Liver,
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          activeWidget:
              // key: ValueKey(TabBarItem.guides),
              Icon(
            KatkootELWadyIcons.guide,
            color: Colors.white,
            size: 20,
          ),
        )
    ];
    state.data?.tabs = list;
    return list;
  }

  @override
  void dispose() {
    state = BaseState(
        data:
            AppBarState(tabBarItem: TabBarItem.home, tabs: [], category: null));
    super.dispose();
  }

  void resetState() {
    state = BaseState(
        data:
            AppBarState(tabBarItem: TabBarItem.home, tabs: [], category: null));
  }
}
