import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_edit_week_data_state.dart';
import 'package:katkoot_elwady/features/tools_management/mixins/week_data_errors_extractor.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

import '../../../../core/utils/check_internet_connection.dart';
import '../../models/report_generator/cycle.dart';
import '../../models/report_generator/week_data.dart';

class EditWeekDataViewModel
    extends StateNotifier<BaseState<CycleEditWeekDataState>>
    with BaseViewModel, Validator, WeekDataErrorsExtractor {
  Repository _repository;

  EditWeekDataViewModel(this._repository)
      : super(BaseState(data: CycleEditWeekDataState()));

  Future getWeekData(String? cycleId, String? weekNumber) async {
    state = BaseState(data: CycleEditWeekDataState(), isLoading: true);

    bool isOnline = await checkInternetConnection();
    var weekBox =
        await Hive.openBox<WeekData>('weekDataBox'); // Open Hive box for weeks

    String hiveKey =
        "${cycleId}_$weekNumber"; // Unique key for fetching the week data

    if (isOnline) {
      // Fetch week data from API
      var result = await _repository.getCycleWeekData(cycleId, weekNumber);

      if (result.data != null) {
        WeekData weekData = result.data!;

        // Store week data to Hive
        await weekBox.put(hiveKey, weekData);

        state = BaseState(data: CycleEditWeekDataState(weekData: weekData));
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state =
              BaseState(data: CycleEditWeekDataState(), hasNoConnection: true);
        } else {
          state = BaseState(data: CycleEditWeekDataState());
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    } else {
      // Offline Mode: Retrieve week data from Hive
      WeekData? cachedWeekData = weekBox.get(hiveKey);

      state = BaseState(data: CycleEditWeekDataState(weekData: cachedWeekData));
    }
  }

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
      sexErrors: sexErrors,
      culls: culls,
      lightingProgram: lightingProgram,
      totalEggs: totalEggs,
      hatchedEggs: hatchedEggs,
      eggWeight: eggWeight,
    );
    if (validationErrors.isEmpty) {
      state = BaseState(
          data: CycleEditWeekDataState(weekData: state.data.weekData));

      editWeekData(
        context: context,
        cycleId: cycleId,
        weekNumber: weekNumber.toString(),
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
      return true;
    } else {
      state = BaseState(
          data: CycleEditWeekDataState(
              weekData: state.data.weekData, errorsList: validationErrors));
      return false;
    }
  }

  Future<void> editWeekData({
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
    state = BaseState(
        data: CycleEditWeekDataState(weekData: state.data.weekData),
        isLoading: true);

    bool isOnline = await checkInternetConnection();
    var editWeekDataBox =
        await Hive.openBox<Map>('editWeekDataBox'); // Box for edited weeks data
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
      "isEdited": true, // Mark as edited for later sync
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
        // Successfully synced, update Hive storage
        await editWeekDataBox.put(hiveKey, weekData);

        // Update Cycle's Durations List
        Cycle? cycle = cycleBox.values.firstWhere(
          (c) => c.id.toString() == cycleId,
          orElse: () => Cycle(),
        );

        List<int> updatedDurations = List<int>.from(cycle.durations ?? []);

        int newWeek = int.parse(weekNumber ?? "0");
        if (!updatedDurations.contains(newWeek)) {
          updatedDurations.add(newWeek);
          updatedDurations.sort();
          cycle.durations = updatedDurations;
          await cycleBox.put(cycle.key, cycle); // Update Hive storage
        }

        state = BaseState(
            data: CycleEditWeekDataState(weekData: state.data.weekData),
            isLoading: false);
        showToastMessage(result.successMessage ?? '');
        Navigator.of(context).pop();
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(
              data: CycleEditWeekDataState(weekData: state.data.weekData),
              hasNoConnection: true);
        } else {
          if (result.keyValueErrors != null) {
            print('formsErrors');
            List<UserFormsErrors> errors =
                getWeekFieldsErrors(result.keyValueErrors!);
            if (errors.isEmpty) {
              showToastMessage(result.keyValueErrors!['default'] ?? '');
            }
            state = BaseState(
                data: CycleEditWeekDataState(
                    weekData: state.data.weekData, errorsList: errors),
                isLoading: false);
          } else {
            print('not forms errors');
            state = BaseState(
                data: CycleEditWeekDataState(
                    weekData: state.data.weekData, errorsList: []),
                isLoading: false);
            handleError(
                errorType: result.errorType,
                errorMessage: result.errorMessage,
                keyValueErrors: result.keyValueErrors);
          }
        }
      }
    } else {
      // Offline Mode: Save edited week data locally
      await editWeekDataBox.put(hiveKey, weekData);

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

      state = BaseState(
          data: CycleEditWeekDataState(weekData: state.data.weekData),
          isLoading: false);
      showToastMessage("Edit saved offline. It will sync when online.");
      Navigator.of(context).pop();
    }
  }

  Future syncEditedWeekData() async {
    bool isOnline = await checkInternetConnection();
    if (!isOnline) return;

    var editWeekDataBox = await Hive.openBox<Map>('editWeekDataBox');

    for (var key in editWeekDataBox.keys) {
      Map<dynamic, dynamic> weekData = editWeekDataBox.get(key) ?? {};

      var result = await _repository.addRearingWeekData(
        cycleId: weekData["cycleId"],
        weekNumber: weekData["weekNumber"].toString(),
        femaleFeed: weekData["femaleFeed"],
        maleFeed: weekData["maleFeed"],
        femaleWeight: weekData["femaleWeight"],
        maleWeight: weekData["maleWeight"],
        femaleMort: weekData["femaleMort"],
        maleMort: weekData["maleMort"],
        sexErrors: weekData["sexErrors"],
        culls: weekData["culls"],
        lightingProgram: weekData["lightingProgram"],
        totalEggs: weekData["totalEggs"],
        hatchedEggs: weekData["hatchedEggs"],
        eggWeight: weekData["eggWeight"],
      );

      if (result.successMessage != null) {
        await editWeekDataBox.delete(key); // Remove successfully synced data
      }
    }
  }
}
