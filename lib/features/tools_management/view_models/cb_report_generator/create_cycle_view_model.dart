// import 'package:flutter/cupertino.dart';
// import 'package:katkoot_elwady/core/constants/app_constants.dart';
// import 'package:katkoot_elwady/core/services/repository.dart';
// import 'package:katkoot_elwady/core/utils/validator.dart';
// import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
// import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
// import 'package:katkoot_elwady/features/tools_management/entities/cb_cycle_data.dart';
// import 'package:katkoot_elwady/features/tools_management/entities/cycle_data.dart';
// import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CreateCbCycleViewModel
//     extends StateNotifier<BaseState<List<UserFormsErrors>>>
//     with Validator, BaseViewModel {
//   Repository _repository;
//
//   CreateCbCycleViewModel(this._repository)
//       : super(BaseState(data: <UserFormsErrors>[]));
//
//   bool checkCycleFields(
//       {
//         required BuildContext context, farmName, flockNumber,
//         roomName, arrivalDate, femaleNumber, maleNumber,
//         toolId
//       }) {
//     state = BaseState(data: [], isLoading: true);
//     List<UserFormsErrors> validationErrors = Validator.validateFields(
//         farmName: farmName,
//         // flockNumber: flockNumber,
//         roomName: roomName,
//         arrivalDate: arrivalDate,
//         femaleNumber: femaleNumber,
//         maleNumber: maleNumber);
//     if (validationErrors.isEmpty) {
//       state = BaseState(data: [], isLoading: false);
//       createCbCycle(context, CreateCbCycle(
//           farmName: farmName,
//           location: roomName,
//           arrivalDate: arrivalDate,
//           female: femaleNumber,
//           male: maleNumber,
//           toolId: toolId.toString()));
//       return true;
//     } else {
//       state = BaseState(data: validationErrors, isLoading: false);
//       return false;
//     }
//   }
//
//   Future createCbCycle(BuildContext context, CreateCbCycle data) async {
//     state = BaseState(data: [], isLoading: true);
//     var result = await _repository.createCbCycle(data as CreateCycle);
//     if (result.successMessage != null) {
//       state = BaseState(data: [], isLoading: false);
//       showToastMessage(result.successMessage ?? '');
//       Navigator.of(context).pop(true);
//     } else {
//       if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
//         state = BaseState(data: [], hasNoConnection: true, isLoading: false);
//       } else {
//         state = BaseState(data: [], isLoading: false);
//         handleError(
//             errorType: result.errorType,
//             errorMessage: result.errorMessage,
//             keyValueErrors: result.keyValueErrors);
//       }
//     }
//   }
//
//   void resetState() {
//     state = BaseState(data: [], isLoading: false);
//   }
// }
