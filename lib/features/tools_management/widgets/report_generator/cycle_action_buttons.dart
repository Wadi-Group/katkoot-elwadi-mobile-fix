import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:easy_localization/easy_localization.dart';

class CycleActionButtons extends StatelessWidget {
  final String? submitButtonTitle,cancelButtonTitle;
  final Function? onSubmit,onCancel;

  const CycleActionButtons({
    this.submitButtonTitle,
    this.cancelButtonTitle,
    this.onSubmit,
    this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomElevatedButton(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  title: submitButtonTitle ?? '',
                  textColor: AppColors.white,
                  backgroundColor: AppColors.Olive_Drab,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  onPressed: onSubmit ?? (){}
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
                child: Container(
                  child: CustomElevatedButton(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      title: cancelButtonTitle ?? 'str_cancel'.tr(),
                      textColor: AppColors.white,
                      backgroundColor: AppColors.calc_bef_btn,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      onPressed: onCancel ?? (){}
                  ),
                )),
          ]),
    );
  }
}