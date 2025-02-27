import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/screens/edit_profile_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/send_message_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';
import '../entities/navigation_item.dart';
import '../view_models/navigation_view_model.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  NavigationDrawerState createState() {
    // TODO: implement createState
    return NavigationDrawerState();
  }
}

class NavigationDrawerState extends State<NavigationDrawer> with BaseViewModel {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  late bool userIsLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        var modelView =
            ref.watch(di.navigationDrawerViewModelProvider.notifier);
        userIsLoggedIn =
            ref.watch(di.userViewModelProvider.notifier).isUserLoggedIn();
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Drawer(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: AppColors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height * 1.5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(35, 15, 0, 35),
                            child: CustomText(
                              title: "str_more".tr(),
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_support'.tr(),
                              KatkootELWadyIcons.support,
                              NavigationItem.support,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_where_us'.tr(),
                              KatkootELWadyIcons.location_address,
                              NavigationItem.where_to_find_us,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_received_messages'.tr(),
                              KatkootELWadyIcons.message_2,
                              NavigationItem.received_messages,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_contact_us'.tr(),
                              KatkootELWadyIcons.conatctus,
                              NavigationItem.contact_us,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_video'.tr(),
                              KatkootELWadyIcons.video,
                              NavigationItem.video,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              'str_language'.tr(),
                              KatkootELWadyIcons.language,
                              NavigationItem.language,
                              modelView),
                          buildMenuDivider(),
                          buildMenuItem(
                              context,
                              !userIsLoggedIn
                                  ? 'login'.tr()
                                  : 'str_sign_out'.tr(),
                              !userIsLoggedIn
                                  ? KatkootELWadyIcons.signout
                                  : KatkootELWadyIcons.signout,
                              NavigationItem.none,
                              modelView,
                              isAuth: true),
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer(
                  builder: (_, watch, __) {
                    return ScreenHandler(
                      screenProvider: di.navigationDrawerViewModelProvider,
                      noDataMessage: "str_no_data".tr(),
                      onDeviceReconnected: () {},
                      noDataWidget: NoDataWidget(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItem(BuildContext context, String title, IconData icon,
      NavigationItem navigationItem, NavigationViewModel modelView,
      {bool isAuth = false}) {
    final textColor = AppColors.Liver;
    return Material(
      color: Colors.transparent,
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          leading: Icon(
            icon,
            color: isAuth ? AppColors.Olive_Drab : textColor,
            size: 25,
            // size: 50,
          ),
          title: CustomText(
            title: title,
            textColor: isAuth ? AppColors.Olive_Drab : textColor,
            textOverflow: TextOverflow.ellipsis,
          ),
          trailing: RotatedBox(
            quarterTurns: 2,
            child: Icon(Icons.arrow_back_ios, color: AppColors.Manatee),
          ),
          onTap: () {
            if (isAuth) {
              if (!userIsLoggedIn) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              } else {
                modelView.signOut();
              }
            } else {
              if (!userIsLoggedIn) {
                if (navigationItem == NavigationItem.support) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen(
                      nextRoute: MaterialPageRoute(
                          builder: (context) => SendSupportMessageScreen()),
                    );
                  }));
                } else {
                  modelView.redirectToScreen(context, navigationItem);
                }
              } else {
                modelView.redirectToScreen(context, navigationItem);
              }
            }
          }),
    );
  }

  Widget buildMenuDivider() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Divider(
        thickness: 1,
        height: 1,
        color: AppColors.Manatee,
      ),
    );
  }
}
