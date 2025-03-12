import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/api/api_urls.dart';

import '../../../core/constants/app_colors.dart';
import '../../app_base/widgets/active_button.dart';
import '../../app_base/widgets/custom_text.dart';

void showInAppMessage(
    Map<String, dynamic> inAppMessageData, BuildContext context) {
  if (inAppMessageData.isNotEmpty) {
    var message = inAppMessageData['title'] ?? '';
    var imageUrl = inAppMessageData['image'] ?? '';

    if (message.isNotEmpty && imageUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  decoration: BoxDecoration(
                      color: AppColors.LIGHT_BACKGROUND,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          title: message,
                          textColor: AppColors.APP_BLUE,
                          fontWeight: FontWeight.bold,
                          maxLines: 5,
                          fontSize: 30),
                      SizedBox(height: 30),
                      Image.network(
                        "${ApiUrls.IMAGE_BASE_URL}$imageUrl",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 30),
                      CustomElevatedButton(
                        title: "str_more".tr(),
                        onPressed: () {},
                        backgroundColor: AppColors.APP_BLUE,
                        textColor: AppColors.white,
                        radiusCorners: 30,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          )),
                      child: Icon(
                        Icons.close,
                        size: 25,
                        color: AppColors.APP_BLUE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
