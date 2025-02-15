import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cb_view_production_week_data_state.dart';
import 'package:katkoot_elwady/features/tools_management/screens/cb_report_generator/view_rearing_week_data_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewProductionWeekDataViewModel
    extends StateNotifier<BaseState<ViewProductionWeekDataState?>>
    with BaseViewModel, Validator {
  Repository _repository;
  int? selectedAgeIndex;

  ViewProductionWeekDataViewModel(this._repository)
      : super(BaseState(data: ViewProductionWeekDataState()));

  Future getCbCycleData(String? cycleId, int defaultSectionIndex) async {
    if (cycleId != null) {
      ViewProductionWeekDataState? cycleState;
      state = BaseState(data: cycleState, isLoading: true);

      var result = await _repository.getCbCycleDetails(cycleId);
      print(result.data);
      if (result.data != null) {
        cycleState = ViewProductionWeekDataState(
            CbCycle: result.data, selectedWeekNumber: defaultSectionIndex);
        state = BaseState(data: cycleState);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: cycleState, hasNoConnection: true);
        } else {
          state = BaseState(data: cycleState);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    }
  }

  getSelectedAgeDataIndex(double index) {
    // var cycleData = state.data?.cycle?.weeksList ?? [];
    // for(int i=25 ; i < cycleData.length; i++){
    //   if(index == (cycleData[i].duration ?? 0)) {
    state.data?.selectedWeekNumber = index.toInt(); //-1
    state = BaseState(
        data: ViewProductionWeekDataState(
            cbcycle: state.data?.cbcycle, selectedWeekNumber: index.toInt()));
    //   break;
    // }
    // }
    // state.data?.selectedAgeIndex = index.toInt();
    // state = BaseState(
    //     data: ViewRearingWeekDataState(
    //         cycle: state.data?.cycle,
    //         selectedAgeIndex: index.toInt(),
    //         currentValue: index));
  }

  bool toggleFunction() {
    print("toggle");
    var cbcycle = state.data!.cbcycle;
    var selectedWeek = cbcycle?.getCbMaxRearingWeek();

    if (selectedWeek != null) {
      if (selectedWeek >= AppConstants.REARING_MIN_VALUE &&
          selectedWeek <= AppConstants.REARING_MAX_VALUE) {
        navigateToScreen(ViewRearingWeekDataScreen.routeName,
            replace: true,
            arguments: ViewRearingWeekDataScreenData(
                cycleName: cbcycle?.name,
                cycleId: cbcycle?.id.toString(),
                weekNumber: selectedWeek));
      }
      return true;
    } else {
      showToastMessage("str_no_data_prov".tr());
      return false;
    }
  }
}
