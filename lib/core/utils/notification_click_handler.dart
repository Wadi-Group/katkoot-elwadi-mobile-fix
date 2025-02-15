import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/guides_management/screens/video_player_youtube_iframe_screen.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/pdf_viewer_widget.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/messages_management/screens/message_content_screen.dart';
import '../di/injection_container.dart' as di;
import 'package:url_launcher/url_launcher.dart';

class NotificationClickHandler {
  static void handleNotificationRedirection(
      Message notification, BuildContext context) async {
    print("in handler ${notification.attachmentType}");
    if (notification.attachmentType == "Tool") {
      var toolsViewModel = ProviderScope.containerOf(context,
          listen: false).read(di.toolsViewModelProvider.notifier);
      if (notification.tool != null && notification.category != null) {
        toolsViewModel.openToolDetails(
            context,
            notification.tool!,
            notification.category!,
            int.tryParse(notification.attachmentId!) ?? 1);
      }
    }
    else if (notification.attachmentType == "Guide" ||
        notification.attachmentType == "PDF") {
      AppConstants.navigatorKey.currentState?.pushNamed(PdfViewer.routeName,
          arguments: [notification.attachment, notification.attachmentPrint]);
    } else if (notification.attachmentType == "Viedo") {
      AppConstants.navigatorKey.currentState?.pushNamed(VideoPlayerYouTubeIframeScreen.routeName,
          arguments: Url(
              url: notification.attachment,
              provider: notification.attachment!.contains("youtube")
                  ? AppConstants.YOUTUBE_PROVIDER
                  : ""));
    } else if (notification.attachmentType == "External URL") {
      var url = notification.attachment;
      if (await canLaunch(url ?? ""))
        await launch(url!);
      else
        throw "Could not launch $url";
    }
  }

  static void redirectToMessageContentScreen(Message notification) {
    AppConstants.navigatorKey.currentState
        ?.pushNamed(MessageContentScreen.routeName, arguments: notification);
  }
}
