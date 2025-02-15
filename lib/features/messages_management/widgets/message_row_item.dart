import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/messages_management/screens/message_content_screen.dart';

class MessageRowItem extends StatelessWidget {
  Message message;
  MessageRowItem({required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  textColor: AppColors.Dark_spring_green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomText(
                title: message.schedule ?? '',
                fontSize: 16,
                textColor: AppColors.DARK_GREY,
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
              textColor: AppColors.Liver,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
