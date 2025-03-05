import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tool_row_item.dart';

class ToolsScreen extends StatefulWidget {
  static const routeName = "./guide_tools";
  final Category category;
  final bool searchScreen;

  const ToolsScreen({required this.category, this.searchScreen = false});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            child: Column(
              children: [
                if (widget.category.title != null)
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      children: [
                        CustomText(
                          title: widget.category.title ?? "",
                          fontSize: 18,
                          maxLines: 3,
                          textColor: AppColors.Dark_spring_green,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomText(
                          title: widget.category.subTitle ?? "",
                          fontSize: 13,
                          fontFamily: 'Arial',
                          maxLines: 3,
                          textColor: AppColors.Liver,
                        ),
                      ],
                    ),
                  ),
                Container(
                  height: 2,
                  color: Colors.grey[200],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Consumer(builder: (_, ref, __) {
                      var toolsViewModel = ref.watch(di.toolsViewModelProvider);
                      var tools = toolsViewModel.data;
                      print(tools);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: tools != null ? tools.length : 0,
                          itemBuilder: (context, index) => Center(
                            child: Container(
                                margin: EdgeInsetsDirectional.only(bottom: 18),
                                child: ToolRowItem(
                                  hasTitle: widget.searchScreen,
                                  isElite: (tools![index].type ==
                                          ToolTypes.PS_RG ||
                                      tools[index].type == ToolTypes.CB_PO ||
                                      tools[index].type == ToolTypes.CB_RG),
                                  tool: tools[index],
                                  onTap: () => ProviderScope.containerOf(
                                          context,
                                          listen: false)
                                      .read(di.toolsViewModelProvider.notifier)
                                      .openToolDetails(
                                          context,
                                          tools[index],
                                          tools[index].category ??
                                              widget.category,
                                          tools[index].id!),
                                )),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
        Consumer(
          builder: (_, watch, __) {
            return ScreenHandler(
              screenProvider: di.toolsViewModelProvider,
              noDataMessage: "str_no_data".tr(),
              onDeviceReconnected: getTools,
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
      ],
    );
  }

  @override
  void initState() {
    getTools();

    super.initState();
  }

  Future getTools() async {
    await Future.delayed(Duration.zero, () {
      print("call getTools");
      if (!widget.searchScreen) {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
                listen: false)
            .read(di.toolsViewModelProvider.notifier)
            .getTools(widget.category.id!);
      } else if (widget.searchScreen &&
          ProviderScope.containerOf(context, listen: false)
              .read(di.searchContentProvider.state)
              .state
              .trim()
              .isNotEmpty) {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
                listen: false)
            .read(di.toolsViewModelProvider.notifier)
            .getTools(0,
                searchText: ProviderScope.containerOf(context, listen: false)
                    .read(di.searchContentProvider.state)
                    .state);
      }
    });
  }
}
