import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_bar_state.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_tab_bar_item.dart';
import 'package:riverpod/riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class GuidesTabBarViewModel extends StateNotifier<BaseState<GuidesTabBarState?>>
    with BaseViewModel {
  Repository _repository;

  GuidesTabBarViewModel(this._repository)
      : super(BaseState(
            data: GuidesTabBarState(guidesTabBarItem: GuidesTabBarItem.topic)));

  changeTabSelection(GuidesTabBarItem item) {
    // var item = getTabFromKey(
    //     (((tab as Tab).key) as ValueKey<GuidesTabBarItem>).value.toString());

    if (item == this.state.data?.guidesTabBarItem) {
      // Navigator.of(AppConstants.navigatorKey.currentContext!).pop();
      return;
    }
    this.state = BaseState(
        data: GuidesTabBarState(
            guidesTabBarItem: item,
            tabs: state.data?.tabs,
            category: state.data?.category));
    // Navigator.of(AppConstants.navigatorKey.currentContext!).pop();
  }

  getTabFromKey(String tabName) {
    switch (tabName) {
      case "GuidesTabBarItem.topic":
        return GuidesTabBarItem.topic;
      case "GuidesTabBarItem.faqs":
        return GuidesTabBarItem.faqs;
      case "GuidesTabBarItem.videos":
        return GuidesTabBarItem.videos;
    }
  }

  List<TabbarData<GuidesTabBarItem>> getTabs(
      GuidesTabBarItem item, Category category) {
    state.data?.category = category;
    var list = [
      if (category.haveGuides!)
        TabbarData(
            key: GuidesTabBarItem.topic,
            inActiveWidget: CustomText(
              title: 'str_tab_guides_topics'.tr(),
              fontWeight: FontWeight.w700,
            ),
            activeWidget: Icon(KatkootELWadyIcons.topics,
                color: AppColors.DARK_SPRING_GREEN, size: 20)),
      if (category.haveFaqs!)
        TabbarData(
            key: GuidesTabBarItem.faqs,
            inActiveWidget: CustomText(
              title: "str_tab_guides_faqs".tr(),
              fontWeight: FontWeight.w700,
            ),
            activeWidget: Icon(KatkootELWadyIcons.faq,
                color: AppColors.DARK_SPRING_GREEN, size: 20)),
      if (category.haveVideos!)
        TabbarData(
            key: GuidesTabBarItem.videos,
            inActiveWidget: CustomText(
              title: "str_tab_guides_videos".tr(),
              fontWeight: FontWeight.w700,
            ),
            activeWidget: Icon(KatkootELWadyIcons.video,
                color: AppColors.DARK_SPRING_GREEN, size: 40)),
    ];
    state.data?.tabs = list;
    return list;
    // switch (item) {
    //   case GuidesTabBarItem.topic:
    //     {
    //       return [
    //         Tab(
    //           key: ValueKey(GuidesTabBarItem.topic),
    //           icon: Icon(KatkootELWadyIcons.topics,
    //               color: AppColors.DARK_SPRING_GREEN, size: 20),
    //         ),
    //         if (category.haveFaqs!)
    //           Tab(
    //             key: ValueKey(GuidesTabBarItem.faqs),
    //             text: "str_tab_guides_faqs".tr(),
    //           ),
    //         if (category.haveVideos!)
    //           Tab(
    //             key: ValueKey(GuidesTabBarItem.videos),
    //             text: "str_tab_guides_videos".tr(),
    //           )
    //       ];
    //     }
    //   case GuidesTabBarItem.faqs:
    //     {
    //       return [
    //         Tab(
    //           key: ValueKey(GuidesTabBarItem.topic),
    //           text: 'str_tab_guides_topics'.tr(),
    //         ),
    //         Tab(
    //           key: ValueKey(GuidesTabBarItem.faqs),
    //           icon: Icon(KatkootELWadyIcons.faq,
    //               color: AppColors.DARK_SPRING_GREEN, size: 20),
    //         ),
    //         if (category.haveVideos!)
    //           Tab(
    //             key: ValueKey(GuidesTabBarItem.videos),
    //             text: "str_tab_guides_videos".tr(),
    //           )
    //       ];
    //     }
    //   case GuidesTabBarItem.videos:
    //     {
    //       return [
    //         Tab(
    //           key: ValueKey(GuidesTabBarItem.topic),
    //           text: "str_tab_guides_topics".tr(),
    //         ),
    //         if (category.haveFaqs!)
    //           Tab(
    //             key: ValueKey(GuidesTabBarItem.faqs),
    //             text: "str_tab_guides_faqs".tr(),
    //           ),
    //         Tab(
    //           key: ValueKey(GuidesTabBarItem.videos),
    //           icon: Icon(KatkootELWadyIcons.video_1,
    //               color: AppColors.DARK_SPRING_GREEN, size: 20),
    //         )
    //       ];
    //     }
    // }
  }

  @override
  void dispose() {
    state = BaseState(
        data: GuidesTabBarState(
            guidesTabBarItem: GuidesTabBarItem.topic,
            tabs: [],
            category: null));
    super.dispose();
  }

  void resetState() {
    state = BaseState(
        data: GuidesTabBarState(
            guidesTabBarItem: GuidesTabBarItem.topic,
            tabs: [],
            category: null));
  }
}
