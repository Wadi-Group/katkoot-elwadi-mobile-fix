import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/tools_management/entities/cb_cycle_week_data_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/cb_report_generator/add_week_data_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/cycle_action_buttons.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/cycle_week_data_item.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class AddProductionWeekDataScreenData {
  final String? cycleId;
  final String? weekNumber;

  AddProductionWeekDataScreenData(
      {required this.cycleId, required this.weekNumber});
}

class AddProductionWeekDataScreen extends StatefulWidget {
  static const routeName = "./add_production_week_data";

  final String? cycleId;
  final String? weekNumber;

  const AddProductionWeekDataScreen(
      {required this.cycleId, required this.weekNumber});

  @override
  _AddProductionWeekDataScreenState createState() =>
      _AddProductionWeekDataScreenState();
}

class _AddProductionWeekDataScreenState
    extends State<AddProductionWeekDataScreen> with BaseViewModel {
  final _screenViewModelProvider = StateNotifierProvider<AddWeekDataViewModel,
      BaseState<List<UserFormsErrors>>>((ref) {
    return AddWeekDataViewModel(ref.read(di.repositoryProvider));
  });

  TextEditingController lightingProgramController = TextEditingController();
  TextEditingController femaleFeedController = TextEditingController();
  TextEditingController maleFeedController = TextEditingController();
  TextEditingController femaleWeightController = TextEditingController();
  TextEditingController maleWeightController = TextEditingController();
  TextEditingController femaleMortController = TextEditingController();
  TextEditingController maleMortController = TextEditingController();
  TextEditingController totalEggsController = TextEditingController();
  TextEditingController hatchedEggsController = TextEditingController();
  TextEditingController eggWeightController = TextEditingController();

  submitWeekData() {
    ProviderScope.containerOf(context,
        listen: false).read(_screenViewModelProvider.notifier).checkDataFields(
          context: context,
          cycleId: widget.cycleId.toString(),
          weekNumber: widget.weekNumber.toString(),
          lightingProgram: lightingProgramController.text,
          femaleFeed: femaleFeedController.text,
          maleFeed: maleFeedController.text,
          femaleWeight: femaleWeightController.text,
          maleWeight: maleWeightController.text,
          femaleMort: femaleMortController.text,
          maleMort: maleMortController.text,
          totalEggs: totalEggsController.text,
          hatchedEggs: hatchedEggsController.text,
          eggWeight: eggWeightController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'add_production_data'.tr(),
        onBackClick: () => Navigator.of(context).pop(),//widget.tool!.title
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomText(
                        title: 'str_week'.tr() +
                            ' ' +
                            widget.weekNumber.toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.DARK_SPRING_GREEN,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      buildDataFieldsView(),
                      SizedBox(height: 40),
                      CycleActionButtons(
                        submitButtonTitle: 'add_data'.tr(),
                        onSubmit: () {
                          hideKeyboard();
                          if (widget.cycleId != null) {
                            submitWeekData();
                          }
                        },
                        onCancel: () {
                          hideKeyboard();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ScreenHandler(
                screenProvider: _screenViewModelProvider,
                onDeviceReconnected: submitWeekData,
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   shouldPop: true,
      // ),
    );
  }

  buildDataFieldsView() {
    return Consumer(builder: (_, ref, __) {
      final errors = ref.watch(_screenViewModelProvider).data;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CbCycleWeekDataItem(
              title: 'lighting_program'.tr(),
              controller: lightingProgramController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field ==
                          CycleWeekDataFields.LIGHTING_PROGRAM.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'female_feed'.tr(),
              controller: femaleFeedController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_FEED.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'male_feed'.tr(),
              controller: maleFeedController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_FEED.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'female_weight'.tr(),
              controller: femaleWeightController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_WEIGHT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'male_weight'.tr(),
              controller: maleWeightController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_WEIGHT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            height: 3,
            color: AppColors.LIGHT_GREY,
          ),
          CbCycleWeekDataItem(
              title: 'female_mort'.tr(),
              controller: femaleMortController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_MORT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'male_mort'.tr(),
              controller: maleMortController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_MORT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'total_eggs'.tr(),
              controller: totalEggsController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.TOTAL_EGGS.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem(
              title: 'hatched_eggs'.tr(),
              controller: hatchedEggsController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.HATCHED_EGGS.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CbCycleWeekDataItem  (
              title: 'egg_weight'.tr(),
              controller: eggWeightController,
              hasDecimal: true,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.EGG_WEIGHT.id,
                      orElse: () => UserFormsErrors())
                  .message),
        ],
      );
    });
  }
}
