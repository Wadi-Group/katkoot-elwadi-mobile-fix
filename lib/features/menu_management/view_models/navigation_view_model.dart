import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/screens/categorized_videos_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/contact_us_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/where_to_find_us_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/send_message_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../entities/navigation_item.dart';
import '../screens/about_us_screen.dart';

class NavigationViewModel extends StateNotifier<BaseState> with BaseViewModel {
  Repository _repository;

  NavigationViewModel(this._repository)
      : super(BaseState(data: NavigationItem.home));

  redirectToScreen(BuildContext context, NavigationItem item) {
    switch (item) {
      case NavigationItem.about_us:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AboutUsScreen();
        }));
        break;
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
      case NavigationItem.share_app:
        shareApp();
        break;
      default:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Container();
        }));
        break;
    }
  }

  Future shareApp() async {
    Share.share(
        'Check out Katkoot Alwadi App \n android app: https://play.google.com/store/apps/details?id=com.katkootalwadi.katkootalwadi&hl=en&pli=1 \n ios app: https://apps.apple.com/us/app/katkoot-alwadi/id1578085679');
  }

  signOut() async {
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    if (context != null) {
      state = BaseState(data: [], isLoading: true);
      var result = await ProviderScope.containerOf(context, listen: false)
          .read(di.userViewModelProvider.notifier)
          .userSignOut();
      await ProviderScope.containerOf(context, listen: false)
          .read(di.messagesViewModelProvider.notifier)
          .getMessages(context, refresh: true, showLoading: true);

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
