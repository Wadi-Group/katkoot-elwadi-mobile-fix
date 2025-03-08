import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/week_data_errors_extractor.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/check_internet_connection.dart';
import '../../models/report_generator/cycle.dart';

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

    bool isOnline = await checkInternetConnection();
    var addWeekDataBox =
        await Hive.openBox<Map>('addWeekDataBox'); // Box for add weeks data
    var cycleBox = await Hive.openBox<Cycle>('psCyclesBox'); // Box for cycles

    Map<String, dynamic> weekData = {
      "cycleId": cycleId,
      "weekNumber": int.parse(weekNumber ?? "0"),
      "femaleFeed": femaleFeed,
      "maleFeed": maleFeed,
      "femaleWeight": femaleWeight,
      "maleWeight": maleWeight,
      "femaleMort": femaleMort,
      "maleMort": maleMort,
      "sexErrors": sexErrors,
      "culls": culls,
      "lightingProgram": lightingProgram,
      "totalEggs": totalEggs,
      "hatchedEggs": hatchedEggs,
      "eggWeight": eggWeight,
    };

    String hiveKey =
        "${cycleId}_$weekNumber"; // Unique key for this week's data
    if (isOnline) {
      // Online Mode: Send data to API
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
        // Update Hive with synced data
        await addWeekDataBox.put(hiveKey, weekData);

        //  Update Cycle's Durations List
        Cycle? cycle = cycleBox.values.firstWhere(
          (c) => c.id.toString() == cycleId,
          orElse: () => Cycle(),
        );

        List<int> updatedDurations = List<int>.from(cycle.durations ?? []);

        int newWeek = int.parse(weekNumber ?? "0");
        if (!updatedDurations.contains(newWeek)) {
          updatedDurations.add(newWeek);
          updatedDurations.sort(); // Keep weeks sorted
          cycle.durations = updatedDurations;
          await cycleBox.put(cycle.key, cycle); // Update Hive storage
        }

        state = BaseState(data: [], isLoading: false);
        showToastMessage(result.successMessage ?? '');
        Navigator.of(context).pop(true);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: [], hasNoConnection: true);
        } else {
          if (result.keyValueErrors != null) {
            print('formsErrors');
            List<UserFormsErrors> errors =
                getWeekFieldsErrors(result.keyValueErrors!);
            if (errors.isEmpty) {
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
    } else {
      // Offline Mode: Save Week Data Locally
      await addWeekDataBox.put(hiveKey, weekData);

      // Update Cycle's Durations Locally
      Cycle? cycle = cycleBox.values.firstWhere(
        (c) => c.id.toString() == cycleId,
        orElse: () => Cycle(),
      );

      List<int> updatedDurations = List<int>.from(cycle.durations ?? []);

      int newWeek = int.parse(weekNumber ?? "0");
      if (!updatedDurations.contains(newWeek)) {
        updatedDurations.add(newWeek);
        updatedDurations.sort(); // Keep weeks sorted
        cycle.durations = updatedDurations;
        await cycle.save(); // Update Hive storage
      }

      state = BaseState(data: [], isLoading: false);
      showToastMessage("Saved offline. It will sync when online.");
      Navigator.of(context).pop(true);
    }
  }

  Future syncPendingWeekData() async {
    bool isOnline = await checkInternetConnection();
    if (!isOnline) return;

    var box = await Hive.openBox<Map>('addWeekDataBox');
    List keys = box.keys.toList();

    for (var key in keys) {
      var data = box.get(key);
      if (data != null) {
        var result = await _repository.addRearingWeekData(
          cycleId: data["cycleId"],
          weekNumber: data["weekNumber"].toString(),
          femaleFeed: data["femaleFeed"],
          maleFeed: data["maleFeed"],
          femaleWeight: data["femaleWeight"],
          maleWeight: data["maleWeight"],
          femaleMort: data["femaleMort"],
          maleMort: data["maleMort"],
          sexErrors: data["sexErrors"],
          culls: data["culls"],
          lightingProgram: data["lightingProgram"],
          totalEggs: data["totalEggs"],
          hatchedEggs: data["hatchedEggs"],
          eggWeight: data["eggWeight"],
        );

        if (result.successMessage != null) {
          await box.delete(key); // Remove from pending after successful sync
        }
      }
    }
  }
}
