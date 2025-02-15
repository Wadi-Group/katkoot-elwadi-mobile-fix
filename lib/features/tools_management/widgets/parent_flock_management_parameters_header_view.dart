import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class ParentFlockManagementParametersHeaderView extends StatelessWidget {
  final Function()? onEraseAllClick;

  ParentFlockManagementParametersHeaderView({required this.onEraseAllClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30,right: 30,top: 50,bottom: 25),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: ()=> Navigator.of(context).pop(),
                  color: AppColors.Ash_grey,
                  icon: Icon(Icons.close,size: 25,)
              ),
              GestureDetector(
                child: CustomText(
                  title: 'reset_all'.tr(),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  underline: true,
                  fontSize: 16,
                ),
                onTap: onEraseAllClick,
              )
            ],
          ),
          SizedBox(height: 10,),
          CustomText(title: 'parameters'.tr(),fontSize: 20,fontWeight: FontWeight.bold,)
        ],
      ),
    );
  }

}