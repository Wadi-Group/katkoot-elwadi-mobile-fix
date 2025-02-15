import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

import 'custom_text.dart';

class ConfirmationDialog {
  static Future show({
    required BuildContext context,
    String? title,
    Color titleColor = AppColors.Dark_spring_green,
    String? message,
    Color messageColor= AppColors.Liver,
    String? confirmText,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign  textAlign = TextAlign.center,
    EdgeInsetsGeometry? padding,
    String? fontFamily,
    double fontSize  = 16,
    double? btnRadiusCorners,
    Color confirmTextBgColor = AppColors.Olive_Drab,
    Color confirmTextColor = AppColors.white,
    String? cancelText,
    Color cancelTextBgColor = AppColors.outer_space,
    Color cancelTextColor = AppColors.white,
    Function? onConfirm,
    Function? onCancel
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            child: Dialog(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),


                  padding: EdgeInsetsDirectional.all(30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(title != null)
                        CustomText(
                            title: title,
                            textAlign: TextAlign.center,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            textColor: titleColor ,
                            padding: EdgeInsetsDirectional.only(bottom: 10)),

                      SizedBox(
                        height: 10,
                      ),
                      if(message != null)
                        CustomText(
                            title: message,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textColor: messageColor,
                            padding: EdgeInsetsDirectional.only(bottom: 20)),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(confirmText != null && onConfirm != null)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  onConfirm();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(btnRadiusCorners ?? 0)),
                                      color: confirmTextBgColor),

                                  child: CustomText(
                                    title: confirmText,
                                    textAlign: textAlign,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                    textColor: confirmTextColor,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(width: 30,),
                          if(cancelText != null)
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(btnRadiusCorners ?? 0)),
                                      color: cancelTextBgColor),
                                  child: CustomText(
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    title: cancelText,
                                    textAlign: TextAlign.center,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight ,
                                    textColor: cancelTextColor,
                                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                                  ),
                                ),
                              ),
                            ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
            ),
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
          );
        });
  }
}