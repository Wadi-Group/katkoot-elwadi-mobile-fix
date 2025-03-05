import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/rendering.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/app_bar_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/app_bar_tabs_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/app_tabbar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/flexible_tabbar_delegate.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/category_management/screens/category_details_screen.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_tab_bar_item.dart';
import 'package:katkoot_elwady/features/guides_management/screens/category_videos_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/faqs_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/topics_screen.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_widget.dart';
import 'package:katkoot_elwady/features/tools_management/screens/tools_screen.dart';

import '../../../core/di/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetailsBaseScreenModification extends StatefulWidget {
  static const routeName = "./category_base";
  final Category category;

  const CategoryDetailsBaseScreenModification(
      {Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryDetailsBaseScreenModificationState createState() =>
      _CategoryDetailsBaseScreenModificationState();
}

class _CategoryDetailsBaseScreenModificationState
    extends State<CategoryDetailsBaseScreenModification>
    with TickerProviderStateMixin {
  late TabController _categoryTapsController;
  late TabController _guidesTapsController;
  late CarouselSliderController _carouselController;
  late ScrollController _scrollController = ScrollController();
  final _categoryTapsIndexNotifier = ValueNotifier<int>(0);

  final _categoryTapsViewModelProvider =
      StateNotifierProvider<AppBarTabsViewModel, BaseState<AppBarState?>>(
          (ref) {
    return AppBarTabsViewModel(ref.read(di.repositoryProvider));
  });

  @override
  void initState() {
    super.initState();
    _categoryTapsController =
        new TabController(vsync: this, length: widget.category.getTabsNumber());

    _guidesTapsController = new TabController(
        vsync: this, length: widget.category.getGuidesTabsNumber());

    _carouselController = CarouselSliderController();

    // _categoryTapsController.addListener(_handleCategoriesTabSelection);
    // _guidesTapsController.addListener(_handleGuidesTabSelection);
  }

  @override
  void dispose() {
    _categoryTapsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppConstants.navigatorKey.currentContext?.locale.toString();

    return DefaultTabController(
      initialIndex: 0,
      length: widget.category.getTabsNumber(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.DARK_SPRING_GREEN,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 0),
        body: ValueListenableBuilder(
            valueListenable: _categoryTapsIndexNotifier,
            builder: (context, index, child) {
              return Container(
                color: Colors.white,
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                          backgroundColor: AppColors.DARK_SPRING_GREEN,
                          collapsedHeight: kToolbarHeight,
                          foregroundColor: Colors.white,
                          floating: false,
                          flexibleSpace: FlexibleSpaceBar(
                            stretchModes: [StretchMode.fadeTitle],
                            background: Image.asset(
                                locale != "ar"
                                    ? "assets/images/logo.png"
                                    : "assets/images/ic_logo_ar.png",
                                fit: BoxFit.contain,
                                height: kToolbarHeight - 15),
                          )),
                      SliverPersistentHeader(
                        delegate: FlexibleTapBarDelegate(
                            body: Column(
                              children: [
                                Consumer(builder: (_, ref, __) {
                                  var categoryTapsViewModel = ref.watch(
                                      _categoryTapsViewModelProvider.notifier);
                                  var tabs = categoryTapsViewModel
                                      .getTabs(widget.category);

                                  return Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start:
                                            MediaQuery.of(context).padding.left,
                                        end: MediaQuery.of(context)
                                            .padding
                                            .right),
                                    child: AppTabbar(
                                      tabController: _categoryTapsController,
                                      tabs: tabs,
                                      onTapPressed: () {
                                        _handleCategoriesTabSelection();
                                      },
                                    ),
                                  );
                                }),
                                Consumer(builder: (_, ref, __) {
                                  var guidesTapsState = ref
                                      .watch(di.guidesTabBarViewModelProvider);
                                  var guidesTapsViewModel = ref.watch(di
                                      .guidesTabBarViewModelProvider.notifier);
                                  var tabs = guidesTapsViewModel.getTabs(
                                      guidesTapsState.data!.guidesTabBarItem
                                          as GuidesTabBarItem,
                                      widget.category);

                                  return (index ==
                                          _categoryTapsController.length - 1)
                                      ? GuidesTabBarWidget(
                                          tabs: tabs,
                                          category: widget.category,
                                          tabController: _guidesTapsController,
                                          onTapPressed: () {
                                            _handleGuidesTabSelection();
                                          },
                                          guidesTabBarViewModel:
                                              guidesTapsViewModel)
                                      : Container();
                                }),
                              ],
                            ),
                            preferredSize:
                                (index == _categoryTapsController.length - 1)
                                    ? 111
                                    : 55),
                        pinned: true,
                      )
                    ];
                  },
                  body: SafeArea(
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                          viewportFraction: 1,
                          height: MediaQuery.of(context).size.height,
                          onPageChanged: (index, reason) {
                            print('reason ${reason.toString()}');
                            if (index >= 0 &&
                                index < _categoryTapsController.length) {
                              _categoryTapsController.index = index;
                              _categoryTapsIndexNotifier.value =
                                  _categoryTapsController.index;
                              if (index == _categoryTapsController.length - 1) {
                                _guidesTapsController.index = 0;
                              }
                            } else {
                              _guidesTapsController.index =
                                  index - (_categoryTapsController.length - 1);
                              if ((index ==
                                          _categoryTapsController.length + 1 &&
                                      _guidesTapsController.length.isOdd) ||
                                  (index == _categoryTapsController.length &&
                                      _guidesTapsController.length.isEven)) {
                                _categoryTapsController.index =
                                    _categoryTapsController.length - 1;
                                _categoryTapsIndexNotifier.value =
                                    _categoryTapsController.length - 1;
                              }
                            }
                          }),
                      items: [
                        CategoryDetailsScreen(category: widget.category),
                        if (widget.category.haveTools ?? true)
                          ToolsScreen(category: widget.category),
                        if (widget.category.haveGuides ?? true)
                          TopicsScreen(
                              category: widget.category,
                              scrollController: _scrollController),
                        if (widget.category.haveFaqs ?? true)
                          FaqsScreen(
                              category: widget.category,
                              scrollController: _scrollController),
                        if (widget.category.haveVideos ?? true)
                          CategoryVideosScreen(
                              category: widget.category,
                              scrollController: _scrollController),
                      ],
                    ),
                  ),
                ),
              );
            }),
        // bottomNavigationBar: BottomNavigationBarWidget(
        //   shouldPop: true,
        // )
      ),
    );
  }

  void _handleCategoriesTabSelection() {
    if (_categoryTapsController.previousIndex !=
        _categoryTapsController.index) {
      _carouselController.jumpToPage(_categoryTapsController.index);
    }
  }

  void _handleGuidesTabSelection() {
    if (_guidesTapsController.previousIndex != _guidesTapsController.index) {
      _carouselController.jumpToPage(
          _guidesTapsController.index + (_categoryTapsController.length - 1));
    }
  }
}
