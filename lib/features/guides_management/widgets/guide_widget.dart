import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:easy_localization/easy_localization.dart';

class GuideWidget extends StatelessWidget {
  Guide guide;
  Function onPressed;
  GuideWidget({required this.guide, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 10, start: 15, end: 10),
          child: Center(
            child: Padding(
                padding: EdgeInsetsDirectional.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomText(
                    //   title: "str_tab_guides_topics".tr(),
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    CustomText(
                      maxLines: 2,
                      title: "${guide.title}",
                      textColor: AppColors.Liver,
                      fontSize: 18,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child:  CustomText(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 0, left: 0),
                                fontSize: 14,
                                textColor: AppColors.Dark_spring_green,
                                title: guide.parentTitle ?? ""
                              // "str_tab_guides_topic".tr() + guide.id.toString()
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // padding: EdgeInsets.only(right: 5,left: 5),
                              child: Icon(
                                KatkootELWadyIcons.topics,
                                color: AppColors.Dark_spring_green,
                              ),
                            ),
                          ),
                        ]),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
