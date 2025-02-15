import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/entities/navigation_item.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/menu_categorized_videos_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/menu_category_with_videos_item.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/navigation_drawer.dart';

class MenuCategorizedVideosScreen extends StatefulWidget {
  static const routeName = "./menu_categorized_videos_screen";

  @override
  _MenuCategorizedVideosScreenState createState() =>
      _MenuCategorizedVideosScreenState();
}

class _MenuCategorizedVideosScreenState
    extends State<MenuCategorizedVideosScreen> with AutomaticKeepAliveClientMixin {
  final _categorizedVideosViewModelProvider = StateNotifierProvider<
      MenuCategorizedVideosViewModel, BaseState<List<Category>?>>((ref) {
    return MenuCategorizedVideosViewModel(ref.read(di.repositoryProvider));
  });

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
            showNotificationsButton: true,
            showDrawer: true,
            hasbackButton: true,
            // onBackClick: () => context.read(di.contentProvider).state =
            //     DrawerItemType.drawer.index
        ),
        // drawer: NavigationDrawer(),
        body: SafeArea(
          child: Stack(children: [
            Container(
              color: AppColors.Snow,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                EdgeInsetsDirectional.only(start: 15, end: 15, top: 20),
                child: Consumer(builder: (_, ref, __) {
                  var videosViewModel =
                  ref.watch(_categorizedVideosViewModelProvider);
                  var categories = videosViewModel.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (categories != null && categories.isNotEmpty)
                        Container(
                          padding: EdgeInsetsDirectional.only(bottom: 15),
                          child: CustomText(
                            title: "str_videos".tr(),
                            textColor: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: categories?.length ?? 0,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: MenuCategoryWithVideosItem(
                                  category: categories?[index],
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                }),
              ),
            ),
            Consumer(
              builder: (_, watch, __) {
                return ScreenHandler(
                  screenProvider: _categorizedVideosViewModelProvider,
                  noDataMessage: "str_no_data".tr(),
                  onDeviceReconnected: getAllVideos,
                  noDataWidget: NoDataWidget(),
                );
              },
            ),
          ]),
        ));
  }

  @override
  void initState() {
    getAllVideos();
    super.initState();
  }

  Future getAllVideos() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_categorizedVideosViewModelProvider.notifier).getVideos();
    });
  }
}
