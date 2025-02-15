import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';

import 'main_bottom_app_bar.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "./splash_screen";

  @override
  _SplashScreenState createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> with BaseViewModel {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () async {
      if (!di.appRedirectedFromNotificationNotifier.value) {
        if (await ProviderScope.containerOf(context,
            listen: false)
            .read(di.changeLanguageViewModelProvider.notifier)
            .isOnBoardingComplete()) {
          // navigateToScreen(HomeScreen.routeName, removeTop: true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_){
                return MainBottomAppBar();
              }));
          //navigateToScreen(MainBottomAppBar.routeName, replace: true);
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_){
                return ChangeLanguageScreen();
              }));
          //navigateToScreen(ChangeLanguageScreen.routeName, replace: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.SPLASH_GREEN,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: AppColors.SPLASH_GREEN,
              image: DecorationImage(
                  image: AssetImage('assets/images/screen-splash.gif'),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
