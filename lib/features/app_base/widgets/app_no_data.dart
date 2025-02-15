import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

import 'custom_text.dart';

class AppNoData extends StatelessWidget {
  final bool show;
  final String msg;
  final Widget? noDataView;

  AppNoData({this.show = false, this.msg = "", this.noDataView});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !show,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: noDataView != null
              ? noDataView
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: msg,
                      fontSize: 18,
                      textColor: AppColors.APPLE_GREEN.withOpacity(0.4),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: ImageIcon(
                AssetImage("assets/images/ic_empty_data.png"),
                size: 125,
                color: AppColors.Tea_green,
              ),
            ),
            CustomText(
              title: "str_no_data".tr(),
              fontSize: 17,
              textColor: AppColors.APPLE_GREEN,
            ),
          ],
        ),
      ),
    );
  }
}
