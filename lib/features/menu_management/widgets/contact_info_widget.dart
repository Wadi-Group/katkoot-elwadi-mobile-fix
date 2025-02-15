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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.04
                        : MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.04
                        : MediaQuery.of(context).size.height * 0.1,
                    child: hasIcon
                        ? mode == ContactMode.SOCIAL_LINK
                            ? Icon(
                                getIconFroSocialName() != null
                                    ? getIconFroSocialName()
                                    : KatkootELWadyIcons.website,
                                size: 35,
                                color: AppColors.Dark_spring_green,
                              )
                            : mode == ContactMode.PHONE
                                ? Icon(
                                    KatkootELWadyIcons.phone_1,
                                    size: 35,
                                    color: AppColors.Dark_spring_green,
                                  )
                                : Icon(
                                    KatkootELWadyIcons.address_1,
                                    size: 35,
                                    color: AppColors.Dark_spring_green,
                                  )
                        : Container(),
                  ),
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
                          title: title,
                          // maxLines: 2,
                          textColor: AppColors.Liver,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        )),
                    flex: 4),
                Expanded(
                  child: Container(
                    child: hasIcon
                        ? Icon(
                            Icons.chevron_right_outlined,
                            color: AppColors.Platinum,
                            size: MediaQuery.of(context).size.height * 0.05,
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
                height: 3,
                color: AppColors.Platinum,
              )
          ],
        ),
      ),
    );
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
