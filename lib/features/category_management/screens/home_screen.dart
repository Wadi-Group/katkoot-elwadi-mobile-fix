import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/category_management/widgets/category_tab_widget.dart';
import '../../../core/di/injection_container.dart' as di;

class HomeScreen extends StatefulWidget with BaseViewModel {
  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initUserLocalData();
    getListOfCategories();
  }

  Future getListOfCategories() async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      ProviderScope.containerOf(context,
          listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .getRemoteUnseenNotificationCount();
      ProviderScope.containerOf(context,
          listen: false)
          .read(di.categoriesViewModelProvider.notifier)
          .getListOfCategories(mainCategories: true);
    });
  }

  Future initUserLocalData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(di.userViewModelProvider.notifier).getLocalUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.15
                        : MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      "assets/images/img.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Consumer(builder: (_, ref, __) {
                      var categoriesViewModel =
                      ref.watch(di.categoriesViewModelProvider);
                      var categories = categoriesViewModel.data;
                      return ListView.builder(
                        itemCount: categories!.length,
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
                        itemBuilder: (context, index) => Center(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: MediaQuery.of(context).size.height * 0.025,
                            ),
                            child: CategoryTabWidget(
                              category: categories[index],
                            ),
                          ),
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          Consumer(
            builder: (_, watch, __) {
              return ScreenHandler(
                screenProvider: di.categoriesViewModelProvider,
                noDataMessage: "str_no_data".tr(),
                onDeviceReconnected: getListOfCategories,
                noDataWidget: NoDataWidget(),
              );
            },
          ),
          Consumer(
            builder: (_, watch, __) {
              return ScreenHandler(
                screenProvider: di.navigationDrawerViewModelProvider,
                noDataMessage: "str_no_data".tr(),
                onDeviceReconnected: () {},
                noDataWidget: NoDataWidget(),
              );
            },
          ),
        ],
      ),
    );
  }

  var customAppBar = CustomAppBar(
    showDrawer: true,
    showNotificationsButton: true,
    hasbackButton: false,
  );


}
