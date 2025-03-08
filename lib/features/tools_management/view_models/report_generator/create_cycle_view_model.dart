import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/check_internet_connection.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_data.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/report_generator/cycle.dart';

class CreateCycleViewModel
    extends StateNotifier<BaseState<List<UserFormsErrors>>>
    with Validator, BaseViewModel {
  Repository _repository;

  CreateCycleViewModel(this._repository)
      : super(BaseState(data: <UserFormsErrors>[]));

  bool checkCycleFields(
      {required BuildContext context,
      farmName,
      flockNumber,
      roomName,
      arrivalDate,
      femaleNumber,
      maleNumber,
      toolId}) {
    state = BaseState(data: [], isLoading: true);
    List<UserFormsErrors> validationErrors = Validator.validateFields(
        farmName: farmName,
        // flockNumber: flockNumber,
        roomName: roomName,
        arrivalDate: arrivalDate,
        femaleNumber: femaleNumber,
        maleNumber: maleNumber);
    if (validationErrors.isEmpty) {
      state = BaseState(data: [], isLoading: false);
      createCycle(
          context,
          CreateCycle(
              farmName: farmName,
              location: roomName,
              arrivalDate: arrivalDate,
              female: femaleNumber,
              male: maleNumber,
              toolId: toolId.toString()));
      return true;
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
      return false;
    }
  }

  Future createCycle(BuildContext context, CreateCycle data) async {
    state = BaseState(data: [], isLoading: true);

    // Check network connectivity
    bool isOnline = await checkInternetConnection();

    if (isOnline) {
      // Online: Send request to API
      var result = await _repository.createCycle(data);
      if (result.successMessage != null) {
        state = BaseState(data: [], isLoading: false);
        showToastMessage(result.successMessage ?? '');
        Navigator.of(context).pop(true);
      } else {
        state = BaseState(data: [], isLoading: false);
        handleError(
          errorType: result.errorType,
          errorMessage: result.errorMessage,
          keyValueErrors: result.keyValueErrors,
        );
      }
    } else {
      // Offline: Save cycle locally in Hive
      var box = await Hive.openBox<CreateCycle>('pendingCyclesBox');
      await box.add(data);

      // Also add it to the local cycles list for offline access
      var offlineCyclesBox = await Hive.openBox<Cycle>('psCyclesBox');

      // Convert `CreateCycle` to `Cycle` before saving in `psCyclesBox`
      Cycle offlineCycle = Cycle(
        id: DateTime.now().millisecondsSinceEpoch %
            0xFFFFFFFF, // Temporary unique ID
        name: data.farmName,
        farmName: data.farmName,
        arrivalDate: data.arrivalDate,
        location: data.location,
        male: int.tryParse(data.male),
        female: int.tryParse(data.female),
        weeksList: [],
        durations: [],
      );

      await offlineCyclesBox.add(offlineCycle);

      state = BaseState(
        data: [],
        isLoading: false,
      );
      showToastMessage("Cycle saved offline. It will be synced when online.");
      Navigator.of(context).pop(true);
    }
  }

  Future syncPendingCycles() async {
    // Check network connectivity
    bool isOnline = await checkInternetConnection();

    if (isOnline) {
      var box = await Hive.openBox<CreateCycle>('pendingCyclesBox');
      var deleteBox = await Hive.openBox<int>('pendingDeletesBox');
      var cycleBox = await Hive.openBox<Cycle>('psCyclesBox');
      cycleBox.clear();
      for (var cycle in box.values) {
        var result = await _repository.createCycle(cycle);
        if (result.successMessage != null) {
          await box.delete(cycle.key); // Remove after syncing
        }
      }
      // Process pending deletions
      for (var cycleId in deleteBox.values) {
        var result = await _repository.deleteCycle(cycleId);
        if (result.successMessage != null) {
          await deleteBox.delete(cycleId); // Remove from pending deletes
        }
      }
    }
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
