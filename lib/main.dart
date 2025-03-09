import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_app_links/flutter_facebook_app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/core/services/remote/api_services.dart';
import 'package:katkoot_elwady/core/utils/notification_manager.dart';
import 'package:katkoot_elwady/core/utils/route_generator.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/broiler_livability.dart';
import 'package:katkoot_elwady/features/tools_management/models/broiler_per_week.dart';
import 'package:katkoot_elwady/features/tools_management/models/equation.dart';
import 'package:katkoot_elwady/features/tools_management/models/hatch.dart';
import 'package:katkoot_elwady/features/tools_management/models/hatching_hen.dart';
import 'package:katkoot_elwady/features/tools_management/models/pullet_livability_to_cap.dart';
import 'package:katkoot_elwady/features/tools_management/models/pullets.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/measurement_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/slider_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool_section.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/add_week_data_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/create_cycle_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/edit_week_data_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/manage_cycle_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/services/local/shared_preferences_service.dart';
import 'core/services/repository.dart';
import 'core/utils/check_internet_connection.dart';
import 'features/app_base/screens/splash_screen.dart';
import 'features/category_management/models/category.dart';
import 'features/guides_management/models/video.dart';
import 'features/tools_management/models/broiler.dart';
import 'features/tools_management/models/defaults.dart';
import 'features/tools_management/models/equations.dart';
import 'features/tools_management/models/equations_result_title.dart';
import 'features/tools_management/models/fcr.dart';
import 'features/tools_management/models/pef.dart';
import 'features/tools_management/models/pullet.dart';
import 'features/tools_management/models/report_generator/week_data_value.dart';
import 'features/tools_management/models/report_generator/week_data_value_params.dart';
import 'features/tools_management/models/report_generator/week_preview_data.dart';
import 'features/tools_management/models/tool.dart';

//   hive init and register adapters
Future<void> initHive() async {
  await Hive.initFlutter();
  // Register Adapters
  Hive.registerAdapter(ToolAdapter());
  Hive.registerAdapter(BroilerAdapter());
  Hive.registerAdapter(FcrAdapter());
  Hive.registerAdapter(PefAdapter());
  Hive.registerAdapter(DefaultsAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(VideoAdapter());
  Hive.registerAdapter(EquationsAdapter());
  Hive.registerAdapter(EquationAdapter());
  Hive.registerAdapter(EquationsResultTitleAdapter());
  Hive.registerAdapter(BroilerLivabilityAdapter());
  Hive.registerAdapter(BroilerPerWeekAdapter());
  Hive.registerAdapter(HatchAdapter());
  Hive.registerAdapter(HatchingHenAdapter());
  Hive.registerAdapter(PulletAdapter());
  Hive.registerAdapter(PulletLivabilityToCapAdapter());
  Hive.registerAdapter(PulletsAdapter());
  Hive.registerAdapter(ToolDataAdapter());
  Hive.registerAdapter(ToolSectionAdapter());
  Hive.registerAdapter(SliderDataAdapter());
  Hive.registerAdapter(CycleAdapter());
  Hive.registerAdapter(WeekDataAdapter());
  Hive.registerAdapter(CreateCycleAdapter());
  Hive.registerAdapter(ValueAdapter());
  Hive.registerAdapter(ParamsAdapter());
  Hive.registerAdapter(PreviewDataAdapter());
  Hive.registerAdapter(MeasurementDataAdapter());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(await buildApp());
}

Future<void> initializeApp() async {
  try {
    await initHive(); // Initialize Hive storage

    // Initialize shared preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPreferencesService =
        SharedPreferencesService(sharedPreferences);

    // Initialize API service
    final apiService = ApiService();
    final repository = Repository(apiService, sharedPreferencesService);

    // Initialize ViewModels
    final createCycleViewModel = CreateCycleViewModel(repository);
    final addWeekDataViewModel = AddWeekDataViewModel(repository);
    final manageCycleViewModel = ManageCycleViewModel(repository);
    final EditWeekDataViewModel editWeekDataViewModel =
        EditWeekDataViewModel(repository);

    // Initialize connectivity service and sync
    final connectivityService = ConnectivityService(
      createCycleViewModel,
      addWeekDataViewModel,
      manageCycleViewModel,
      editWeekDataViewModel,
    );
    connectivityService.checkConnectivityAndSync();

    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    NotificationManager.initOneSignal();

    // Handle app lifecycle events (dispose connectivity service on app close)
    WidgetsBinding.instance.addObserver(_LifecycleEventHandler(
      onClose: () => connectivityService.dispose(),
    ));
  } catch (e, stackTrace) {
    debugPrint("Error during initialization: $e\n$stackTrace");
  }
}

Future<Widget> buildApp() async {
  return ProviderScope(
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
      child: MyApp(),
    ),
  );
}

class _LifecycleEventHandler extends WidgetsBindingObserver {
  final VoidCallback onClose;

  _LifecycleEventHandler({required this.onClose});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      onClose(); // Dispose resources when the app is closing
    }
  }
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
      initialRoute: SplashScreen.routeName,
      theme: ThemeData(
        useMaterial3: false,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
                fontFamily:
                    context.locale.toString() == 'en' ? "Arial" : "Almarai")),
        primarySwatch: Colors.blueGrey,
        fontFamily: context.locale.toString() == 'en' ? "Arial" : "Almarai",
      ),
      navigatorKey: AppConstants.navigatorKey,
      onGenerateRoute: (_) => RouteGenerator.generateRoute(_, context),
    );
  }
}
