import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';
import 'package:katkoot_elwady/features/guides_management/view_models/videos_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/video_row_item.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';
import 'video_player_youtube_iframe_screen.dart';

class CategoryVideosScreen extends StatefulWidget {
  static const routeName = "./guide_videos";
  final Category category;
  final ScrollController? scrollController;
  final bool searchScreen;

  const CategoryVideosScreen(
      {required this.category,
      this.scrollController,
      this.searchScreen = false});

  @override
  _CategoryVideosScreenState createState() => _CategoryVideosScreenState();
}

class _CategoryVideosScreenState extends State<CategoryVideosScreen> {
  bool _startInit = false;

  final videosViewModelProvider =
      StateNotifierProvider<VideosViewModel, BaseState<List<Video>?>>((ref) {
    return VideosViewModel(ref.read(di.repositoryProvider));
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.height * 0.02;

    return SafeArea(
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: AppColors.Snow,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  top: padding, start: padding, end: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: padding / 2,
                  ),
                  CustomText(
                    title:
                        "${widget.category.title ?? ""} " + "str_videos".tr(),
                    textColor: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(
                    child: Consumer(builder: (_, ref, __) {
                      var videosViewModel = ref.watch(videosViewModelProvider);
                      var videos = videosViewModel.data ?? [];

                      return PaginationList(
                        scrollController: widget.scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemBuilder: (context, index) {
                          var video = videos[index];

                          return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: padding),
                              child: VideoRowItem(
                                hasTitle: widget.searchScreen,
                                video: video,
                                onTap: (video) {
                                  Navigator.of(
                                      AppConstants.navigatorKey.currentContext!)
                                    ..pushNamed(
                                        VideoPlayerYouTubeIframeScreen
                                            .routeName,
                                        arguments: video.url);
                                },
                              ),
                            ),
                          );
                        },
                        itemCount: videos.length,
                        onLoadMore: () => getVideos(showLoading: false),
                        onRefresh: () =>
                            getVideos(showLoading: true, refresh: true),
                        hasMore: ProviderScope.containerOf(context,
                            listen: false)
                            .read(videosViewModelProvider.notifier)
                            .hasNext,
                        loading:
                        ProviderScope.containerOf(context,
                            listen: false).read(videosViewModelProvider).isLoading,
                      );
                    }),
                  ),
                ],
              ),
            ),
            // child:
          ),
        ),
        Consumer(
          builder: (_, watch, __) {
            return ScreenHandler(
              screenProvider: videosViewModelProvider,
              noDataMessage: "str_no_data".tr(),
              onDeviceReconnected: () => getVideos(
                  showLoading: true,
                  refresh: ProviderScope.containerOf(context,
                      listen: false).read(videosViewModelProvider).data != null),
              noDataWidget: NoDataWidget(),
            );
          },
        ),
        Consumer(
          builder: (_, ref, __) {
            var searchText = ref.watch(di.searchContentProvider);
            var isEmpty = searchText.trim().isEmpty;
            if (isEmpty && widget.searchScreen) {
              return SearchPlaceHolder();
            } else {
              return Container();
            }
          },
        ),
      ]),
    );
  }

  @override
  void initState() {
    getVideos(showLoading: true, refresh: true);
    super.initState();
  }

  Future getVideos({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      if (!widget.searchScreen) {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
            listen: false).read(videosViewModelProvider.notifier)
            .getVideos(widget.category.id!,
                refresh: refresh, showLoading: showLoading);
      } else {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
            listen: false).read(videosViewModelProvider.notifier)
            .getVideos(0,
                refresh: refresh,
                showLoading: showLoading,
                searchText: ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
                    listen: false).read(di.searchContentProvider));
      }
    });
  }

  Future resetOrientation() async {
    await Future.delayed(const Duration(milliseconds: 0), () async {
      Orientation currentOrientation = MediaQuery.of(context).orientation;
      if (currentOrientation == Orientation.landscape) {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
    });
  }
}
