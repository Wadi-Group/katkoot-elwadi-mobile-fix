import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:katkoot_elwady/core/api/api_urls.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/utils/notification_click_handler.dart';
import 'package:katkoot_elwady/core/utils/route_generator.dart';
import 'package:katkoot_elwady/features/app_base/screens/splash_screen.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import '../di/injection_container.dart' as di;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationManager {
  static void initOneSignal() async {
    print('_initOneSignal');
    OneSignal.shared.setAppId(AppConstants.ONESIGNAL_APP_ID);

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Display Notification, send null to not display, send notification to display
      event.complete(event.notification);
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent notification) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      print("current route ${RouteGenerator.getCurrentRoute()}");
      print(notification.notification.additionalData);
      if (RouteGenerator.getCurrentRoute() == MessagesListScreen.routeName) {
        ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
                listen: false)
            .read(di.messagesViewModelProvider.notifier)
            .getMessages(AppConstants.navigatorKey.currentContext!,
                refresh: true);
      }
      notification.complete(notification.notification);

      BuildContext? context = AppConstants.navigatorKey.currentContext;

      if (context != null) {
        int notificationNotSeenCount =
            ProviderScope.containerOf(context, listen: false)
                    .read(di.unseenNotificationCountProvider) ??
                0;

        ProviderScope.containerOf(context, listen: false)
            .read(di.unseenNotificationCountProvider.notifier)
            .setLocalUnseenNotificationCount(notificationNotSeenCount + 1);
      }
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('notification is opened');

      Map<String, dynamic>? rawPayload = result.notification.additionalData;
      print('notfiy data is : $rawPayload');

      if (rawPayload != null) {
        Future.delayed(const Duration(milliseconds: 3000), () {
          Message notificationModel = Message.fromJson(rawPayload);
          print("model");
          print(notificationModel.attachmentType);

          if (RouteGenerator.getCurrentRoute() == null ||
              RouteGenerator.getCurrentRoute() == SplashScreen.routeName) {
            di.appRedirectedFromNotificationNotifier.value = true;
          }

          if (notificationModel.attachmentType == "Guide" ||
              notificationModel.attachmentType == "PDF") {
            NotificationClickHandler.handleNotificationRedirection(
                notificationModel, AppConstants.navigatorKey.currentContext!);
          } else {
            NotificationClickHandler.redirectToMessageContentScreen(
              notificationModel,
            );
          }
        });
      }
    });

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((value) {
      print('NotificationPermission: ' + value.toString());
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
      print('playerId: ' + changes.jsonRepresentation());
    });
    var state = await NotificationManager.getDeviceState();
    print(" the push token ${state?.userId}");
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    if (context != null) {
      ProviderScope.containerOf(context, listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .getRemoteUnseenNotificationCount();
    }
  }

  static Future<OSDeviceState?> getDeviceState() async {
    return await OneSignal.shared.getDeviceState();
  }
}
