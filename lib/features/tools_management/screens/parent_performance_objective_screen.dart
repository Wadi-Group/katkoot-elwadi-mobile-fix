import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_flock_requirement_row.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/slidr_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/custom_slider.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_performance_row.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tool_category_header.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tools_flexiple_app_bar.dart';

class ParentStockPerformanceObjective extends StatefulWidget {
  static const routeName = "./parent_performance_objective";
  final Category category;
  final int? toolId;

  ParentStockPerformanceObjective({required this.category, this.toolId});

  @override
  _ParentStockPerformanceObjectiveState createState() =>
      _ParentStockPerformanceObjectiveState();
}

class _ParentStockPerformanceObjectiveState
    extends State<ParentStockPerformanceObjective> with SliderMixin {
  late final _selectedAgeIndexProvider = Provider.autoDispose<int?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.selectedAgeIndex;
  });

  late final _currentSliderValue = Provider<double?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.currentValue;
  });

  late final _toolDataProvider = Provider.autoDispose<Tool?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.tool;
  });

  var sliderViewModel;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * .018;
    return Scaffold(
      // backgroundColor: Colors.white,

      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight:
              0), // appBar: CustomAppBar(title: widget.category.title ?? ''),

      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.DARK_SPRING_GREEN,
                  floating: true,
                  pinned: true,
                  expandedHeight: 100,
                  centerTitle: false,
                  collapsedHeight: kToolbarHeight,
                  foregroundColor: Colors.white,
                  flexibleSpace: Consumer(builder: (_, ref, __) {
                    var tool = ref.watch(_toolDataProvider);
                    return ToolsFlexibleAppBar(
                      title: tool?.title ?? "",
                      backgroundTitle: widget.category.title ?? '',
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Stack(children: [
                    Consumer(
                      builder: (cx, ref, __) {
                        var tool = ref.watch(_toolDataProvider);
                        if (tool != null) setSliderData(tool);
                        return tool != null
                            ? MediaQuery.removePadding(
                                context: cx,
                                removeTop: true,
                                child: SafeArea(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ToolCategoryHeader(
                                        category: widget.category,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
                                            Consumer(builder: (_, ref, __) {
                                          var selectedAgeIndex =
                                          ref.watch(_selectedAgeIndexProvider);
                                          // print(tool
                                          //     .toolData?[selectedAgeIndex ?? 0]
                                          //     .sections![1]
                                          //     .data);
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: tool
                                                    .toolData?[
                                                        selectedAgeIndex ?? 0]
                                                    .sections
                                                    ?.length ??
                                                1,
                                            itemBuilder: (context, index) =>
                                                ParentPerformanceRow(
                                                    section: tool
                                                        .toolData?[
                                                            selectedAgeIndex ??
                                                                0]
                                                        .sections?[index]),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                    ScreenHandler(
                      screenProvider: di.toolDetailsViewModelProvider,
                      onDeviceReconnected: getToolDetails,
                    )
                  ]),
                ),
              ],
            ),
          ),
          Consumer(builder: (_, ref, __) {
            var tool = ref.watch(_toolDataProvider);
            if (tool == null) return const SizedBox.shrink();
            return CustomSlider(
              onDrag: (value) {
                sliderViewModel.updateSliderWidget(value);
                ProviderScope.containerOf(context,
                    listen: false)
                    .read(di.toolDetailsViewModelProvider.notifier)
                    .getSelectedAgeDataIndex(value);
              },
            );
          }),
        ],
      ),
    );
  }

  Future setSliderData(Tool tool) async {
    await Future.delayed(Duration.zero, () {
      var currentSliderValue = ProviderScope.containerOf(context,
          listen: false).read(_currentSliderValue);
      sliderViewModel = ProviderScope.containerOf(context,
          listen: false).read(di.customSliderViewModelProvider.notifier);

      sliderViewModel.initSlider(SliderItem(
          duration: tool.duration ?? 'str_week'.tr(),
          min: tool.sliderData?.minValue != null
              ? tool.sliderData!.minValue!.toDouble()
              : tool.getSliderMin(),
          max: tool.sliderData?.maxValue != null
              ? tool.sliderData!.maxValue!.toDouble()
              : tool.getSliderMax(),
          current: (currentSliderValue != null)
              ? currentSliderValue
              : (tool.sliderData?.defaultValue != null
                  ? tool.sliderData!.defaultValue!.toDouble()
                  : 32),
          step: tool.sliderData?.step != null
              ? tool.sliderData!.step!.toDouble()
              : 1,
          sliderIcons: getSliderIcons(),
          sliderTrackColors: getSliderTrackColors(),
          handlerBorderColor: AppColors.LA_SALLE_GREEN,
          sliderIntervals: tool.getSliderIntervals()));
    });
  }

  Future getToolDetails() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false)
          .read(di.toolDetailsViewModelProvider.notifier)
          .getDetails(widget.toolId, 32);
    });
  }

  @override
  void initState() {
    getToolDetails();
    super.initState();
  }

  // List<SliderIcon> getSliderIcons() {
  //   List<SliderIcon> list = [
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 0, end: 8),
  //         icon: createSliderIcon("8_weeks_g.png")),
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 9, end: 15),
  //         icon: createSliderIcon("15_weeks_g.png")),
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 16, end: 64),
  //         icon: createSliderIcon("55_weeks_g.png")),
  //   ];
  //   return list;
  // }

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
}
