import 'package:flutter/material.dart';
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
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';
import 'package:katkoot_elwady/features/guides_management/view_models/faqs_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/faq_row_item.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';

class FaqsScreen extends StatefulWidget {
  static const routeName = "./guide_faqs";
  final Category category;
  final ScrollController? scrollController;
  final bool searchScreen;

  const FaqsScreen(
      {required this.category,
      this.scrollController,
      this.searchScreen = false});

  @override
  _FaqsScreenState createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  int? expandedIndex;

  final faqsViewModelProvider =
      StateNotifierProvider<FaqsViewModel, BaseState<List<Faq>?>>((ref) {
    return FaqsViewModel(ref.read(di.repositoryProvider));
  });
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
        body: SafeArea(
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
              padding: EdgeInsetsDirectional.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: padding / 2,
                  ),
                  CustomText(
                    title: "${widget.category.title ?? ""} " + "str_faqs".tr(),
                    textColor: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(
                    child: Consumer(builder: (_, ref, __) {
                      var faqsViewModel = ref.watch(faqsViewModelProvider);
                      var faqs = faqsViewModel.data ?? [];

                      return PaginationList(
                        scrollController: widget.scrollController,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          var faq = faqs[index];

                          return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: padding),
                              child: FaqRowItem(
                                hasTitle: widget.searchScreen,
                                toggleExpand: (status) {
                                  setExpanded(status, index);
                                },
                                faq: faq,
                                expanded: index == expandedIndex,
                              ),
                            ),
                          );
                        },
                        itemCount: faqs.length,
                        hasMore: ProviderScope.containerOf(context,
                            listen: false)
                            .read(faqsViewModelProvider.notifier)
                            .hasNext,
                        onLoadMore: () => getFaqs(showLoading: false),
                        onRefresh: () =>
                            getFaqs(showLoading: true, refresh: true),
                        loading: ProviderScope.containerOf(context,
                            listen: false).read(faqsViewModelProvider).isLoading,
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
              screenProvider: faqsViewModelProvider,
              noDataMessage: "str_no_data".tr(),
              onDeviceReconnected: () => getFaqs(
                  showLoading: true,
                  refresh: ProviderScope.containerOf(context,
                      listen: false).read(faqsViewModelProvider).data != null),
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
    ));
  }

  @override
  void initState() {
    getFaqs(showLoading: true, refresh: true);
    super.initState();
  }

  Future getFaqs({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");

      if (!widget.searchScreen) {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
            listen: false).read(faqsViewModelProvider.notifier)
            .getFaqs(widget.category.id!,
                refresh: refresh, showLoading: showLoading);
      } else {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
            listen: false).read(faqsViewModelProvider.notifier)
            .getFaqs(0,
                refresh: refresh,
                showLoading: showLoading,
                searchText: ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
                    listen: false).read(di.searchContentProvider));
      }
    });
  }

  setExpanded(bool exapnded, int index) {
    print(exapnded);
    setState(() {
      expandedIndex = exapnded ? index : null;
    });
  }
}
