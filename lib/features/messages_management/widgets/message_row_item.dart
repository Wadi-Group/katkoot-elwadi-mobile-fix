import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'dart:ui' as dart_ui;

import '../../../core/utils/notification_click_handler.dart';

class MessageRowItem extends StatelessWidget {
  final Message message;

  MessageRowItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the left
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    title: message.title ?? '',
                    fontSize: 16,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textColor: AppColors.APP_BLUE,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Align date to the right
                  children: [
                    CustomText(
                      title: formatMessageDate(message.date),
                      fontSize: 14,
                      textColor: AppColors.HINT_GREY,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CustomText(
                title: message.content ?? '',
                fontSize: 14,
                maxLines: 5,
                textOverflow: TextOverflow.ellipsis,
                textColor: AppColors.DARK_GREY,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (message.attachment != null && message.attachment!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () {
                    NotificationClickHandler.handleNotificationRedirection(
                        message, context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.APP_BLUE.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.APP_BLUE, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attachment,
                            color: AppColors.APP_BLUE, size: 20),
                        SizedBox(width: 6),
                        CustomText(
                          title: tr("attachment"),
                          fontSize: 14,
                          textColor: AppColors.APP_BLUE,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String formatMessageDate(DateTime? dateTime) {
  if (dateTime == null) return ''; // Handle null values

  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    if (difference.inHours > 0) {
      return tr("hours_ago", args: [difference.inHours.toString()]);
    } else if (difference.inMinutes > 0) {
      return tr("minutes_ago", args: [difference.inMinutes.toString()]);
    } else {
      return tr("just_now");
    }
  } else if (difference.inHours == 1) {
    return tr("yesterday");
  } else {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }
}
