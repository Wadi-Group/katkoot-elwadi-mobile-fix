import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/entities/one_signal.dart';
import 'package:katkoot_elwady/features/user_management/models/user.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_base/entities/base_state.dart';
import '../../app_base/mixins/pagination_mixin.dart';
import '../../app_base/screens/main_bottom_app_bar.dart';
import '../../app_base/view_models/base_view_model.dart';


class UserViewModel extends StateNotifier<UserData?> with BaseViewModel, PaginationUtils {
  Repository repository;

  UserViewModel(this.repository) : super(UserData());

  Future<UserData?> getRemoteUserData() async {
    var result = await repository.getUserProfile();
    if (result.data != null) {
      state = result.data!;
      print(state?.token);
    }

    return state;
  }

  resetLocalUserData() {
    state = null;
    repository.saveUserData(null);
  }

  setLocalUserData(UserData? userData) {
    state = userData;
    repository.saveUserData(userData);
  }

  Future<String> getOneSignalPlayerId() async{
    var deviceState = await repository.getOnesignalDeviceState();
    return deviceState?.userId ?? "";
    }

  UserData? getLocalUserData() {
    UserData? userData = repository.getUserData();
    state = userData;
    if (userData == null) {
      unRegisterUserDeleteTags();
    } else {
      print("user found");

      String? formattedDate;

      print(userData.user?.birthDate.toString());
      if (DateTime.tryParse(userData.user?.birthDate.toString() ?? "") !=
          null) {
        DateTime dateMod = DateTime.parse(userData.user!.birthDate.toString());
        print(DateFormat('MM-dd').format(dateMod));
        formattedDate = DateFormat('MM-dd').format(dateMod);
      }

    // if(int.tryParse(userData.user?.id.toString()?? "") !=null){
    //   var userId = int.tryParse(userData.user!.id.toString());
    //   print(userId);
    // }


      repository.sendOnesignalTags(
          status: OneSignalValue.REGISTERED,
          cityId: userData.user?.cityId.toString() ?? -1,
          birthDate: formattedDate != null ? formattedDate.toString() : "",
          categoryId: userData.user?.categoryId ?? []);
    }
    return userData;
  }

  Future<BaseApiResult?> userSignOut() async {
    var deviceState = await repository.getOnesignalDeviceState();
    if (deviceState != null) {
      var result = await repository.putPushToken(
          token: deviceState.userId ?? "", action: "delete");
      if (result.errorType == null) {
        unRegisterUserDeleteTags();
        resetLocalUserData();
        removeParentFlockManagementLocalParameters();
        removeUnseenNotificationCount();
      }
      return result;
    }
  }

  bool isUserLoggedIn() => state?.token != null;

  removeParentFlockManagementLocalParameters() {
    repository.saveParentFlockManagementParameters(null);
  }

  removeUnseenNotificationCount() {
    ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
        listen: false).read(di.unseenNotificationCountProvider.notifier)
        .setLocalUnseenNotificationCount(0);
  }

  void unRegisterUserDeleteTags() {
    repository.deleteOnesignalTags([
      OneSignalTags.CITY_ID,
      OneSignalTags.CATEGORY_ID,
      "cat_1",
      "cat_2",
      "cat_3",
      OneSignalTags.BIRTH_DATE
    ]);
    repository.sendOnesignalStatusTag(status: OneSignalValue.UNREGISTERED);
  }

  Future deleteUser(userId) async {
    // state = BaseState(data: state.data, isLoading: true);
    // UserData? userData = repository.getUserData();
    // state = userData;

    state = UserData(user: state?.user);

    var result = await repository.deleteUser(userId);

    // var result = userId;
    if (result.successMessage != null) {
      // userSignOut();
    // return"user has been deleted";
    //   BaseState(data: []);
    //   state?.user!.removeWhere((element) => element.id == userId);

      BuildContext? context = AppConstants.navigatorKey.currentContext;
      if (context != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return MainBottomAppBar();
        }));}
      var user = state?.user;
      state = UserData(user: user);
      showToastMessage(result.successMessage ?? '');
      // state = userData;
      //
      // return userSignOut();
      // showToastMessage(result.successMessage ?? '');
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        // state =  userData;
        return"user can't delete";
      } else {
        // state = userData;
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);

      }
    }
  }
}
