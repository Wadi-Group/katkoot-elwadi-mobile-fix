import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';

class FileRowItem extends StatelessWidget {
  final Guide guide;
  final Function onTap;

  const FileRowItem({required this.guide, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(guide.filePath, guide.printFilePath),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
            ),
            boxShadow: [
              new BoxShadow(
                color: AppColors.SHADOW_GREY,
                blurRadius: 5.0,
              ),
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 6,
            child: CustomText(
              maxLines: 2,
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
              title: "${guide.title}",
              textColor: AppColors.Liver,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Expanded(
            flex: 1,
            child: Container(
              // padding: EdgeInsets.only(right: 5,left: 5),
              child: Icon(
                KatkootELWadyIcons.topics,
                color: AppColors.SHADOW_GREY,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
