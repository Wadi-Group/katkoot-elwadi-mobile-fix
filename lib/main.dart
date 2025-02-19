import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_app_links/flutter_facebook_app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/notification_manager.dart';
import 'package:katkoot_elwady/core/utils/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

import 'core/services/local/shared_preferences_service.dart';
import 'features/app_base/screens/splash_screen.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  NotificationManager.initOneSignal();

  runApp(ProviderScope(
    overrides: [
      di.sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(await SharedPreferences.getInstance()),
      ),
    ],
    child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [Locale('en'), Locale('ar')],
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        child: MyApp()),
  ));
}

/// FB Deferred Deeplinks
// void initFBDeferredDeeplinks() async {
//
//   String deepLinkUrl;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//
//     deepLinkUrl = await FlutterFacebookAppLinks.initFBLinks();
//     if(Platform.isIOS)
//       deepLinkUrl = await FlutterFacebookAppLinks.getDeepLink();
//
//     /// do what you need with the deeplink...
//     /// ...
//   }finally{
//     /// in case of error...
//   }
// }

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  // FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.DARK_SPRING_GREEN));
    List<LocalizationsDelegate> localizationsDelegateList =
        context.localizationDelegates;
    localizationsDelegateList.add(CountryLocalizations.delegate);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegateList,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'katkot al wadi',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
                fontFamily:
                    context.locale.toString() == 'en' ? "Arial" : "GE_SS_Two")),
        primarySwatch: Colors.orange,
        fontFamily: context.locale.toString() == 'en' ? "Arial" : "GE_SS_Two",
      ),
      navigatorKey: AppConstants.navigatorKey,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (_) => RouteGenerator.generateRoute(_, context),
    );
  }
}
