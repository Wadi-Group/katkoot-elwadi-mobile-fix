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
import 'package:katkoot_elwady/features/tools_management/entities/cycle_week_data_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/add_week_data_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/cycle_action_buttons.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/cycle_week_data_item.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class AddRearingWeekDataScreenData {
  final String? cycleId;
  final String? weekNumber;

  AddRearingWeekDataScreenData(
      {required this.cycleId, required this.weekNumber});
}

class AddRearingWeekDataScreen extends StatefulWidget {
  static const routeName = "./add_rearing_week_data";

  final String? cycleId;
  final String? weekNumber;

  const AddRearingWeekDataScreen(
      {required this.cycleId, required this.weekNumber});

  @override
  _AddRearingWeekDataScreenState createState() =>
      _AddRearingWeekDataScreenState();
}

class _AddRearingWeekDataScreenState extends State<AddRearingWeekDataScreen>
    with BaseViewModel {
  final _screenViewModelProvider = StateNotifierProvider<AddWeekDataViewModel,
      BaseState<List<UserFormsErrors>>>((ref) {
    return AddWeekDataViewModel(ref.read(di.repositoryProvider));
  });

  TextEditingController femaleFeedController = TextEditingController();
  TextEditingController maleFeedController = TextEditingController();
  TextEditingController femaleWeightController = TextEditingController();
  TextEditingController maleWeightController = TextEditingController();
  TextEditingController femaleMortController = TextEditingController();
  TextEditingController maleMortController = TextEditingController();
  TextEditingController sexErrorsController = TextEditingController();
  TextEditingController cullsController = TextEditingController();

  submitWeekData() {
    ProviderScope.containerOf(context,
        listen: false).read(_screenViewModelProvider.notifier).checkDataFields(
        context: context,
        cycleId: widget.cycleId.toString(),
        weekNumber: widget.weekNumber.toString(),
        femaleFeed: femaleFeedController.text,
        maleFeed: maleFeedController.text,
        femaleWeight: femaleWeightController.text,
        maleWeight: maleWeightController.text,
        femaleMort: femaleMortController.text,
        maleMort: maleMortController.text,
        sexErrors: sexErrorsController.text,
        culls: cullsController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'add_rearing_data'.tr(),
        onBackClick: () => Navigator.of(context).pop(),
        //widget.tool!.title
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
          CycleWeekDataItem(
              title: 'Female feed'.tr(),
              controller: femaleFeedController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_FEED.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CycleWeekDataItem(
              title: 'Male feed'.tr(),
              controller: maleFeedController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_FEED.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CycleWeekDataItem(
              title: 'Female weight'.tr(),
              controller: femaleWeightController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_WEIGHT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CycleWeekDataItem(
              title: 'Male weight'.tr(),
              controller: maleWeightController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_WEIGHT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CycleWeekDataItem(
              title: 'female_mort'.tr(),
              controller: femaleMortController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.FEMALE_MORT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          CycleWeekDataItem(
              title: 'male_mort'.tr(),
              controller: maleMortController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.MALE_MORT.id,
                      orElse: () => UserFormsErrors())
                  .message),
          if (int.parse(widget.weekNumber!) > 15)
            CycleWeekDataItem(
                title: 'Sex errors'.tr(),
                controller: sexErrorsController,
                errorMessage: errors
                    .firstWhere(
                        (element) =>
                            element.field == CycleWeekDataFields.SEX_ERRORS.id,
                        orElse: () => UserFormsErrors())
                    .message),
          CycleWeekDataItem(
              title: 'Culls'.tr(),
              controller: cullsController,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleWeekDataFields.CULLS.id,
                      orElse: () => UserFormsErrors())
                  .message),
        ],
      );
    });
  }
}
