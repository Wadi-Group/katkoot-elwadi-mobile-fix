import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/screens/splash_screen.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/category_management/screens/category_details_base_screen_modification.dart';
import 'package:katkoot_elwady/features/guides_management/screens/faqs_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/topics_screen.dart';
import 'package:katkoot_elwady/features/guides_management/screens/video_player_youtube_iframe_screen.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/pdf_viewer_widget.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/menu_management/screens/categorized_videos_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/edit_profile_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/where_to_find_us_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/contact_us_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/send_message_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:katkoot_elwady/features/category_management/screens/home_screen.dart';
import 'package:katkoot_elwady/features/messages_management/screens/message_content_screen.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/create_new_cycle_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/cycles_list_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/fcr_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/edit_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/edit_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/manage_cycle_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_broiler_flock_requirements_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_broiler_parameters_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_pullets_parameters_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_requirement_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/parent_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/bef_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/add_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/add_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/register_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/verify_phone_screen.dart';
import '../di/injection_container.dart' as di;

class RouteGenerator {
  static RouteSettings? setting;
  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    setting = settings;
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ChangeLanguageScreen.routeName:
        return MaterialPageRoute(builder: (_) => ChangeLanguageScreen());
      case CategoryDetailsBaseScreenModification.routeName:
        return MaterialPageRoute(
            builder: (_) => CategoryDetailsBaseScreenModification(
                category: args as Category));
      case VideoPlayerYouTubeIframeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => VideoPlayerYouTubeIframeScreen(url: args as Url));
      case MenuCategorizedVideosScreen.routeName:
        return MaterialPageRoute(builder: (_) => MenuCategorizedVideosScreen());
      case WhereToFindUsScreen.routeName:
        return MaterialPageRoute(builder: (_) => WhereToFindUsScreen());

      case MainBottomAppBar.routeName:
        return MaterialPageRoute(builder: (_) => MainBottomAppBar());
      case FaqsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => FaqsScreen(category: args as Category));
      case PdfViewer.routeName:
        if (args is List && args.isNotEmpty) {
          String previewUrl = args[0] ?? '';
          String printUrl;
          if (args.length > 1) {
            printUrl = args[1] ?? '';
            if (printUrl.isEmpty) {
              printUrl = previewUrl;
            }
          } else {
            printUrl = previewUrl;
          }
          return MaterialPageRoute(
              builder: (_) =>
                  PdfViewer(previewUrl: previewUrl, printUrl: printUrl));
        }
        return MaterialPageRoute(
            builder: (_) => FaqsScreen(category: args as Category));
      case TopicsScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => TopicsScreen(category: args as Category));
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case VerifyPhoneScreen.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                VerifyPhoneScreen(phoneNumber: args as String, verId: args));
      case ParentStockFlockRequirementScreen.routeName:
        if (args is List<Object>) {
          return MaterialPageRoute(
              builder: (_) => ParentStockFlockRequirementScreen(
                  category: args[0] as Category, toolId: args[1] as int));
        }
        return _errorRoute();

      case CommercialBroilerFlockRequirementsScreen.routeName:
        if (args is CommercialBroilerFlockRequirementsScreenData) {
          return MaterialPageRoute(
              builder: (_) => CommercialBroilerFlockRequirementsScreen(
                    category: args.category,
                    toolId: args.toolId,
                  ));
        }
        return _errorRoute();
      case ParentFlockManagementBroilerParametersScreen.routeName:
        if (args is ParentFlockManagementBroilerParametersScreenData) {
          return MaterialPageRoute(
              builder: (_) => ParentFlockManagementBroilerParametersScreen(
                    screenProvider: args.screenProvider,
                    defaults: args.defaults,
                  ));
        }
        return _errorRoute();
      case ParentFlockManagementPulletsParametersScreen.routeName:
        if (args is ParentFlockManagementPulletsParametersScreenData) {
          return MaterialPageRoute(
              builder: (_) => ParentFlockManagementPulletsParametersScreen(
                    screenProvider: args.screenProvider,
                    defaults: args.defaults,
                  ));
        }
        return _errorRoute();
      case ParentFlockManagementScreen.routeName:
        if (args is ParentFlockManagementScreenData) {
          return MaterialPageRoute(
              builder: (_) => ParentFlockManagementScreen(
                    category: args.category,
                    toolId: args.toolId,
                  ));
        }
        return _errorRoute();
      case SendSupportMessageScreen.routeName:
        return MaterialPageRoute(builder: (_) => SendSupportMessageScreen());
      case MessagesListScreen.routeName:
        return MaterialPageRoute(builder: (_) => MessagesListScreen());
      case EditProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      case ContactUsScreen.routeName:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case MessageContentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => MessageContentScreen(
                  message: args as Message,
                ));
      case BEFScreen.routeName:
        if (args is BEFScreenData) {
          return MaterialPageRoute(
              builder: (_) => BEFScreen(
                    category: args.category,
                    tool: args.tool,
                    fcrValue: args.fcrValue,
                  ));
        }
        return _errorRoute();

      case FCRScreen.routeName:
        if (args is FCRScreenData) {
          return MaterialPageRoute(
              builder: (_) => FCRScreen(
                    category: args.category,
                    tool: args.tool,
                  ));
        }
        return _errorRoute();
      case ParentStockPerformanceObjective.routeName:
        if (args is List<Object>) {
          return MaterialPageRoute(
              builder: (_) => ParentStockPerformanceObjective(
                  category: args[0] as Category, toolId: args[1] as int));
        }
        return _errorRoute();

      case CommercialBroilerPerformanceObjective.routeName:
        if (args is List<Object>) {
          UserData? userData = ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false).read(di.userViewModelProvider);

          if (userData == null) {
            // context.read(di.contentProvider).state =
            //     DrawerItemType.loginScreen.index;
            return MaterialPageRoute(
                builder: (_) => MainBottomAppBar(
                    // redirectionData: RedirectionData(
                    //     redirectionIndexAfterPop: args[2] as int,
                    //     redirectionRouteName: CommercialBroilerPerformanceObjective.routeName,
                    //     arguments: args
                    // )
                    ));
          } else {
            return MaterialPageRoute(
                builder: (_) => CommercialBroilerPerformanceObjective(
                    category: args[0] as Category, toolId: args[1] as int));
          }
        }
        return _errorRoute();

      case CreateNewCycleScreen.routeName:
        if (args is List<Object>) {
          return MaterialPageRoute(
              builder: (_) => CreateNewCycleScreen(
                  category: args[0] as Category, tool: args[1] as Tool));
        }
        return _errorRoute();
      case AddRearingWeekDataScreen.routeName:
        if (args is AddRearingWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => AddRearingWeekDataScreen(
                  cycleId: args.cycleId, weekNumber: args.weekNumber));
        }
        return _errorRoute();
      case AddProductionWeekDataScreen.routeName:
        if (args is AddProductionWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => AddProductionWeekDataScreen(
                  cycleId: args.cycleId, weekNumber: args.weekNumber));
        }
        return _errorRoute();
      case EditRearingWeekDataScreen.routeName:
        if (args is EditRearingWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => EditRearingWeekDataScreen(
                  cycleId: args.cycleId, weekNumber: args.weekNumber));
        }
        return _errorRoute();
      case EditProductionWeekDataScreen.routeName:
        if (args is EditProductionWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => EditProductionWeekDataScreen(
                  cycleId: args.cycleId, weekNumber: args.weekNumber));
        }
        return _errorRoute();
      case ViewRearingWeekDataScreen.routeName:
        if (args is ViewRearingWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => ViewRearingWeekDataScreen(
                    cycleName: args.cycleName,
                    cycleId: args.cycleId,
                    weekNumber: args.weekNumber,
                  ));
        }
        return _errorRoute();
      case ViewProductionWeekDataScreen.routeName:
        if (args is ViewProductionWeekDataScreenData) {
          return MaterialPageRoute(
              builder: (_) => ViewProductionWeekDataScreen(
                    cycleName: args.cycleName,
                    cycleId: args.cycleId,
                    weekNumber: args.weekNumber,
                  ));
        }
        return _errorRoute();
      case CyclesScreen.routeName:
        if (args is List<Object>) {
          UserData? userData = ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false).read(di.userViewModelProvider);
          if (userData == null) {
            // context.read(di.contentProvider).state =
            //     DrawerItemType.loginScreen.index;

            return MaterialPageRoute(
                builder: (_) => MainBottomAppBar(
                    // redirectionData: RedirectionData(
                    //     redirectionIndexAfterPop: args[2] as int,
                    //     redirectionRouteName: CyclesScreen.routeName,
                    //     arguments: args
                    // )
                    ));
          } else {
            return MaterialPageRoute(
                builder: (_) => CyclesScreen(
                      category: args[0] as Category,
                      tool: args[1] as Tool,
                    ));
          }
        }
        return _errorRoute();

      case ManageCycleScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ManageCycleScreen(
                  cycle: args as Cycle,
                ));

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        return _errorRoute();
    }
  }

  static String? getCurrentRoute() {
    return setting?.name;
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
