import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/user_management/models/unseen_notification_count_data.dart';

class UnseenNotificationCountViewModel extends StateNotifier<int> with BaseViewModel {
  Repository repository;

  UnseenNotificationCountViewModel(this.repository) : super(0);

  resetLocalUnseenNotificationCount(){
    state = 0;
    repository.saveUnseenNotificationCount(0);
  }

  setLocalUnseenNotificationCount(int unseenNotificationCount) async {
    state = unseenNotificationCount;
    repository.saveUnseenNotificationCount(unseenNotificationCount);
    if(await FlutterAppBadger.isAppBadgeSupported()){
      FlutterAppBadger.updateBadgeCount(unseenNotificationCount);
    }
  }

  Future<int> getUnseenNotificationCount() async {
    int unseenNotificationCount = await repository.unseenNotificationCount();
    state = unseenNotificationCount;
    return unseenNotificationCount;
  }

  Future getRemoteUnseenNotificationCount() async {
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    if(context != null){
      bool userIsLoggedIn =
      ProviderScope.containerOf(context,
          listen: false).read(di.userViewModelProvider.notifier).isUserLoggedIn();

      BaseApiResult<UnseenNotificationCountData?>? result;
      if (userIsLoggedIn) {
        result = await repository.remoteUnseenNotificationCount();
      } else {
        var deviceState = await repository.getOnesignalDeviceState();
        var installedAt = await repository.installedAtTime();
        if(deviceState?.userId != null){
          result = await repository.remoteUnseenNotificationCount(deviceId: deviceState?.userId, installedAt: installedAt);
        }
      }
      if(result != null){
        int notificationNotSeenCount;
        if (result.data != null) {
          notificationNotSeenCount = result.data?.unseenCount ?? 0;
          setLocalUnseenNotificationCount(notificationNotSeenCount);

          var user = ProviderScope.containerOf(context,
              listen: false).read(di.userViewModelProvider);
          if (user?.user != null) {
            user?.notificationNotSeenCount = notificationNotSeenCount;
            ProviderScope.containerOf(context,
                listen: false).read(di.userViewModelProvider.notifier).setLocalUserData(user);
          }
        } else {
          if (result.errorType == ErrorType.UNAUTHORIZED_ERROR){
            handleError(
                errorType: result.errorType,
                errorMessage: result.errorMessage,
                keyValueErrors: result.keyValueErrors);
          }

        }
      }
    }

  }
}
