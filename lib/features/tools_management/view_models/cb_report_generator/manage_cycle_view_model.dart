import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cb_cycle_data.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageCycleViewModel extends StateNotifier<BaseState>
    with Validator, BaseViewModel {
  Repository _repository;

  ManageCycleViewModel(this._repository) : super(BaseState(data: []));

  Future deleteCycleWeek(BuildContext context, int cycleId, int duration) async {
    state = BaseState(data: [], isLoading: true);
    var result = await _repository.deleteCycleWeek(cycleId, duration);
    if (result.successMessage != null) {
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
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
