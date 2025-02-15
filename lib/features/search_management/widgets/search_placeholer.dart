import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: AppColors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/images/search.png"),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomText(
                  title: "str_search_note".tr(),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
