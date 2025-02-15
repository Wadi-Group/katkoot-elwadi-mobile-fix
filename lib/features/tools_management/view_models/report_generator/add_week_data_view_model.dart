import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/week_data_errors_extractor.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class AddWeekDataViewModel
    extends StateNotifier<BaseState<List<UserFormsErrors>>>
    with BaseViewModel, Validator, WeekDataErrorsExtractor {
  Repository _repository;

  AddWeekDataViewModel(this._repository) : super(BaseState(data: []));

  bool checkDataFields({
    required BuildContext context,
    String? cycleId,
    String? weekNumber,
    String? femaleFeed,
    String? maleFeed,
    String? femaleWeight,
    String? maleWeight,
    String? femaleMort,
    String? maleMort,
    String? sexErrors,
    String? culls,
    String? lightingProgram,
    String? totalEggs,
    String? hatchedEggs,
    String? eggWeight,
  }) {
    List<UserFormsErrors> validationErrors = Validator.validateFields(
      femaleFeed: femaleFeed,
      maleFeed: maleFeed,
      femaleWeight: femaleWeight,
      maleWeight: maleWeight,
      femaleMort: femaleMort,
      maleMort: maleMort,
      sexErrors: int.parse(weekNumber!) > 15 ? sexErrors : "0",
      culls: culls,
      lightingProgram: lightingProgram,
      totalEggs: totalEggs,
      hatchedEggs: hatchedEggs,
      eggWeight: eggWeight,
    );
    if (validationErrors.isEmpty) {
      state = BaseState(data: []);

      addWeekData(
        context: context,
        cycleId: cycleId,
        weekNumber: weekNumber.toString(),
        femaleFeed: femaleFeed,
        maleFeed: maleFeed,
        femaleWeight: femaleWeight,
        maleWeight: maleWeight,
        femaleMort: femaleMort,
        maleMort: maleMort,
        sexErrors: int.parse(weekNumber) > 15 ? sexErrors : "0",
        culls: culls,
        lightingProgram: lightingProgram,
        totalEggs: totalEggs,
        hatchedEggs: hatchedEggs,
        eggWeight: eggWeight,
      );
      return true;
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
      return false;
    }
  }

  Future addWeekData({
    required BuildContext context,
    required String? cycleId,
    required String? weekNumber,
    required String? femaleFeed,
    required String? maleFeed,
    required String? femaleWeight,
    required String? maleWeight,
    required String? femaleMort,
    required String? maleMort,
    required String? sexErrors,
    required String? culls,
    required String? lightingProgram,
    required String? totalEggs,
    required String? hatchedEggs,
    required String? eggWeight,
  }) async {
    state = BaseState(data: [], isLoading: true);
    var result = await _repository.addRearingWeekData(
      cycleId: cycleId,
      weekNumber: weekNumber,
      femaleFeed: femaleFeed,
      maleFeed: maleFeed,
      femaleWeight: femaleWeight,
      maleWeight: maleWeight,
      femaleMort: femaleMort,
      maleMort: maleMort,
      sexErrors: sexErrors,
      culls: culls,
      lightingProgram: lightingProgram,
      totalEggs: totalEggs,
      hatchedEggs: hatchedEggs,
      eggWeight: eggWeight,
    );
    if (result.successMessage != null) {
      state = BaseState(data: [], isLoading: false);
      showToastMessage(result.successMessage ?? '');
      Navigator.of(context).pop(true);
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state = BaseState(data: [], hasNoConnection: true);
      } else {
        if(result.keyValueErrors != null){
          print('formsErrors');
          List<UserFormsErrors> errors = getWeekFieldsErrors(result.keyValueErrors!);
          if(errors.isEmpty){
            showToastMessage(result.keyValueErrors!['default'] ?? '');
          }
          state = BaseState(data: errors, isLoading: false);
        } else {
          print('not forms errors');
          state = BaseState(data: [], isLoading: false);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }

      }
    }
  }
}
