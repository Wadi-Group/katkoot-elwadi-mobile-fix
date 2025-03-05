import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/screens/onboarding_screen.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';

import 'main_bottom_app_bar.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "./splash_screen";

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> with BaseViewModel {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () async {
      if (!di.appRedirectedFromNotificationNotifier.value) {
        if (await ProviderScope.containerOf(context, listen: false)
            .read(di.changeLanguageViewModelProvider.notifier)
            .isOnBoardingComplete()) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return MainBottomAppBar();
          }));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return OnboardingScreen();
          }));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
