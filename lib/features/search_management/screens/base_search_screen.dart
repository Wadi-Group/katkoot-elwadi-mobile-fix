import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/search_management/screens/serach_screen.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';

import '../../../../core/di/injection_container.dart' as di;
import '../../app_base/screens/custom_drawer.dart';

class BaseSearchScreen extends StatefulWidget {
  @override
  _BaseSearchScreenState createState() => _BaseSearchScreenState();
}

class _BaseSearchScreenState extends State<BaseSearchScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = new TabController(vsync: this, length: 0);
    getSearchData();
  }

  getSearchData() async {
    Future.delayed(Duration(microseconds: 0), () {
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.searchViewModelProvider.notifier)
          .getsearchResult(ProviderScope.containerOf(
                  AppConstants.navigatorKey.currentContext!,
                  listen: false)
              .read(di.searchContentProvider));
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(
          hasbackButton: false,
          isSearchAppBar: true,
          onSearchSubmit: () {
            tabController.animateTo(0);
            getSearchData();
          }),
      body: Consumer(builder: (_, ref, __) {
        var viewModel = ref.watch(di.searchViewModelProvider);
        var data = viewModel.data;

        tabController = TabController(
            vsync: this, length: data?.numberOfAvailableSections ?? 0);
        return Stack(
          children: [
            SearchScreen(
              tabController: tabController,
              searchData: data,
            ),
            ScreenHandler(
              screenProvider: di.searchViewModelProvider,
              noDataMessage: "str_no_data".tr(),
              noDataWidget: NoDataWidget(),
            ),
            Consumer(
              builder: (_, ref, __) {
                var searchText = ref.watch(di.searchContentProvider);
                var isEmpty = searchText.trim().isEmpty;
                if (isEmpty) {
                  return SearchPlaceHolder();
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
