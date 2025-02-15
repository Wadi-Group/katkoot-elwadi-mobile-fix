import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/tools_management/entities/view_rearing_week_data_state.dart';
import 'package:katkoot_elwady/features/tools_management/screens/cb_report_generator/view_production_week_data_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewRearingWeekDataViewModel
    extends StateNotifier<BaseState<ViewRearingWeekDataState?>>
    with BaseViewModel, Validator {
  Repository _repository;
  int? selectedAgeIndex;

  ViewRearingWeekDataViewModel(this._repository)
      : super(BaseState(data: ViewRearingWeekDataState()));

  Future getCycleData(String? cycleId, int defaultSectionIndex) async {
    if (cycleId != null) {
      ViewRearingWeekDataState? cycleState;
      state = BaseState(data: cycleState, isLoading: true);

      var result = await _repository.getCycleDetails(cycleId);
      print(result.data);
      if (result.data != null) {
        cycleState = ViewRearingWeekDataState(
            cycle: result.data, selectedWeekNumber: defaultSectionIndex);
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
    // for(int i=0 ; i < cycleData.length; i++){
    //   if(index == (cycleData[i].duration ?? 0)) {
    state.data?.selectedWeekNumber = index.toInt(); //-1
    state = BaseState(
        data: ViewRearingWeekDataState(
            cycle: state.data?.cycle, selectedWeekNumber: index.toInt()));
    //     break;
    //   }
    // }
    // state.data?.selectedAgeIndex = index.toInt();
    // state = BaseState(
    //     data: ViewRearingWeekDataState(
    //         cycle: state.data?.cycle,
    //         selectedAgeIndex: index.toInt(),
    //         currentValue: index));
  }

  bool toggleFunction() {
    var Cbcycle = state.data!.cycle;
    var selectedWeek = Cbcycle?.getMaxProductionWeek();
    if (selectedWeek != null) {
      if (selectedWeek >= AppConstants.PRODUCTION_MIN_VALUE &&
          selectedWeek <= AppConstants.PRODUCTION_MAX_VALUE) {
        navigateToScreen(ViewProductionWeekDataScreen.routeName,
            replace: true,
            arguments: ViewProductionWeekDataScreenData(
                cycleName: Cbcycle?.name,
                cycleId: Cbcycle?.id.toString(),
                weekNumber: selectedWeek));
      }
      return true;
    } else {
      showToastMessage("str_no_data_prov".tr());
      return false;
    }
  }
}
