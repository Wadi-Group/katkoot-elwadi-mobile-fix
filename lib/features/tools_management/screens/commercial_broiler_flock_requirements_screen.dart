import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/slidr_mixin.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/custom_slider_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/commercial_broiler_flock_data_list.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/custom_slider.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tool_category_header.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tools_flexiple_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class CommercialBroilerFlockRequirementsScreenData {
  final Category category;
  final int? toolId;

  CommercialBroilerFlockRequirementsScreenData(
      {required this.category, required this.toolId});
}

class CommercialBroilerFlockRequirementsScreen extends StatefulWidget {
  static const routeName = "./commercial_broiler_flock_requirements";
  final Category category;
  final int? toolId;

  const CommercialBroilerFlockRequirementsScreen(
      {Key? key, required this.category, required this.toolId})
      : super(key: key);

  @override
  _CommercialBroilerFlockRequirementsScreenState createState() =>
      _CommercialBroilerFlockRequirementsScreenState();
}

class _CommercialBroilerFlockRequirementsScreenState
    extends State<CommercialBroilerFlockRequirementsScreen> with SliderMixin {
  late final _selectedAgeIndexProvider = Provider.autoDispose<int?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.selectedAgeIndex;
  });

  late final _currentSliderValue = Provider<double?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.currentValue;
  });

  late final _toolDataProvider = Provider.autoDispose<Tool?>((ref) {
    return ref.watch(di.toolDetailsViewModelProvider).data?.tool;
  });

  late CustomSliderViewModel sliderViewModel;

  @override
  void initState() {
    getToolDetails();

    super.initState();
  }

  Future setSliderData(Tool tool) async {
    await Future.delayed(Duration.zero, () {
      var currentSliderValue = ProviderScope.containerOf(context,
          listen: false).read(_currentSliderValue);
      sliderViewModel = ProviderScope.containerOf(context,
          listen: false).read(di.customSliderViewModelProvider.notifier);
      sliderViewModel.initSlider(SliderItem(
          duration: tool.duration ?? 'str_day'.tr(),
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
                  : 12),
          step: tool.sliderData?.step != null
              ? tool.sliderData!.step!.toDouble()
              : 1,
          sliderIcons: getSliderIcons(),
          sliderTrackColors: getSliderTrackColors(),
          handlerBorderColor: AppColors.TANGERIEN,
          sliderIntervals: tool.getSliderIntervals()));
    });
  }

  Future getToolDetails() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(di.toolDetailsViewModelProvider.notifier)
          .getDetails(widget.toolId, 12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: CustomAppBar(title: widget.category?.title ?? ''),
      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0),
      body: Column(
        children: [
          Expanded(
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
                  flexibleSpace: Consumer(builder: (_, ref, __) {
                    var tool = ref.watch(_toolDataProvider);
                    return ToolsFlexibleAppBar(
                      title: tool?.title ?? "",
                      backgroundTitle: widget.category.title ?? '',
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Consumer(builder: (cx, ref, __) {
                        var tool = ref.watch(_toolDataProvider);
                        sliderViewModel =
                            ref.watch(di.customSliderViewModelProvider.notifier);
                        if (tool != null) setSliderData(tool);
                        return tool != null
                            ? MediaQuery.removePadding(
                                context: cx,
                                removeTop: true,
                                child: SafeArea(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ToolCategoryHeader(
                                        category: widget.category,
                                      ),
                                      Consumer(builder: (_, ref, __) {
                                        var selectedAgeIndex =
                                        ref.watch(_selectedAgeIndexProvider);
                                        return ListView.builder(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            itemCount:
                                                tool.numberOfSections ?? 0,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return CommercialBroilerFlockDataListView(
                                                  section: tool
                                                      .toolData?[
                                                          selectedAgeIndex ?? 0]
                                                      .sections?[index]);
                                            });
                                      }),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                      ScreenHandler(
                        screenProvider: di.toolDetailsViewModelProvider,
                        onDeviceReconnected: getToolDetails,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer(builder: (_, ref, __) {
            var tool = ref.watch(_toolDataProvider);
            if (tool == null) return const SizedBox.shrink();
            return CustomSlider(onDrag: (value) {
              sliderViewModel.updateSliderWidget(value);
              ProviderScope.containerOf(context,
                  listen: false).read(di.toolDetailsViewModelProvider.notifier)
                  .getSelectedAgeDataIndex(value);
            });
          })
        ],
      ),
    );
  }

  // List<SliderIcon> getSliderIcons() {
  //   List<SliderIcon> list = [
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 0, end: 5),
  //         icon: createSliderIcon("5_days_g.png")),
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 6, end: 15),
  //         icon: createSliderIcon("15_days_g.png")),
  //     SliderIcon(
  //         sliderInterval: SliderInterval(start: 16, end: 42),
  //         icon: createSliderIcon("32_days.png")),
  //   ];
  //   return list;
  // }

  List<SliderIcon> getSliderIcons() {
    List<SliderIcon> list = [
      SliderIcon(
          sliderInterval: SliderInterval(start: 0, end: 10),
          icon: createSliderIcon("8_weeks_g.png", AppColors.TANGERIEN)),
      SliderIcon(
          sliderInterval: SliderInterval(start: 11, end: 20),
          icon: createSliderIcon("15_weeks_g.png", AppColors.LA_SALLE_GREEN)),
      SliderIcon(
          sliderInterval: SliderInterval(start: 21, end: 64),
          icon: createSliderIcon("32_days.png", AppColors.CADMIUM_RED)),
    ];
    return list;
  }

  List<SliderTrackColor> getSliderTrackColors() {
    List<SliderTrackColor> list = [
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 0, end: 10),
          color: AppColors.TANGERIEN),
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 11, end: 20),
          color: AppColors.LA_SALLE_GREEN),
      SliderTrackColor(
          sliderInterval: SliderInterval(start: 21, end: 64),
          color: AppColors.CADMIUM_RED),
    ];
    return list;
  }
}
