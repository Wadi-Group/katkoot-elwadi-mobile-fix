import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_rearing_week_data_screen.dart';

class CyclesListViewModel extends StateNotifier<BaseState<List<Cycle>?>>
    with BaseViewModel, PaginationUtils {
  Repository _repository;

  CyclesListViewModel(this._repository) : super(BaseState(data: []));

  Future getCycles({bool refresh = false, bool showLoading = true}) async {
    if (checkPerformRequest(refresh: refresh)) return;

    isPerformingRequest = true;

    if (refresh) {
      reset();
    }

    state = BaseState(data: state.data, isLoading: showLoading);

    var result = await _repository.getCycles(page, limit);
    if (result.data != null) {
      page++;
      checkHasNext(result.data ?? []);

      List<Cycle>? cycles =
          refresh ? result.data : [...state.data!, ...result.data!];
      state = BaseState(data: cycles, hasNoData: cycles!.isEmpty);
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
          (state.data?.isEmpty ?? true)) {
        state = BaseState(data: [], hasNoConnection: true);
      } else {
        state = BaseState(data: state.data);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
    isPerformingRequest = false;
  }

  Future deleteCycle(int cycleId) async {
    state = BaseState(data: state.data, isLoading: true);
    var result = await _repository.deleteCycle(cycleId);
    if (result.successMessage != null) {
      state.data!.removeWhere((element) => element.id == cycleId);
      var cycles = state.data;
      state = BaseState(data: cycles, isLoading: false);
      showToastMessage(result.successMessage ?? '');
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state = BaseState(
            data: state.data, hasNoConnection: true, isLoading: false);
      } else {
        state = BaseState(data: state.data, isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  void navigateToCycleGraph(Cycle cycle) {
    var selectedWeek = cycle.getMaxWeek();
    if (selectedWeek != 0) {
      if (selectedWeek >= AppConstants.REARING_MIN_VALUE &&
          selectedWeek <= AppConstants.REARING_MAX_VALUE) {
        navigateToScreen(ViewRearingWeekDataScreen.routeName,
            arguments: ViewRearingWeekDataScreenData(
                cycleName: cycle.name,
                cycleId: cycle.id.toString(),
                weekNumber: selectedWeek));
      } else if (selectedWeek >= AppConstants.PRODUCTION_MIN_VALUE &&
          selectedWeek <= AppConstants.PRODUCTION_MAX_VALUE) {
        navigateToScreen(ViewProductionWeekDataScreen.routeName,
            arguments: ViewProductionWeekDataScreenData(
                cycleName: cycle.name,
                cycleId: cycle.id.toString(),
                weekNumber: selectedWeek));
      }
    }
  }

  @override
  void dispose() {
    resetState();
    super.dispose();
  }

  void resetState() {
    reset();
    state = BaseState(data: [], isLoading: false);
  }
}
