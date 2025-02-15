import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/guides_management/screens/category_videos_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/categorized_videos_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:katkoot_elwady/features/category_management/screens/home_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/edit_profile_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/where_to_find_us_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/contact_us_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/send_message_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';
import 'package:riverpod/riverpod.dart';

import '../entities/navigation_item.dart';

import 'package:katkoot_elwady/features/user_management/view_models/user_data_view_model.dart';

class NavigationViewModel extends StateNotifier<BaseState> with BaseViewModel {
  Repository _repository;

  NavigationViewModel(this._repository)
      : super(BaseState(data: NavigationItem.home));

  redirectToScreen(BuildContext context, NavigationItem item) {
    switch (item) {
      case NavigationItem.support:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SendSupportMessageScreen();
        }));
        break;
      case NavigationItem.where_to_find_us:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WhereToFindUsScreen();
        }));
        break;
      case NavigationItem.received_messages:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MessagesListScreen();
        }));
        break;
      case NavigationItem.contact_us:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ContactUsScreen();
        }));
        break;
      case NavigationItem.video:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MenuCategorizedVideosScreen();
        }));
        break;
      case NavigationItem.language:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChangeLanguageScreen();
        }));
        break;
      default:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Container();
        }));
        break;

    }
  }

  signOut() async {
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    if (context != null) {
      state = BaseState(data: [], isLoading: true);
      var result =
          await ProviderScope.containerOf(context,
              listen: false).read(di.userViewModelProvider.notifier).userSignOut();
      state = BaseState(data: [], isLoading: false);
      if (result?.errorType == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return MainBottomAppBar();
        }));
        // context.read(di.contentProvider).state =
        //     DrawerItemType.loginScreen.index;
      } else {
        handleError(
            errorType: result?.errorType,
            errorMessage: result?.errorMessage,
            keyValueErrors: result?.keyValueErrors);
      }
    }
  }
}
