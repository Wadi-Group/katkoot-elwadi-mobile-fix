import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/check_internet_connection.dart';
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

  Future<void> getCycles(
      {bool refresh = false, bool showLoading = true}) async {
    if (checkPerformRequest(refresh: refresh)) return;

    isPerformingRequest = true;
    if (refresh) {
      reset();
    }

    state = BaseState(data: state.data, isLoading: showLoading);

    // Check network status
    bool isOnline = await checkInternetConnection();

    // Open Hive box for caching cycles
    var box = await Hive.openBox<Cycle>('psCyclesBox');

    if (!isOnline) {
      // No internet: Load cycles from Hive
      print("No internet connection. Loading cycles from local storage...");
      List<Cycle> cachedCycles = box.values.toList();
      state = BaseState(
          data: cachedCycles,
          isLoading: false,
          hasNoData: cachedCycles.isEmpty);
      isPerformingRequest = false;
      return;
    }

    // Internet is available: Fetch from API
    print("Fetching cycles from API...");
    var result = await _repository.getCycles(page, limit);

    if (result.data != null) {
      page++;
      checkHasNext(result.data ?? []);

      List<Cycle> cycles =
          refresh ? result.data! : [...state.data ?? [], ...result.data!];

      // Save new cycles to Hive
      await box.clear(); // Clear old cycles
      await box.addAll(cycles);

      state = BaseState(data: cycles, hasNoData: cycles.isEmpty);
    } else {
      state = BaseState(
        data: state.data,
        hasNoConnection: result.errorType == ErrorType.NO_NETWORK_ERROR,
      );
      handleError(
        errorType: result.errorType,
        errorMessage: result.errorMessage,
        keyValueErrors: result.keyValueErrors,
      );
    }

    isPerformingRequest = false;
  }

  Future deleteCycle(int cycleId) async {
    state = BaseState(data: state.data, isLoading: true);

    bool isOnline = await checkInternetConnection();

    if (isOnline) {
      // Online: Call API to delete cycle
      var result = await _repository.deleteCycle(cycleId);
      if (result.successMessage != null) {
        // Remove from the in-memory list
        state.data!.removeWhere((element) => element.id == cycleId);
        var cycles = state.data;

        // Remove from Hive offline storage
        var box = await Hive.openBox<Cycle>('psCyclesBox');
        await box.delete(cycleId.toString());

        state = BaseState(data: cycles, isLoading: false);
        showToastMessage(result.successMessage ?? '');
      } else {
        state = BaseState(data: state.data, isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    } else {
      // Offline: Mark cycle as "to be deleted" in Hive
      var box = await Hive.openBox<int>('pendingDeletesBox');
      await box.put(cycleId, cycleId); // Store cycleId for later deletion

      // Also remove it from the local cycles list
      var cyclesBox = await Hive.openBox<Cycle>('psCyclesBox');
      var allCycles = cyclesBox.values.toList();
      allCycles.removeWhere((cycle) => cycle.id == cycleId);

// Clear the box and re-add the filtered list
      await cyclesBox.clear();
      for (var cycle in allCycles) {
        await cyclesBox.put(cycle.id, cycle);
      }

      state.data!.removeWhere((element) => element.id == cycleId);
      state = BaseState(data: state.data, isLoading: false);

      showToastMessage("Cycle deleted offline. Changes will sync when online.");
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
