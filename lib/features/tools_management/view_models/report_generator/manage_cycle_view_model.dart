import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/check_internet_connection.dart';
import '../../models/report_generator/cycle.dart';

class ManageCycleViewModel extends StateNotifier<BaseState>
    with Validator, BaseViewModel {
  Repository _repository;

  ManageCycleViewModel(this._repository) : super(BaseState(data: []));

  Future<void> deleteCycleWeek(
      BuildContext context, int cycleId, int duration) async {
    state = BaseState(data: [], isLoading: true);

    bool isOnline = await checkInternetConnection();
    var deleteBox =
        await Hive.openBox('pending_deletions'); // Store pending deletions
    var addWeekDataBox =
        await Hive.openBox<Map>('addWeekDataBox'); // Store week data
    var cycleBox = await Hive.openBox<Cycle>('psCyclesBox'); // Store cycle data

    String hiveKey = "${cycleId}_$duration"; // Key to identify the week

    if (isOnline) {
      // Online Mode: Call API to delete the week
      var result = await _repository.deleteCycleWeek(cycleId, duration);
      if (result.successMessage != null) {
        // Remove from Hive since it is successfully deleted online
        await addWeekDataBox.delete(hiveKey);

        // Update Cycle: Remove week from durations
        Cycle? cycle = cycleBox.values.firstWhere(
          (c) => c.id.toString() == cycleId,
          orElse: () => Cycle(),
        );

        if (cycle.durations != null && cycle.durations!.contains(duration)) {
          cycle.durations!.remove(duration);
          await cycleBox.put(cycle.key, cycle); // Update cycle in Hive
        }

        state = BaseState(data: [], isLoading: false);
        showToastMessage(result.successMessage ?? '');
        Navigator.of(context).pop(true);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: [], hasNoConnection: true, isLoading: false);
        } else {
          state = BaseState(data: [], isLoading: false);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    } else {
      // Offline Mode: Store pending deletion
      await deleteBox.put(hiveKey, {'cycleId': cycleId, 'duration': duration});

      // Remove from local addWeekDataBox (as it's "deleted" offline)
      await addWeekDataBox.delete(hiveKey);

      // Update Cycle's duration list
      Cycle? cycle = cycleBox.values.firstWhere(
        (c) => c.id.toString() == cycleId.toString(),
        orElse: () => Cycle(),
      );

      if (cycle.durations != null && cycle.durations!.contains(duration)) {
        cycle.durations!.remove(duration);
        await cycleBox.put(cycle.key, cycle); // Update cycle in Hive
      }

      state = BaseState(data: [], isLoading: false);
      showToastMessage("Deleted offline. Will sync when online.");
      Navigator.of(context).pop(true);
    }
  }

  Future<void> syncPendingDeletions() async {
    bool isOnline = await checkInternetConnection();
    if (!isOnline) return;

    var box = await Hive.openBox('pending_deletions');
    for (var key in box.keys) {
      var data = box.get(key);
      if (data != null) {
        var result = await _repository.deleteCycleWeek(
            data['cycleId'], data['duration']);
        if (result.successMessage != null) {
          await box.delete(key); // Remove from pending deletions after success
        }
      }
    }
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
