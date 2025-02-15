import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/create_new_cycle_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/cycles_list_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/fcr_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/commercial_broiler_flock_requirements_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_management_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/flock_management/parent_flock_requirement_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/parent_performance_objective_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/bef_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/add_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';

import '../screens/cb_report_generator/cycles_list_screen.dart';

class ToolsViewModel extends StateNotifier<BaseState<List<Tool>?>>
    with BaseViewModel {
  Repository _repository;

  ToolsViewModel(this._repository) : super(BaseState(data: []));

  Future getTools(int categoryId, {String? searchText}) async {
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    // if (context != null) {
    //   if (!context.read(di.userViewModelProvider.notifier).isUserLoggedIn()) {
    //     return;
    //   }
    // }
    if(searchText == null || (searchText.trim().isNotEmpty)) {
      state = BaseState(data: [], isLoading: true);

      var result =
      await _repository.getCategoryTools(categoryId, searchText: searchText);
      print("this is the result");
      print(result.data);
      List<Tool>? tools;
      if (result.data != null) {
        tools = result.data!;
        state =
            BaseState(data: tools, isLoading: false, hasNoData: tools.isEmpty);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
            state.data!.isEmpty) {
          state.hasNoConnection = state.data!.isEmpty;
          state = BaseState(data: [], isLoading: false, hasNoConnection: true);
        } else {
          state = BaseState(data: [], isLoading: false);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    }
  }

  void openToolDetails(BuildContext context,Tool tool, Category category, int toolId) {
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return ParentFlockManagementScreen(
                category: category,
                toolId: toolId,
              );
            }
          ));
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

          if(ProviderScope.containerOf(context,
              listen: false).read(di.userViewModelProvider.notifier).isUserLoggedIn()){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return CommercialBroilerPerformanceObjective(
                    category: category,
                    toolId: toolId,
                  );
                }
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return LoginScreen(
                    nextRoute: MaterialPageRoute(
                        builder: (context){
                          return CommercialBroilerPerformanceObjective(
                            category: category,
                            toolId: toolId,
                          );
                        }
                    ),
                  );
                }
            ));
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                return BEFScreen(
                  category: category, tool: tool,
                );
              }
          ));

          // navigateToScreen(BEFScreen.routeName,
          //     arguments: BEFScreenData(category: category, tool: tool));
        }
        break;
      case ToolTypes.CB_FCR:
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                return FCRScreen(
                  category: category, tool: tool,
                );
              }
          ));

          // navigateToScreen(FCRScreen.routeName,
          //     arguments: FCRScreenData(category: category, tool: tool));
        }
        break;
      case ToolTypes.PS_RG:
        {
          if(ProviderScope.containerOf(context,
              listen: false).read(di.userViewModelProvider.notifier).isUserLoggedIn()){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return CyclesScreen(
                    category: category,
                    tool: tool,
                  );
                }
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return LoginScreen(
                    nextRoute: MaterialPageRoute(
                        builder: (context){
                          return CyclesScreen(
                            category: category,
                            tool: tool,
                          );
                        }
                    ),
                  );
                }
            ));
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
          if(ProviderScope.containerOf(context,
              listen: false).read(di.userViewModelProvider.notifier).isUserLoggedIn()){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return CbCyclesScreen(
                    category: category,
                    tool: tool,
                  );
                }
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return LoginScreen(
                    nextRoute: MaterialPageRoute(
                        builder: (context){
                          return CbCyclesScreen(
                            category: category,
                            tool: tool,
                          );
                        }
                    ),
                  );
                }
            ));
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
