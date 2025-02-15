import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/flexible_tabbar_delegate.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_pullet_screen.dart';

import 'parent_flock_management_broiler_screen.dart';

class ParentFlockManagementScreenData {
  final Category? category;
  final int? toolId;

  ParentFlockManagementScreenData(
      {required this.category, required this.toolId});
}

class ParentFlockManagementScreen extends StatefulWidget {
  static const routeName = "./parent_flock_management";
  final Category? category;
  final int? toolId;

  const ParentFlockManagementScreen(
      {Key? key, required this.category, required this.toolId})
      : super(key: key);

  @override
  _ParentFlockManagementScreenState createState() =>
      _ParentFlockManagementScreenState();
}

class _ParentFlockManagementScreenState
    extends State<ParentFlockManagementScreen> with TickerProviderStateMixin {
  late final _toolDataProvider = Provider<Tool?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.tool;
  });

  late TabController _tabController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    getToolDetails();

    super.initState();
  }

  Future getToolDetails() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(di.toolDetailsViewModelProvider.notifier)
          .getDetails(widget.toolId, 10);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0),
      body: NestedScrollView(
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
                    background: CustomAppBar(
                        onBackClick: ()=> Navigator.of(context).pop(),
                        title: widget.category?.title ?? '')
                )),
            SliverPersistentHeader(
              delegate: FlexibleTapBarDelegate(
                  body: CustomAppBar(
                    title: '',
                      onBackClick: ()=> Navigator.of(context).pop(),
                      tabs: [
                        TabbarData(
                            key: "broiler",
                            inActiveWidget: CustomText(
                              title: "broiler".tr(),
                              textColor: AppColors.Liver,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                            )),
                        TabbarData(
                            key: "pullets",
                            inActiveWidget: CustomText(
                              title: "pullets".tr(),
                              textColor: AppColors.Liver,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                      controller: _tabController),
                  preferredSize: kToolbarHeight),
              pinned: true,
            )
          ];
        },
        body: Stack(
          children: [
            Consumer(builder: (_, ref, __) {
              var tool = ref.watch(_toolDataProvider);
              return TabBarView(
                controller: _tabController,
                children: [
                  tool != null
                      ? ParentFlockManagementBroilerScreen(
                    tool: tool,
                  )
                      : Container(),
                  tool != null
                      ? ParentFlockManagementPulletsScreen(
                    tool: tool,
                  )
                      : Container(),
                ],
              );
            }),
            ScreenHandler(
              screenProvider: di.toolDetailsViewModelProvider,
              onDeviceReconnected: getToolDetails,
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   shouldPop: true,
      //   shouldPopToHome: false,
      // ),
    );
  }
}
