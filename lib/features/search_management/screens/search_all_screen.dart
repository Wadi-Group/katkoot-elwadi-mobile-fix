import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/screens/video_player_youtube_iframe_screen.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/faq_row_item.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guide_widget.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/pdf_viewer_widget.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/video_row_item.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/where_to_find_us_supplier_item.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:katkoot_elwady/features/search_management/widgets/searct_title_widget.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tool_row_item.dart';

import '../../../../core/di/injection_container.dart' as di;

class SearchAllScreen extends StatefulWidget {
  TabController controller;
  SearchModel? searchData;

  SearchAllScreen({required this.controller, required this.searchData});

  @override
  _SearchAllScreenState createState() => _SearchAllScreenState();
}

class _SearchAllScreenState extends State<SearchAllScreen> {
  int? expandedIndex;

  setExpanded(bool exapnded, int index) {
    print(exapnded);
    setState(() {
      expandedIndex = exapnded ? index : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: widget.searchData != null
          ? ListView(
              children: [
                if (widget.searchData?.guidesData?.guides != null &&
                    widget.searchData!.guidesData!.guides!.isNotEmpty)
                  Column(children: [
                    SearchTitleWidget(
                        showViewAll:
                            widget.searchData?.guidesData?.hasMore ?? false,
                        title: "str_tab_guides".tr(),
                        ontap: () {
                          widget.controller.animateTo(1);
                        }),
                    ...widget.searchData!.guidesData!.guides!
                        .map((guide) => Container(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                              child: GuideWidget(
                                guide: guide,
                                onPressed: () {
                                  print(guide.filePath);
                                  print(guide.printFilePath);
                                  Navigator.of(AppConstants
                                          .navigatorKey.currentContext!)
                                      .pushNamed(PdfViewer.routeName,
                                          arguments: [
                                        guide.filePath,
                                        guide.printFilePath
                                      ]);
                                },
                              ),
                            ))
                        .toList(),
                  ]),
                if (widget.searchData?.faqsData?.faqs != null &&
                    widget.searchData!.faqsData!.faqs!.isNotEmpty)
                  Column(children: [
                    SearchTitleWidget(
                        showViewAll:
                            widget.searchData?.faqsData?.hasMore ?? false,
                        title: "str_tab_guides_faqs".tr(),
                        ontap: () {
                          widget.controller
                              .animateTo(widget.searchData?.faqIndex ?? 0);
                        }),
                    ...widget.searchData!.faqsData!.faqs!
                        .mapIndexed((i, e) => Container(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                            child: FaqRowItem(
                              hasTitle: true,
                              faq: e,
                              toggleExpand: (status) {
                                setExpanded(status, i);
                              },
                              expanded: i == expandedIndex,
                            )))
                        .toList(),
                  ]),
                if (widget.searchData?.videosData?.videos != null &&
                    widget.searchData!.videosData!.videos!.isNotEmpty)
                  Column(children: [
                    SearchTitleWidget(
                        showViewAll:
                            widget.searchData?.videosData?.hasMore ?? false,
                        title: "str_tab_guides_videos".tr(),
                        ontap: () {
                          widget.controller
                              .animateTo(widget.searchData?.videosIndex ?? 0);
                        }),
                    ...widget.searchData!.videosData!.videos!
                        .map((e) => Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                              child: VideoRowItem(
                                  video: e,
                                  hasTitle: true,
                                  onTap: (e) {
                                    Navigator.of(AppConstants
                                        .navigatorKey.currentContext!)
                                      ..pushNamed(
                                          VideoPlayerYouTubeIframeScreen
                                              .routeName,
                                          arguments: e.url);
                                  }),
                            ))
                        .toList(),
                  ]),
                if (widget.searchData?.toolsData?.tools != null &&
                    widget.searchData!.toolsData!.tools!.isNotEmpty)
                  Column(
                    children: [
                      SearchTitleWidget(
                          showViewAll:
                              widget.searchData?.toolsData?.hasMore ?? false,
                          title: "str_tab_tool".tr(),
                          ontap: () {
                            widget.controller
                                .animateTo(widget.searchData?.toolsIndex ?? 0);
                          }),
                      ...widget.searchData!.toolsData!.tools!
                          .map((e) => Container(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                              child: ToolRowItem(
                                hasTitle: true,
                                tool: e,
                                isElite: (e.type == ToolTypes.PS_RG ||
                                    e.type == ToolTypes.CB_PO),
                                onTap: () => ProviderScope.containerOf(context,
                                        listen: false)
                                    .read(di.toolsViewModelProvider.notifier)
                                    .openToolDetails(
                                        context,
                                        e,
                                        Category(title: e.parentCategoryTitle),
                                        e.id!),
                              )))
                          .toList()
                    ],
                  ),
                if (widget.searchData?.suppliersData?.suppliers != null &&
                    widget.searchData!.suppliersData!.suppliers!.isNotEmpty)
                  Column(children: [
                    SearchTitleWidget(
                        showViewAll:
                            widget.searchData?.suppliersData?.hasMore ?? false,
                        title: "str_wadi_team".tr(),
                        ontap: () {
                          widget.controller.animateTo(
                              widget.searchData?.suppliersIndex ?? 0);
                        }),
                    ...widget.searchData!.suppliersData!.suppliers!
                        .map((e) => WhereToFindUsSupplierItem(supplier: e))
                        .toList(),
                  ]),
              ],
            )
          : Container(),
    );
  }
}
