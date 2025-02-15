import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/utils/numbers_manager.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_pullets_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_pullets_parameters_screen.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/parent_flock_management_pullets_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/flock_management_custom_slider.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_flock_management_parameters_button.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_flock_management_pullets_results_view.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/custom_slider_view_model.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class ParentFlockManagementPulletsScreen extends StatefulWidget {
  static const routeName = "./parent_flock_management_pullets";
  final Tool? tool;

  const ParentFlockManagementPulletsScreen({Key? key, required this.tool})
      : super(key: key);

  @override
  _ParentFlockManagementPulletsScreenState createState() =>
      _ParentFlockManagementPulletsScreenState();
}

class _ParentFlockManagementPulletsScreenState
    extends State<ParentFlockManagementPulletsScreen> {
  late CustomSliderViewModel sliderViewModel;

  late final _viewModelProvider = StateNotifierProvider<
      ParentFlockManagementPulletsViewModel,
      BaseState<ParentFlockManagementPulletsState>>((ref) {
    return ParentFlockManagementPulletsViewModel(
        widget.tool, ref.read(di.repositoryProvider));
  });

  late final _pulletsPerWeekProvider = Provider<int?>((ref) {
    return ref.watch(_viewModelProvider).data.pulletsPerWeek;
  });

  @override
  void initState() {
    getDefaultValueResults();
    super.initState();
  }

  Future getDefaultValueResults() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_viewModelProvider.notifier)
          .onSliderValueChange(widget.tool?.sliderData?.defaultValue ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSliderView(),
            ParentFlockManagementParametersButton(onClick: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ParentFlockManagementPulletsParametersScreen(
                    screenProvider: _viewModelProvider,
                    defaults: widget.tool?.equation?.defaults);
              })).then((value) => ProviderScope.containerOf(context,
                  listen: false).read(_viewModelProvider.notifier)
                  .saveParametersToLocal());
            }),
            SizedBox(
              height: 5,
            ),
            Consumer(builder: (_, ref, __) {
              var broilerData = ref.watch(_viewModelProvider).data;
              return ParentFlockManagementPulletsResultsView(
                  broilerData: broilerData,
                  resultTitle: widget.tool?.equation?.resultTitle);
            }),
          ],
        ),
      ),
    );
  }

  _buildSliderView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Consumer(builder: (_, ref, __) {
        var selectedPullets = ref.watch(_pulletsPerWeekProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              title: NumbersManager.getThousandFormat(selectedPullets ??
                  widget.tool?.sliderData?.defaultValue ??
                  0),
              fontSize: 24,
              textColor: AppColors.OLIVE_DRAB,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              title: 'per_year'.tr(),
              textColor: AppColors.Liver,
            ),
            SizedBox(
              height: 10,
            ),
            FlockManagementCustomSlider(
                min: widget.tool?.sliderData?.minValue ?? 0,
                current: selectedPullets ??
                    widget.tool?.sliderData?.defaultValue ??
                    0,
                step: widget.tool?.sliderData?.step ?? 0,
                max: widget.tool?.sliderData?.maxValue ?? 0,
                onDrag: (value) => ProviderScope.containerOf(context,
                    listen: false).read(_viewModelProvider.notifier)
                    .onSliderValueChange((value ?? 0).toInt())),
          ],
        );
      }),
    );
  }
}
