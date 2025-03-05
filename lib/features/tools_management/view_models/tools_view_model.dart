import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/cycles_list_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/fcr_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_broiler_flock_requirements_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_requirement_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/parent_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/bef_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';

import '../../../core/utils/check_internet_connection.dart';
import '../screens/cb_report_generator/cycles_list_screen.dart';

class ToolsViewModel extends StateNotifier<BaseState<List<Tool>?>>
    with BaseViewModel {
  Repository _repository;

  ToolsViewModel(this._repository) : super(BaseState(data: []));

  Future<void> getTools(int categoryId, {String? searchText}) async {
    final boxName = 'toolsBox_$categoryId'; // Unique box per category

    //  Check network status first
    bool isOnline = await checkInternetConnection();

    if (!isOnline) {
      print("No internet. Checking local storage...");
    }

    //  Open Hive Box only if needed
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Tool>(boxName);
    }
    final box = Hive.box<Tool>(boxName);

    // If offline, load cached tools
    if (!isOnline) {
      if (box.isNotEmpty) {
        print("Loading tools from local storage...");
        List<Tool> cachedTools = box.values.toList();
        state = BaseState(data: cachedTools, isLoading: false);
        return;
      } else {
        print("No cached data available.");
        state = BaseState(data: [], isLoading: false);
        return;
      }
    }

    //  If online, fetch from API
    print("Fetching tools from API...");
    var result =
        await _repository.getCategoryTools(categoryId, searchText: searchText);

    if (result.data != null) {
      List<Tool> tools = result.data!;

      // Save data to Hive
      await box.clear(); // Clear old tools for this category
      for (var tool in tools) {
        await box.put(tool.id, tool);
      }

      state =
          BaseState(data: tools, isLoading: false, hasNoData: tools.isEmpty);
    } else {
      state = BaseState(data: [], isLoading: false);
    }
  }

  void openToolDetails(
      BuildContext context, Tool tool, Category category, int toolId) {
    switch (tool.type) {
      case ToolTypes.PS_FR:
        {
          navigateToScreen(ParentStockFlockRequirementScreen.routeName,
              arguments: [category, toolId]);
        }
        break;
      case ToolTypes.PS_FM:
        {
          // navigateToScreen(ParentFlockManagementScreen.routeName,
          //     arguments: ParentFlockManagementScreenData(
          //         category: category, toolId: toolId));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ParentFlockManagementScreen(
              category: category,
              toolId: toolId,
            );
          }));
        }
        break;
      case ToolTypes.CB_FR:
        {
          navigateToScreen(CommercialBroilerFlockRequirementsScreen.routeName,
              arguments: CommercialBroilerFlockRequirementsScreenData(
                  category: category, toolId: tool.id));
        }
        break;
      case ToolTypes.PS_FM:
        {}
        break;
      case ToolTypes.PS_PO:
        {
          navigateToScreen(ParentStockPerformanceObjective.routeName,
              arguments: [category, toolId]);
        }
        break;
      case ToolTypes.CB_PO:
        {
          if (ProviderScope.containerOf(context, listen: false)
              .read(di.userViewModelProvider.notifier)
              .isUserLoggedIn()) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CommercialBroilerPerformanceObjective(
                category: category,
                toolId: toolId,
              );
            }));
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreen(
                nextRoute: MaterialPageRoute(builder: (context) {
                  return CommercialBroilerPerformanceObjective(
                    category: category,
                    toolId: toolId,
                  );
                }),
              );
            }));
          }

          // navigateToScreen(CommercialBroilerPerformanceObjective.routeName,
          //     arguments: [
          //       category,
          //       toolId,
          //       AppConstants.navigatorKey.currentContext!.read(di.contentProvider).state
          //     ]);
        }
        break;
      case ToolTypes.CB_PEF:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BEFScreen(
              category: category,
              tool: tool,
            );
          }));

          // navigateToScreen(BEFScreen.routeName,
          //     arguments: BEFScreenData(category: category, tool: tool));
        }
        break;
      case ToolTypes.CB_FCR:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return FCRScreen(
              category: category,
              tool: tool,
            );
          }));

          // navigateToScreen(FCRScreen.routeName,
          //     arguments: FCRScreenData(category: category, tool: tool));
        }
        break;
      case ToolTypes.PS_RG:
        {
          if (ProviderScope.containerOf(context, listen: false)
              .read(di.userViewModelProvider.notifier)
              .isUserLoggedIn()) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CyclesScreen(
                category: category,
                tool: tool,
              );
            }));
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreen(
                nextRoute: MaterialPageRoute(builder: (context) {
                  return CyclesScreen(
                    category: category,
                    tool: tool,
                  );
                }),
              );
            }));
          }

          // navigateToScreen(CyclesScreen.routeName, arguments: [
          //   category,
          //   tool,
          //   AppConstants.navigatorKey.currentContext!.read(di.contentProvider).state
          // ]);
        }
        break;

      case ToolTypes.CB_RG:
        {
          if (ProviderScope.containerOf(context, listen: false)
              .read(di.userViewModelProvider.notifier)
              .isUserLoggedIn()) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CbCyclesScreen(
                category: category,
                tool: tool,
              );
            }));
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreen(
                nextRoute: MaterialPageRoute(builder: (context) {
                  return CbCyclesScreen(
                    category: category,
                    tool: tool,
                  );
                }),
              );
            }));
          }

          // navigateToScreen(CyclesScreen.routeName, arguments: [
          //   category,
          //   tool,
          //   AppConstants.navigatorKey.currentContext!.read(di.contentProvider).state
          // ]);
        }
        break;
    }
  }

  void setState(List<Tool>? tools) {
    state = BaseState(data: tools, isLoading: false);
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
