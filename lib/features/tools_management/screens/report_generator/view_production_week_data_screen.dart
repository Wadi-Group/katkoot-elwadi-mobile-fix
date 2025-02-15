import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/flexible_tabbar_delegate.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/tools_management/entities/view_production_week_data_state.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/slidr_mixin.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/production_data_graph_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/production_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_poriduction_data_results_screen.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/view_production_week_data_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/custom_slider.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/custom_toggle.dart';

class ViewProductionWeekDataScreenData {
  final String? cycleId;
  final int? weekNumber;
  final String? cycleName;

  ViewProductionWeekDataScreenData(
      {required this.cycleId,
      required this.weekNumber,
      required this.cycleName});
}

class ViewProductionWeekDataScreen extends StatefulWidget {
  static const routeName = "./view_production_week_data";
  final String? cycleId;
  final String? cycleName;
  final int? weekNumber;

  const ViewProductionWeekDataScreen(
      {Key? key,
      required this.cycleId,
      required this.cycleName,
      required this.weekNumber})
      : super(key: key);

  @override
  _ViewProductionWeekDataScreenState createState() =>
      _ViewProductionWeekDataScreenState();
}

class _ViewProductionWeekDataScreenState
    extends State<ViewProductionWeekDataScreen>
    with TickerProviderStateMixin, SliderMixin {
  var sliderViewModel;

  late final _selectedWeekNumberProvider = Provider<int?>((ref) {
    return ref.watch(_viewModelProvider).data?.selectedWeekNumber;
  });

  late final _cycleDetailsProvider = Provider<Cycle?>((ref) {
    return ref.watch(_viewModelProvider).data?.cycle;
  });

  late final _viewModelProvider = StateNotifierProvider<
      ViewProductionWeekDataViewModel,
      BaseState<ViewProductionWeekDataState?>>((ref) {
    return ViewProductionWeekDataViewModel(ref.read(di.repositoryProvider));
  });

  late TabController _tabController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    getCycleData();

    super.initState();
  }

  Future getCycleData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_viewModelProvider.notifier)
          .getCycleData(widget.cycleId, widget.weekNumber!);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                backgroundColor: AppColors.DARK_SPRING_GREEN,
                collapsedHeight: kToolbarHeight,
                foregroundColor: Colors.white,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [StretchMode.fadeTitle],
                    background: CustomAppBar(
                        onBackClick: () => Navigator.of(context).pop(),
                        title: 'production_data'.tr(),
                        onToggle: () {
                          ProviderScope.containerOf(context,
                              listen: false)
                              .read(_viewModelProvider.notifier)
                              .toggleFunction();
                        },
                        intialCase: ToggleCases.PRODUCTION,
                        showToggle: true,
                        controller: _tabController))),
            SliverPersistentHeader(
              delegate: FlexibleTapBarDelegate(
                  body: CustomAppBar(
                      onBackClick: () => Navigator.of(context).pop(),
                      title: '',
                      tabs: [
                        TabbarData(
                          key: "details",
                          inActiveWidget: CustomText(
                            title: "details".tr(),
                            textColor: AppColors.Liver,
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                          ),
                          activeWidget: Icon(
                            KatkootELWadyIcons.add_data,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        TabbarData(
                          key: "infograph",
                          inActiveWidget: CustomText(
                            title: "infograph".tr(),
                            textColor: AppColors.Liver,
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                          ),
                          activeWidget: Icon(
                            KatkootELWadyIcons.infograph,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        TabbarData(
                          key: "results".tr(),
                          inActiveWidget: CustomText(
                            title: "results".tr(),
                            textColor: AppColors.Liver,
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                          ),
                          activeWidget: Icon(
                            KatkootELWadyIcons.results,
                            color: Colors.white,
                            size: 16,
                          ),
                        )
                      ],
                      controller: _tabController),
                  preferredSize: kToolbarHeight),
              pinned: true,
            )
          ];
        },
        body: Stack(
          children: [
            Consumer(builder: (_, ref, __) {
              var cycleDetails = ref.watch(_cycleDetailsProvider);
              if (cycleDetails != null) setSliderData();
              return cycleDetails != null
                  ? Column(
                      children: [
                        Consumer(builder: (_, ref, __) {
                          var selectedWeekNumber =
                          ref.watch(_selectedWeekNumberProvider);
                          return Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                ProductionDataScreen(
                                    weekNumber:
                                        selectedWeekNumber ?? widget.weekNumber,
                                    weekData: cycleDetails
                                        .getWeekData(selectedWeekNumber!),
                                    cycleName: widget.cycleName,
                                    hasData: cycleDetails
                                        .weekIsExists(selectedWeekNumber)),
                                ProductionDataGraphScreen(
                                    cycleName: widget.cycleName,
                                    weekNumber: selectedWeekNumber,
                                    cycle: ProviderScope.containerOf(context,
                                        listen: false)
                                        .read(_viewModelProvider)
                                        .data
                                        ?.cycle),
                                ProductionDataResultsScreen(
                                    weekNumber: selectedWeekNumber,
                                    cycleName: widget.cycleName,
                                    weekData: cycleDetails
                                        .getWeekData(selectedWeekNumber),
                                    hasData: cycleDetails
                                        .weekIsExists(selectedWeekNumber)),
                              ],
                            ),
                          );
                        }),
                        Consumer(builder: (_, ref, __) {
                          var cycle = ref.watch(_cycleDetailsProvider);
                          if (cycle == null)
                            return const SizedBox.shrink();
                          // return Container(color: Colors.red,);
                          else
                            return CustomSlider(
                              isNumeric: false,
                              onDrag: (value) {
                                sliderViewModel.updateSliderWidget(value);
                                ProviderScope.containerOf(context,
                                    listen: false)
                                    .read(_viewModelProvider.notifier)
                                    .getSelectedAgeDataIndex(value);
                              },
                            );
                        })
                      ],
                    )
                  : Container();
            }),
            ScreenHandler(
              screenProvider: _viewModelProvider,
              onDeviceReconnected: getCycleData,
            )
          ],
        ),
      ),
    );
  }

  List<SliderIcon> getSliderIcons() {
    List<SliderIcon> list = [
      SliderIcon(
          sliderInterval: SliderInterval(start: 0, end: 4),
          icon: createSliderIcon("8_weeks_g.png", AppColors.TANGERIEN)),
      SliderIcon(
          sliderInterval: SliderInterval(start: 5, end: 20),
          icon: createSliderIcon("15_weeks_g.png", AppColors.LA_SALLE_GREEN)),
      SliderIcon(
          sliderInterval: SliderInterval(start: 21, end: 64),
          icon: createSliderIcon("32_days.png", AppColors.LA_SALLE_GREEN)),
    ];
    return list;
  }

  List<SliderTrackColor> getSliderTrackColors() {
    List<SliderTrackColor> list = [
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 0, end: 4),
          color: AppColors.TANGERIEN),
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 5, end: 20),
          color: AppColors.LA_SALLE_GREEN),
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 21, end: 64),
          color: AppColors.LA_SALLE_GREEN),
    ];
    return list;
  }

  Future setSliderData() async {
    await Future.delayed(Duration.zero, () {
      var currentSliderValue = ProviderScope.containerOf(context,
          listen: false).read(_selectedWeekNumberProvider);
      sliderViewModel = ProviderScope.containerOf(context,
          listen: false).read(di.customSliderViewModelProvider.notifier);
      sliderViewModel.initSlider(SliderItem(
        sliderIcons: getSliderIcons(),
        sliderTrackColors: getSliderTrackColors(),
        sliderIntervals: [
          SliderInterval(
              start: AppConstants.REARING_MIN_VALUE,
              end: AppConstants.REARING_MAX_VALUE)
        ],
        step: 1,
        duration: "Weeks".tr(),
        min: AppConstants.PRODUCTION_MIN_VALUE.toDouble(),
        max: AppConstants.PRODUCTION_MAX_VALUE.toDouble(),
        current: (currentSliderValue != null)
            ? currentSliderValue.toDouble()
            : (widget.weekNumber!.toDouble()),
      ));
    });
  }
}
