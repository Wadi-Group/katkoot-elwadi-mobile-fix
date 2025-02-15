import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/category_management/screens/category_details_screen.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_tab_bar_item.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_widget.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/tools_management/screens/tools_screen.dart';

import 'faqs_screen.dart';
import 'topics_screen.dart';
import 'category_videos_screen.dart';

class CategoryGuidesScreen extends StatefulWidget {
  static const routeName = "./category_guides";

  final Category category;

  const CategoryGuidesScreen({required this.category});

  @override
  _CategoryGuidesScreenState createState() => _CategoryGuidesScreenState();
}

class _CategoryGuidesScreenState extends State<CategoryGuidesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late GuidesTabBarViewModel viewModel;

  @override
  void initState() {
    super.initState();
    initViewModel();
    _tabController = new TabController(
        vsync: this, length: widget.category.getGuidesTabsNumber());
    _tabController.addListener(_handleTabSelection);
  }

  Future initViewModel() async {
    await Future.delayed(Duration.zero, () {
      viewModel = ProviderScope.containerOf(context,
          listen: false).read(di.guidesTabBarViewModelProvider.notifier);
      viewModel.resetState();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.category.getGuidesTabsNumber(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Consumer(builder: (_, ref, __) {
            var modelView = ref.watch(di.guidesTabBarViewModelProvider);
            var modelViewActions =
            ref.watch(di.guidesTabBarViewModelProvider.notifier);
            var tabs = modelViewActions.getTabs(
                modelView.data!.guidesTabBarItem as GuidesTabBarItem,
                widget.category);
            return GuidesTabBarWidget(
                tabs: tabs,
                category: widget.category,
                tabController: _tabController,
                guidesTabBarViewModel: modelViewActions);
          }),
        ),
        body: TabBarView(
          controller: _tabController,
          //physics: NeverScrollableScrollPhysics(),
          //controller: TabController(length: 3,initialIndex: 0,vsync: TickerProvider()).addListener(() { }) ,
          children: [
            if (widget.category.haveGuides ?? true)
              TopicsScreen(category: widget.category),
            if (widget.category.haveFaqs ?? true)
              FaqsScreen(category: widget.category),
            if (widget.category.haveVideos ?? true)
              CategoryVideosScreen(category: widget.category),
          ],
        ),

        // body: CarouselSlider(
        //   options: CarouselOptions(
        //     viewportFraction: 1,
        //     height: MediaQuery.of(context).size.height,
        //     onPageChanged: (index,_){
        //       if(index >= 0 && index <= 2){
        //         _tabController.index = index;
        //       } else {
        //
        //       }
        //
        //     }
        //   ),
        //   items: [
        //     if (widget.category.haveGuides ?? true)
        //       TopicsScreen(category: widget.category),
        //     if (widget.category.haveFaqs ?? true)
        //       FaqsScreen(category: widget.category),
        //     if (widget.category.haveVideos ?? true)
        //       CategoryVideosScreen(category: widget.category),
        //     CategoryDetailsScreen(category: widget.category),
        //     if (widget.category.haveTools ?? true)
        //       ToolsScreen(
        //         category: widget.category,
        //       ),
        //   ],
        // )
      ),
    );
  }

  void _handleTabSelection() {
    if (_tabController.previousIndex != _tabController.index)
      viewModel.changeTabSelection(viewModel.state.data!.tabs![_tabController.index].key);
  }
}
