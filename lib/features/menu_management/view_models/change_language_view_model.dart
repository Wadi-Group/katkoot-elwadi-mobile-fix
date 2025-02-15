import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLanguageViewModel extends StateNotifier<BaseState>
    with BaseViewModel, NavigationDrawerMixin {
  Repository _repository;

  ChangeLanguageViewModel(this._repository)
      : super(BaseState(
            data: AppConstants.navigatorKey.currentContext?.locale.toString() ??
                'ar'));

  changeLanguage(String languageCode) async {
    this.state = BaseState(data: languageCode);
    // state = state;
  }

  confirmLanguageToggle() async {
    await AppConstants.navigatorKey.currentContext
        ?.setLocale(Locale(this.state.data));
    if (await isOnBoardingComplete()) {
      // resetDrawerSelection();
    } else {
      _repository.setOnBoardingComplete();

      navigateToScreen(MainBottomAppBar.routeName, replace: true);
    }
  }

  Future<bool> isOnBoardingComplete() async =>
      await _repository.isOnBoardingComplete();
}
