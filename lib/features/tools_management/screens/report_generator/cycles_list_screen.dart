import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/manage_cycle_screen.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/cycles_list_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/cycle_row_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tools_flexiple_app_bar.dart';

import 'create_new_cycle_screen.dart';

class CyclesScreen extends StatefulWidget {
  static const routeName = "./CyclesScreen";

  final Category category;
  final Tool tool;

  CyclesScreen({required this.category, required this.tool});

  @override
  _CyclesScreenState createState() => _CyclesScreenState();
}

class _CyclesScreenState extends State<CyclesScreen>
    with BaseViewModel, PaginationUtils {
  final _cyclesListViewModelProvider =
      StateNotifierProvider<CyclesListViewModel, BaseState<List<Cycle>?>>(
          (ref) {
    return CyclesListViewModel(ref.read(repositoryProvider));
  });

  @override
  void initState() {
    getListOfCycles(showLoading: true, refresh: true);
    super.initState();
  }

  Future getListOfCycles(
      {bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_cyclesListViewModelProvider.notifier)
          .getCycles(refresh: refresh, showLoading: showLoading);
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0),
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: () {
          hideKeyboard();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.DARK_SPRING_GREEN,
              floating: true,
              pinned: true,
              centerTitle: false,
              expandedHeight: 100,
              collapsedHeight: kToolbarHeight,
              foregroundColor: Colors.white,
              flexibleSpace: ToolsFlexibleAppBar(
                title: "str_manage_cycle".tr(),
                backgroundTitle: widget.category.title ?? '',
              ),
            ),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Consumer(builder: (_, ref, __) {
                                var cycles =
                                    ref.watch(_cyclesListViewModelProvider).data ??
                                        [];
                                return PaginationList(
                                  padding: EdgeInsets.symmetric(
                                      vertical: padding * 2,
                                      horizontal: padding),
                                  onLoadMore: () =>
                                      getListOfCycles(showLoading: false),
                                  onRefresh: () => getListOfCycles(
                                      showLoading: true, refresh: true),
                                  hasMore: ProviderScope.containerOf(context,
                                      listen: false).read(
                                          _cyclesListViewModelProvider.notifier)
                                      .hasNext,
                                  placeholderHeight: 50,
                                  loading: ProviderScope.containerOf(context,
                                      listen: false)
                                      .read(_cyclesListViewModelProvider)
                                      .isLoading,
                                  itemCount: cycles.length,
                                  itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: CycleRowItem(
                                        onDelete: () => ProviderScope.containerOf(context,
                                            listen: false)
                                            .read(_cyclesListViewModelProvider
                                                .notifier)
                                            .deleteCycle(cycles[index].id ?? 0),
                                        cycle: cycles[index],
                                        onViewData: () => ProviderScope.containerOf(context,
                                            listen: false)
                                            .read(_cyclesListViewModelProvider
                                                .notifier)
                                            .navigateToCycleGraph(
                                                cycles[index]),
                                        onTap: (cycle) {
                                          openManageCycleScreenForResult(cycle);
                                        },
                                      )),
                                );
                              }),
                              Consumer(
                                builder: (_, watch, __) {
                                  return ScreenHandler(
                                    screenProvider:
                                        _cyclesListViewModelProvider,
                                    noDataMessage: "str_no_data".tr(),
                                    onDeviceReconnected: () => getListOfCycles(
                                        showLoading: true,
                                        refresh: ProviderScope.containerOf(context,
                                            listen: false).read(
                                                    _cyclesListViewModelProvider)
                                                .data !=
                                            null),
                                    noDataWidget: NoDataWidget(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        buildActionsButtons(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildActionsButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: CustomElevatedButton(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              title: 'str_add_new_cycle'.tr(),
              textColor: AppColors.white,
              backgroundColor: AppColors.Olive_Drab,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              onPressed: () {
                hideKeyboard();
                openCreateScreenForResult();
              }),
        ),
      ]),
    );
  }

  Future openCreateScreenForResult() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateNewCycleScreen(
        category: widget.category,
        tool: widget.tool,
      );
    })).then((value) =>
        {if (value as bool) getListOfCycles(showLoading: true, refresh: true)});

    // Navigator.of(context).pushNamed(CreateNewCycleScreen.routeName, arguments: [
    //   widget.category,
    //   widget.tool
    // ]).then((value) =>
    // {if (value as bool) getListOfCycles(showLoading: true, refresh: true)});
    //
  }

  Future openManageCycleScreenForResult(Cycle cycle) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ManageCycleScreen(
        cycle: cycle,
      );
    })).then((value) {
      if (value != null && value as bool)
        getListOfCycles(showLoading: true, refresh: true);
    });

    // Navigator.of(context)
    //     .pushNamed(ManageCycleScreen.routeName, arguments: cycle)
    //     .then((value) {
    //   if (value != null && value as bool)
    //     getListOfCycles(showLoading: true, refresh: true);
    // });
  }
}
