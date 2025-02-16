import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

import '../../menu_management/entities/navigation_item.dart';
import '../../menu_management/view_models/navigation_view_model.dart';
import '../../messages_management/screens/send_message_screen.dart';
import '../../user_management/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  late bool userIsLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      child: Consumer(
        builder: (_, ref, __) {
          var modelView =
              ref.watch(di.navigationDrawerViewModelProvider.notifier);
          userIsLoggedIn =
              ref.watch(di.userViewModelProvider.notifier).isUserLoggedIn();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: CustomText(
                  title: "more".tr(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.APP_BLUE,
                ),
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/about_us.png",
                title: 'about_us'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.about_us,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/ask_for_advice.png",
                title: 'ask_for_advice'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.ask_for_advice,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/sales.png",
                title: 'sales_and_customer_support'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.support,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/received_message.png",
                title: 'received_messages'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.received_messages,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/contact_us.png",
                title: 'contact_us'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.contact_us,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/videos.png",
                title: 'videos'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.video,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/share_app.png",
                title: 'share_app'.tr(),
                modelView: modelView,
                navigationItem: NavigationItem.none,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/language.png",
                title: 'language'.tr(),
                navigationItem: NavigationItem.language,
                modelView: modelView,
              ),
              _buildDrawerItem(
                context,
                icon: "assets/images/login.png",
                title: !userIsLoggedIn ? 'login'.tr() : 'str_sign_out'.tr(),
                isAuth: true,
                navigationItem: NavigationItem.none,
                modelView: modelView,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String icon,
      required String title,
      NavigationItem? navigationItem,
      NavigationViewModel? modelView,
      bool isAuth = false}) {
    return Column(
      children: [
        ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                icon,
                color: title == 'login'.tr()
                    ? AppColors.APPLE_GREEN
                    : AppColors.APP_BLUE,
                width: 25,
                height: 25,
              ),
            ),
            title: CustomText(
              title: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textColor: title == 'login'.tr()
                  ? AppColors.APPLE_GREEN
                  : AppColors.APP_BLUE,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.APP_BLUE,
            ),
            onTap: () {
              if (isAuth) {
                if (!userIsLoggedIn) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                } else {
                  modelView?.signOut();
                }
              } else {
                if (!userIsLoggedIn) {
                  if (navigationItem == NavigationItem.support) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen(
                        nextRoute: MaterialPageRoute(
                            builder: (context) => SendSupportMessageScreen()),
                      );
                    }));
                  } else {
                    modelView?.redirectToScreen(context, navigationItem!);
                  }
                } else {
                  modelView?.redirectToScreen(context, navigationItem!);
                }
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: .5,
            height: 10,
            color: AppColors.APP_BLUE,
          ),
        ),
      ],
    );
  }
}
