import 'package:flutter/material.dart';

import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_tab_bar_item.dart';
import 'package:katkoot_elwady/features/guides_management/screens/category_videos_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/faqs_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/guides_screen.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_widget.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/suppliers_widget.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:katkoot_elwady/features/search_management/screens/search_all_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/tools_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app_base/screens/custom_drawer.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "./search_screen";

  final TabController tabController;
  final SearchModel? searchData;

  SearchScreen({
    required this.tabController,
    required this.searchData,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late GuidesTabBarViewModel viewModel;
  ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: _selectedIndex,
        length: widget.searchData?.numberOfAvailableSections ?? 0,
        child: Scaffold(
          drawer: CustomDrawer(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: Stack(
                children: [
                  GuidesTabBarWidget(
                      Scrollable: true,
                      tabs: [
                        if ((widget.searchData?.numberOfAvailableSections ??
                                0) !=
                            0)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.topic,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: 'all'.tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  title: 'all'.tr(),
                                  maxLines: 1,
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.Snow,
                                ),
                              )),
                        if ((widget.searchData?.guidesData?.guides ?? [])
                            .isNotEmpty)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.topic,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: 'str_tab_guides'.tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  title: 'str_tab_guides'.tr(),
                                  fontWeight: FontWeight.w700,
                                  maxLines: 1,
                                  textColor: AppColors.Snow,
                                ),
                              )),
                        if ((widget.searchData?.faqsData?.faqs ?? [])
                            .isNotEmpty)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.faqs,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: "str_tab_guides_faqs".tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  title: 'str_tab_guides_faqs'.tr(),
                                  fontWeight: FontWeight.w700,
                                  maxLines: 1,
                                  textColor: AppColors.Snow,
                                ),
                              )),
                        if ((widget.searchData?.videosData?.videos ?? [])
                            .isNotEmpty)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.videos,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: "str_tab_guides_videos".tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  maxLines: 1,
                                  title: 'str_tab_guides_videos'.tr(),
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.Snow,
                                ),
                              )),
                        if ((widget.searchData?.toolsData?.tools ?? [])
                            .isNotEmpty)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.topic,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: 'str_tab_tool'.tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  title: 'str_tab_tool'.tr(),
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.Snow,
                                  maxLines: 1,
                                ),
                              )),
                        if ((widget.searchData?.suppliersData?.suppliers ?? [])
                            .isNotEmpty)
                          TabbarData(
                              isFromSearchAppBar: true,
                              key: GuidesTabBarItem.topic,
                              inActiveWidget: FittedBox(
                                child: CustomText(
                                  title: 'str_wadi_team'.tr(),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              activeWidget: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: AppColors.Olive_Drab,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: CustomText(
                                  maxLines: 1,
                                  title: 'str_wadi_team'.tr(),
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.Snow,
                                ),
                              )),
                      ],
                      category: Category(),
                      tabController: widget.tabController),
                ],
              )),
          body: TabBarView(
            controller: widget.tabController,
            children: [
              if ((widget.searchData?.numberOfAvailableSections ?? 0) != 0)
                SearchAllScreen(
                  searchData: widget.searchData,
                  controller: widget.tabController,
                ),
              if ((widget.searchData?.guidesData?.guides ?? []).isNotEmpty)
                GuidesScreen(
                  controller: widget.tabController,
                ),
              if ((widget.searchData?.faqsData?.faqs ?? []).isNotEmpty)
                FaqsScreen(
                  category: Category(),
                  searchScreen: true,
                ),
              if ((widget.searchData?.videosData?.videos ?? []).isNotEmpty)
                CategoryVideosScreen(
                  category: Category(),
                  searchScreen: true,
                ),
              if ((widget.searchData?.toolsData?.tools ?? []).isNotEmpty)
                ToolsScreen(
                  category: Category(),
                  searchScreen: true,
                ),
              if ((widget.searchData?.suppliersData?.suppliers ?? [])
                  .isNotEmpty)
                SuppliersWidget(
                  fromSearchScreen: true,
                ),
            ],
          ),
        ));
  }
}
