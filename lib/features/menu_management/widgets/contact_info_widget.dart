import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';

class ContactUsInfoWidget extends StatelessWidget {
  String title;
  String? SocialName;
  Function()? onTap;
  bool hasIcon;
  int? index;
  bool hasUnderlineBorder;
  ContactMode? mode;
  ContactUsInfoWidget(
      {required this.title,
      this.SocialName,
      required this.onTap,
      this.mode,
      this.index,
      required this.hasIcon,
      required this.hasUnderlineBorder});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          top: mode == ContactMode.PHONE && index != 0 ? 0 : 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.03
                          : MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.04
                          : MediaQuery.of(context).size.height * 0.1,
                      child: mode == ContactMode.SOCIAL_LINK
                          ? Image.asset(
                              "assets/images/${SocialName!.toLowerCase()}.png",
                              color: AppColors.APP_BLUE,
                            )
                          : mode == ContactMode.PHONE
                              ? Image.asset(
                                  "assets/images/contact_us.png",
                                  color: AppColors.APP_BLUE,
                                )
                              : mode == ContactMode.ADDRESS
                                  ? Image.asset(
                                      "assets/images/sales.png",
                                      color: AppColors.APP_BLUE,
                                    )
                                  : Image.asset(
                                      "assets/images/language.png",
                                      color: AppColors.APP_BLUE,
                                    )),
                  flex: 1,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsetsDirectional.only(
                            start: 10,
                            top: mode == ContactMode.SOCIAL_LINK
                                ? 5
                                : (mode == ContactMode.PHONE &&
                                        index != null &&
                                        index == 0)
                                    ? 5
                                    : 0),
                        child: CustomText(
                          textAlign: TextAlign.start,
                          title: getTitle(title),
                          // maxLines: 2,
                          textColor: AppColors.APP_BLUE,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        )),
                    flex: 4),
                Expanded(
                  child: Container(
                    child: hasIcon
                        ? Icon(
                            Icons.chevron_right_outlined,
                            color: AppColors.APP_BLUE,
                            size: MediaQuery.of(context).size.height * 0.04,
                          )
                        : Container(),
                  ),
                  flex: 1,
                ),
              ],
            ),
            SizedBox(
              height: mode == ContactMode.PHONE && index != 0 ? 0 : 10,
            ),
            if (hasUnderlineBorder)
              Container(
                height: 1,
                color: AppColors.APP_BLUE,
              )
          ],
        ),
      ),
    );
  }

  String getTitle(String title) {
    switch (title) {
      case "Facebook":
        return "facebook".tr();
      case "Linkedin":
        return "linkedin".tr();
      case "Website":
        return "website".tr();
      case "Youtube":
        return "youtube".tr();
      case "email":
        return "Email";
      case "instagram":
        return "Instagram";
      case "address":
        return "Address";
      case "phone":
        return "Phone";
      default:
        return title;
    }
  }

  IconData? getIconFroSocialName() {
    IconData? iconData;
    switch (SocialName) {
      case "facebook":
        iconData = KatkootELWadyIcons.facebook_1;
        break;
      case "linkedin":
        iconData = KatkootELWadyIcons.linked;
        break;

      case "website":
        iconData = KatkootELWadyIcons.website;
        break;

      case "youtube":
        iconData = KatkootELWadyIcons.youtube_1;
        break;

      case "email":
        iconData = KatkootELWadyIcons.email;
        break;

      case "instagram":
        iconData = KatkootELWadyIcons.instagram;
        break;

      default:
    }

    return iconData;
  }
}
