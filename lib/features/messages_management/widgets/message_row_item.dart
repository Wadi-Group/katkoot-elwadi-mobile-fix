import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'dart:ui' as dart_ui;

class MessageRowItem extends StatelessWidget {
  Message message;
  MessageRowItem({required this.message});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                CustomText(
                  title: formatMessageDate(message.date),
                  fontSize: 16,
                  textColor: AppColors.APP_BLUE,
                  fontWeight: FontWeight.w500,
                  padding: EdgeInsetsDirectional.only(start: 20),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CustomText(
                title: message.content ?? '',
                fontSize: 16,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                textColor: AppColors.APP_BLUE,
                fontWeight: FontWeight.w500,
              ),
            )
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
  } else if (difference.inDays == 1) {
    return tr("yesterday");
  } else {
    return DateFormat('yyyy-MM-dd hh:mm a')
        .format(dateTime); // Show full date & time
  }
}
