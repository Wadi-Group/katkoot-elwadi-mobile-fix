import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';

import 'file_row_item.dart';

class TopicRowItem extends StatelessWidget {
  final Topic topic;
  final Function previewPdf;
  const TopicRowItem({required this.topic,required this.previewPdf}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(2),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.Tea_green,
              ),
              color: AppColors.Tea_green,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: CustomText(
            padding: EdgeInsets.all(5),
            textAlign: TextAlign.center,
            title: "${topic.title}",
            textColor: AppColors.Dark_spring_green,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        if(topic.guides != null && topic.guides!.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: topic.guides?.length,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.only(top:10),

                  child: FileRowItem(onTap: previewPdf ,guide: topic.guides != null ? topic.guides![index] : new Guide())
              ),
            ),
          ),
      ],
    );
  }
}
