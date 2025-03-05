import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';
import 'package:katkoot_elwady/features/guides_management/view_models/topics_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/pdf_viewer_widget.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/topic_row_item.dart';

class TopicsScreen extends StatefulWidget {
  static const routeName = "./guide_topics";
  final Category category;
  final ScrollController? scrollController;

  const TopicsScreen({required this.category, this.scrollController});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> with BaseViewModel {
  final topicsViewModelProvider =
      StateNotifierProvider<TopicsViewModel, BaseState<List<Topic>?>>((ref) {
    return TopicsViewModel(ref.read(di.repositoryProvider));
  });

  bool _startInit = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.height * 0.02;
    return Stack(children: [
      Container(
        color: AppColors.Snow,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsetsDirectional.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: padding / 2,
              ),
              CustomText(
                title: "${widget.category.title ?? ""} " +
                    'str_tab_guides_topics'.tr(),
                textColor: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: Consumer(builder: (_, ref, __) {
                  var topicsViewModel = ref.watch(topicsViewModelProvider);
                  var topics = topicsViewModel.data ?? [];

                  return PaginationList(
                    scrollController: widget.scrollController,
                    itemBuilder: (context, index) {
                      var topic = topics[index];

                      return Center(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(top: padding),
                          child: Center(
                            child: Padding(
                                padding:
                                    EdgeInsetsDirectional.only(top: padding),
                                child: TopicRowItem(
                                    topic: topic,
                                    previewPdf: (previewUrl, printUrl) {
                                      Navigator.of(AppConstants
                                              .navigatorKey.currentContext!)
                                          .pushNamed(PdfViewer.routeName,
                                              arguments: [
                                            previewUrl,
                                            printUrl
                                          ]);
                                    })),
                          ),
                        ),
                      );
                    },
                    itemCount: topics.length,
                    onLoadMore: () => getTopics(showLoading: false),
                    onRefresh: () =>
                        getTopics(showLoading: true, refresh: true),
                    hasMore: ProviderScope.containerOf(context, listen: false)
                        .read(topicsViewModelProvider.notifier)
                        .hasNext,
                    loading: ProviderScope.containerOf(context, listen: false)
                        .read(topicsViewModelProvider)
                        .isLoading,
                  );
                }),
              ),
            ],
          ),
        ),
        // child:
      ),
      Consumer(
        builder: (_, watch, __) {
          return ScreenHandler(
            screenProvider: topicsViewModelProvider,
            noDataMessage: "str_no_data".tr(),
            onDeviceReconnected: () => getTopics(
                showLoading: true,
                refresh: ProviderScope.containerOf(context, listen: false)
                        .read(topicsViewModelProvider)
                        .data !=
                    null),
            noDataWidget: NoDataWidget(),
          );
        },
      ),
    ]);
  }

  @override
  void initState() {
    getTopics(showLoading: true, refresh: true);
    super.initState();
  }

  Future getTopics({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(topicsViewModelProvider.notifier)
          .getTopics(widget.category.id!,
              refresh: refresh, showLoading: showLoading);
    });
  }
}
