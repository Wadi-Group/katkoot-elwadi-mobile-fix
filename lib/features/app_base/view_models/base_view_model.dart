import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/one_signal.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin BaseViewModel {
  void handleError(
      {ErrorType? errorType,
      String? errorMessage,
      Map<String, dynamic>? keyValueErrors}) {
    print('${keyValueErrors?['default'].toString()}');
    if (errorType == ErrorType.NO_NETWORK_ERROR) {
      showToastMessage('str_no_connection'.tr());
    } else if (errorType == ErrorType.GENERAL_ERROR) {
      showToastMessage('str_general_error'.tr());
    } else if (errorType == ErrorType.UNAUTHORIZED_ERROR) {
      BuildContext? context = AppConstants.navigatorKey.currentContext;
      if (context != null) {
        ProviderScope.containerOf(context, listen: false)
            .read(di.userViewModelProvider.notifier)
            .resetLocalUserData();
        ProviderScope.containerOf(context, listen: false)
            .read(di.userViewModelProvider.notifier)
            .removeParentFlockManagementLocalParameters();
        OneSignal.shared.deleteTags([
          OneSignalTags.CITY_ID,
          OneSignalTags.CATEGORY_ID,
          "cat_1",
          "cat_2",
          "cat_3"
        ]);
        OneSignal.shared
            .sendTag(OneSignalTags.STATUS, OneSignalValue.UNREGISTERED);

        navigateToScreen(MainBottomAppBar.routeName, replace: true);
      }
    } else if (keyValueErrors != null && keyValueErrors['default'] != null) {
      showToastMessage(keyValueErrors['default']);
    } else {
      showToastMessage(errorMessage ?? 'str_general_error'.tr());
    }
  }

  void showToastMessage(String message) {
    if (AppConstants.navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(AppConstants.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(
              backgroundColor: AppColors.DARK_SPRING_GREEN,
              content: CustomText(
                title: message,
                fontWeight: FontWeight.w500,
                textColor: Colors.white,
                maxLines: 5,
              )));
    }
  }

  void navigateToScreen(String screenRoute,
      {bool removeTop = false,
      bool replace = false,
      bool clearStack = false,
      dynamic arguments}) {
    hideKeyboard();
    if (removeTop) {
      AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          screenRoute, (route) => false,
          arguments: arguments);
    } else if (replace) {
      AppConstants.navigatorKey.currentState
          ?.pushReplacementNamed(screenRoute, arguments: arguments);
    } else if (clearStack) {
      AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          './home', (Route<dynamic> route) => false,
          arguments: arguments);
    } else {
      AppConstants.navigatorKey.currentState
          ?.pushNamed(screenRoute, arguments: arguments);
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
