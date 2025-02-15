import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
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
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';
import 'package:katkoot_elwady/features/guides_management/view_models/guides_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/view_models/topics_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guide_widget.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/pdf_viewer_widget.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/topic_row_item.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';

class GuidesScreen extends StatefulWidget {
  final ScrollController? scrollController;
  TabController controller;

  GuidesScreen({this.scrollController,required this.controller});

  @override
  _GuidesScreenState createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> with BaseViewModel {
  bool _startInit = false;
  final guidesViewModelProvider =
  StateNotifierProvider<GuidesViewModel, BaseState<List<Guide>?>>((ref) {
    return GuidesViewModel(ref.read(di.repositoryProvider));
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.height * 0.02;
    return Stack(children: [
      GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
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
                  title: 'str_tab_guides_topics'.tr(),
                  textColor: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Expanded(
                  child: Consumer(builder: (_, ref, __) {
                    var guidesviewModel = ref.watch(guidesViewModelProvider);
                    var guides = guidesviewModel.data ?? [];

                    return PaginationList(
                      scrollController: widget.scrollController,
                      itemBuilder: (context, index) {
                        var guide = guides[index];

                        return GuideWidget(
                          guide: guide,
                          onPressed: () {
                            Navigator.of(
                                AppConstants.navigatorKey.currentContext!)
                                .pushNamed(PdfViewer.routeName, arguments: [
                              guide.filePath,
                              guide.printFilePath
                            ]);
                          },
                        );
                      },
                      itemCount: guides.length,
                      hasMore: ProviderScope.containerOf(context,
                          listen: false)
                          .read(guidesViewModelProvider.notifier)
                          .hasNext,
                      loading: ProviderScope.containerOf(context,
                          listen: false).read(guidesViewModelProvider).isLoading,
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
            screenProvider: guidesViewModelProvider,
            noDataMessage: "str_no_data".tr(),
            noDataWidget: NoDataWidget(),
          );
        },
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
    ]);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    Future.delayed(Duration(milliseconds: 0), () {
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
          listen: false).read(guidesViewModelProvider.notifier)
          .getGuides(
          refresh: true,
          showLoading: true,
          searchText: ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false).read(di.searchContentProvider));
    });
  }
}
