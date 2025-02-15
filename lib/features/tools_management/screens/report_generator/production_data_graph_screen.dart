import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_chart_widget.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/production_data_graph_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/production_data_graph_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/production_week_data_table_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_graph_performance_tabs_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_graph_production_tabs_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_graph_toggle_view.dart';

class ProductionDataGraphScreen extends StatefulWidget {
  static const routeName = "./production_data_graph";
  final int? weekNumber;
  final String? cycleName;
  final Cycle? cycle;

  const ProductionDataGraphScreen(
      {Key? key,
      required this.weekNumber,
      required this.cycleName,
      required this.cycle})
      : super(key: key);

  @override
  _ProductionDataGraphScreenState createState() =>
      _ProductionDataGraphScreenState();
}

class _ProductionDataGraphScreenState extends State<ProductionDataGraphScreen> {
  late final _viewModelProvider = StateNotifierProvider<
      ProductionDataGraphViewModel, BaseState<ProductionDataGraphState>>((ref) {
    return ProductionDataGraphViewModel(widget.cycle);
  });

  late final _productionTabSelectedProvider = Provider<bool>((ref) {
    return ref.watch(_viewModelProvider).data.productionTabSelected ?? true;
  });

  late ScrollController _chartScrollController = ScrollController();

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  getChartData() {
    Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_viewModelProvider.notifier).getProductionChartData();
      ProviderScope.containerOf(context,
          listen: false).read(_viewModelProvider.notifier).getPerformanceChartsData();

      double offset = ProviderScope.containerOf(context,
          listen: false).read(_viewModelProvider.notifier)
          .getChartScrollViewOffSet(
              context, widget.weekNumber!, _chartScrollController);
      _chartScrollController = ScrollController(initialScrollOffset: offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    _animateScrollViewWithSlider();

    return Container(
      color: AppColors.Snow,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: CustomText(
                    title: "${widget.cycleName}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.Dark_spring_green,
                  ),
                ),
                CustomText(
                  title: 'str_week'.tr() + ' ' + widget.weekNumber.toString(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.DARK_SPRING_GREEN,
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                ),
                Consumer(builder: (_, ref, __) {
                  var productionTabIsSelected =
                  ref.watch(_productionTabSelectedProvider);

                  var productionChartData =
                      ref.watch(_viewModelProvider).data.productionChartValues;
                  var eggMassChartData =
                      ref.watch(_viewModelProvider).data.eggMassChartValues;
                  var totalEggPerHatchedHenChartData = ref.watch(_viewModelProvider)
                      .data
                      .totalEggPerHatchedHenChartValues;
                  var hatchedEggPerHatchedHenChartData =
                      ref.watch(_viewModelProvider)
                          .data
                          .hatchedEggPerHatchedHenChartValues;
                  var cumulativeUtilizeChartData = ref.watch(_viewModelProvider)
                      .data
                      .cumulativeUtilizeChartValues;

                  PreviewData? weekPreviewData = widget.weekNumber != null
                      ? (widget.cycle?.weeksList?[widget.weekNumber! - 1].value
                          ?.previewData)
                      : null;

                  return productionChartData != null &&
                          eggMassChartData != null &&
                          totalEggPerHatchedHenChartData != null &&
                          hatchedEggPerHatchedHenChartData != null &&
                          cumulativeUtilizeChartData != null &&
                          weekPreviewData != null
                      ? Column(
                          children: [
                            if (!productionTabIsSelected)
                              WeekGraphPerformanceTabsView(
                                  onCh1TabTap: () => ProviderScope.containerOf(context,
                                      listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(1),
                                  onCh2TabTap: () => ProviderScope.containerOf(context,
                                      listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(2),
                                  onCh3TabTap: () => ProviderScope.containerOf(context,
                                      listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(3),
                                  onCh4TabTap: () => ProviderScope.containerOf(context,
                                      listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(4)),
                            if (productionTabIsSelected)
                              WeekGraphProductionTabsView(
                                onCh1TabTap: () => ProviderScope.containerOf(context,
                                    listen: false)
                                    .read(_viewModelProvider.notifier)
                                    .changeSelectedProductionChart(1),
                                onCh2TabTap: () => ProviderScope.containerOf(context,
                                    listen: false)
                                    .read(_viewModelProvider.notifier)
                                    .changeSelectedProductionChart(2),
                              ),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: CustomLineChart(
                                scrollController: _chartScrollController,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                chartSize: MediaQuery.of(context).size.height *
                                    (productionTabIsSelected ? 0.25 : 0.35),
                                currentSelectedIndex: (widget.weekNumber! -
                                        AppConstants.REARING_MAX_VALUE) -
                                    1,
                                chartsValues: ProviderScope.containerOf(context,
                                    listen: false)
                                    .read(_viewModelProvider.notifier)
                                    .getSelectedChartData(),
                                minX:
                                    AppConstants.PRODUCTION_MIN_VALUE.toDouble(),
                                maxX:
                                    AppConstants.PRODUCTION_MAX_VALUE.toDouble(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (productionTabIsSelected)
                              ProductionWeekDataTableView(
                                  weekPreviewData: weekPreviewData)
                          ],
                        )
                      : Container();
                }),
                WeekGraphsToggleView(
                  firstTabTitle: 'production'.tr(),
                  secondTabTitle: 'performance'.tr(),
                  onFirstTabTap: () => ProviderScope.containerOf(context,
                      listen: false)
                      .read(_viewModelProvider.notifier)
                      .selectProductionTab(),
                  onSecondTabTap: () => ProviderScope.containerOf(context,
                      listen: false)
                      .read(_viewModelProvider.notifier)
                      .selectPerformanceTab(),
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }

  _animateScrollViewWithSlider() {
    double offset = ProviderScope.containerOf(context,
        listen: false).read(_viewModelProvider.notifier)
        .getChartScrollViewOffSet(
            context, widget.weekNumber!, _chartScrollController);

    _chartScrollController
      ..animateTo(
        offset,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
  }
}
