import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/menu_categorized_videos_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/menu_category_with_videos_item.dart';
import '../../app_base/widgets/custom_text.dart';
import '../../guides_management/models/video.dart';
import '../sections/carousel_slider_videos_section.dart';

// Provider using the new CategorizedVideosState model
final _categorizedVideosViewModelProvider = StateNotifierProvider<
    MenuCategorizedVideosViewModel, BaseState<CategorizedVideosState>>((ref) {
  return MenuCategorizedVideosViewModel(ref.read(di.repositoryProvider));
});

class MenuCategorizedVideosScreen extends StatefulWidget {
  static const routeName = "./menu_categorized_videos_screen";

  @override
  _MenuCategorizedVideosScreenState createState() =>
      _MenuCategorizedVideosScreenState();
}

class _MenuCategorizedVideosScreenState
    extends State<MenuCategorizedVideosScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showNotificationsButton: true,
        showDrawer: true,
        hasbackButton: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppColors.LIGHT_BACKGROUND,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Consumer(
                builder: (_, ref, __) {
                  var state = ref.watch(_categorizedVideosViewModelProvider);
                  var categorizedVideosState = state.data;

                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (categorizedVideosState.hasNoData) {
                    return Center(child: NoDataWidget());
                  }

                  List<Category> categories =
                      categorizedVideosState.categories ?? [];
                  List<Video> latestVideos =
                      categorizedVideosState.videos ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        CustomText(
                          title: 'videos'.tr(),
                          fontSize: 22,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.APP_BLUE,
                        ),

                        // Display Categories with Videos
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            padding: EdgeInsetsDirectional.only(
                                start: 20, end: 20, top: 15),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: MenuCategoryWithVideosItem(
                                category: categories[index],
                              ),
                            ),
                          ),
                        ),

                        // Latest Videos Section
                        if (latestVideos.isNotEmpty) ...[
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: CustomText(
                                title: 'latest_videos'.tr(),
                                fontSize: 22,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.APP_BLUE,
                              ),
                            ),
                          ),
                          CarouselSliderVideosSection(videos: latestVideos),
                        ],

                        SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),
            Consumer(
              builder: (_, ref, __) {
                return ScreenHandler(
                  screenProvider: _categorizedVideosViewModelProvider,
                  noDataMessage: "str_no_data".tr(),
                  onDeviceReconnected: getAllVideos,
                  noDataWidget: NoDataWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getAllVideos();
    super.initState();
  }

  Future getAllVideos() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(_categorizedVideosViewModelProvider.notifier)
          .getVideos();
    });
  }
}
