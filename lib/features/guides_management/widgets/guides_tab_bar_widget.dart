import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/app_tabbar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_view_model.dart';

class GuidesTabBarWidget extends StatefulWidget {
  final Category category;
  final GuidesTabBarViewModel? guidesTabBarViewModel;
  final TabController? tabController;
  final List<TabbarData>? tabs;
  bool Scrollable;
  final Function()? onTapPressed;

  GuidesTabBarWidget(
      {required this.category,
      this.guidesTabBarViewModel,
      required this.tabController,
      required this.tabs,
      this.Scrollable = false,
      this.onTapPressed});

  @override
  _GuidesTabBarWidgetState createState() => _GuidesTabBarWidgetState();
}

class _GuidesTabBarWidgetState extends State<GuidesTabBarWidget> {
  ScrollController scrollController = ScrollController();

  Future handleTabBarScrolling() async {
    await Future.delayed(Duration.zero, () {
      if (widget.Scrollable && (widget.tabs?.length ?? 0) > 3) {
        double tabItemWidth = (MediaQuery.of(context).size.width * 1.5) /
            (widget.tabs?.length ?? 1);

        widget.tabController?.addListener(() {
            scrollController.animateTo(
              ((widget.tabController?.index ?? 0)-1) * tabItemWidth,
              curve: Curves.ease,
              duration: Duration(milliseconds: 400),
            );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    handleTabBarScrolling();

    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      physics: ClampingScrollPhysics(),
      child: Container(
        height: widget.Scrollable ? 70 : null,
        width: widget.Scrollable && (widget.tabs?.length ?? 0) > 3
            ? MediaQuery.of(context).size.width * 1.5
            : MediaQuery.of(context).size.width * 1,
        child: Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: widget.Scrollable
                    ? null
                    : Border(
                        bottom:
                            BorderSide(color: AppColors.Ash_grey, width: 1)),
                color: AppColors.white),
            child: AppTabbar(
              tabs: widget.tabs!,
              tabController: widget.tabController,
              onTapPressed: widget.onTapPressed,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                  color: widget.Scrollable
                      ? Colors.transparent
                      : AppColors.Dark_spring_green,
                ),
              ),
            )
            // TabBar(
            //   indicatorColor: AppColors.Dark_spring_green,
            //   indicatorWeight: 2.0,
            //   controller: controller,
            //   unselectedLabelColor: AppColors.Dim_gray,
            //   labelStyle:TextStyle (
            //     fontWeight: FontWeight.w700
            // ),
            // indicator: BoxDecoration(
            //     borderRadius:
            //     BorderRadius.circular(100), // Creates border
            //     color: AppColors.Olive_Drab),
            //   indicatorSize: TabBarIndicatorSize.tab,
            //   tabs: tabs!.map((e) => e.inActiveWidget).toList(),
            //   // onTap: (index) {
            //   //   guidesTabBarViewModel?.changeTabSelection(tabs![index]);
            //   // },
            // ),

            ),
      ),
    );
  }
}
