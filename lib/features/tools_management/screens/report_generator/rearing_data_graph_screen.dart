import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'dart:ui' as ui;
import 'package:katkoot_elwady/features/app_base/widgets/custom_chart_widget.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/rearing_data_graph_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/rearing_data_graph_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/feeding_week_data_table_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/rearing_week_data_table_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_graph_production_tabs_view.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_graph_toggle_view.dart';

class RearingDataGraphScreen extends StatefulWidget {
  static const routeName = "./rearing_data_graph";
  final int? weekNumber;
  final String? cycleName;
  final Cycle? cycle;

  const RearingDataGraphScreen(
      {Key? key,
      required this.weekNumber,
      required this.cycle,
      required this.cycleName})
      : super(key: key);

  @override
  _RearingDataGraphScreenState createState() => _RearingDataGraphScreenState();
}

class _RearingDataGraphScreenState extends State<RearingDataGraphScreen> {
  late final _viewModelProvider = StateNotifierProvider<
      RearingDataGraphViewModel, BaseState<RearingDataGraphState>>((ref) {
    return RearingDataGraphViewModel(widget.cycle);
  });

  late final _rearingTabSelectedProvider = Provider<bool>((ref) {
    return ref.watch(_viewModelProvider).data.rearingTabSelected ?? true;
  });

  late ScrollController _chartScrollController = ScrollController();

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  getChartData() {
    Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(_viewModelProvider.notifier)
          .getRearingChartData();
      ProviderScope.containerOf(context, listen: false)
          .read(_viewModelProvider.notifier)
          .getFeedingChartData();

      double offset = ProviderScope.containerOf(context, listen: false)
          .read(_viewModelProvider.notifier)
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
                CustomText(
                  title: widget.cycleName.toString(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.DARK_SPRING_GREEN,
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  title: 'str_week'.tr() + ' ' + widget.weekNumber.toString(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.DARK_SPRING_GREEN,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                ),
                Consumer(builder: (_, ref, __) {
                  var rearingTabIsSelected =
                      ref.watch(_rearingTabSelectedProvider);
                  var rearingChartData =
                      ref.watch(_viewModelProvider).data.rearingChartValues;
                  var feedingChartData =
                      ref.watch(_viewModelProvider).data.feedingChartValues;
                  PreviewData? weekPreviewData = widget.weekNumber != null
                      ? (widget.cycle?.weeksList?[widget.weekNumber! - 1].value
                          ?.previewData)
                      : null;

                  return rearingChartData != null &&
                          feedingChartData != null &&
                          weekPreviewData != null
                      ? Column(
                          children: [
                            if (rearingTabIsSelected)
                              WeekGraphProductionTabsView(
                                  onCh1TabTap: () => ProviderScope.containerOf(
                                          context,
                                          listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(1),
                                  onCh2TabTap: () => ProviderScope.containerOf(
                                          context,
                                          listen: false)
                                      .read(_viewModelProvider.notifier)
                                      .changeSelectedChart(2)),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: CustomLineChart(
                                scrollController: _chartScrollController,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                chartSize:
                                    MediaQuery.of(context).size.height * 0.25,
                                currentSelectedIndex: widget.weekNumber! - 1,
                                chartsValues: rearingTabIsSelected
                                    ? ProviderScope.containerOf(context,
                                            listen: false)
                                        .read(_viewModelProvider.notifier)
                                        .getSelectedChartData()
                                    : feedingChartData,
                                minX: AppConstants.REARING_MIN_VALUE.toDouble(),
                                maxX: AppConstants.REARING_MAX_VALUE.toDouble(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            rearingTabIsSelected
                                ? RearingWeekDataTableView(
                                    weekPreviewData: weekPreviewData)
                                : FeedingWeekDataTableView(
                                    weekPreviewData: weekPreviewData)
                          ],
                        )
                      : Container();
                }),
                WeekGraphsToggleView(
                  firstTabTitle: 'rearing'.tr(),
                  secondTabTitle: 'feeding'.tr(),
                  onFirstTabTap: () =>
                      ProviderScope.containerOf(context, listen: false)
                          .read(_viewModelProvider.notifier)
                          .selectRearingTab(),
                  onSecondTabTap: () =>
                      ProviderScope.containerOf(context, listen: false)
                          .read(_viewModelProvider.notifier)
                          .selectFeedingTab(),
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }

  _animateScrollViewWithSlider() {
    double offset = ProviderScope.containerOf(context, listen: false)
        .read(_viewModelProvider.notifier)
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
