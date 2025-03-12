import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/local/shared_preferences_service.dart';
import 'package:katkoot_elwady/core/services/remote/api_services.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/app_bar_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/bottom_navigation_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/main_bottom_navigation_view_model.dart';
import 'package:katkoot_elwady/features/app_base/view_models/unseen_notification_count_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/entities/guides_bar_state.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_view_model.dart';
import 'package:katkoot_elwady/features/messages_management/view_models/messages_view_model.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:katkoot_elwady/features/search_management/view_models/search_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/guides_management/widgets/guides_tab_bar_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/tool_details_state.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/create_cycle_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/cycles_list_view_model.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/app_base/view_models/network_view_model.dart';
import 'package:katkoot_elwady/features/app_base/view_models/app_bar_tabs_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/custom_slider_view_model.dart';
import 'package:katkoot_elwady/features/user_management/view_models/city_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/tool_details_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/tools_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/change_language_view_model.dart';
import 'package:katkoot_elwady/features/category_management/view_models/categories_view_model.dart';
import 'package:katkoot_elwady/features/user_management/view_models/user_data_view_model.dart';
import 'package:riverpod/riverpod.dart';

import '../../features/menu_management/view_models/about_us_view_model.dart';
import '../../features/tools_management/models/cb_report_generator/cycle.dart';
import '../../features/tools_management/view_models/cb_report_generator/cycles_list_view_model.dart';

final isConnectedProvider =
    StateNotifierProvider<NetworkViewModel, bool>((ref) {
  return NetworkViewModel();
});

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => throw UnimplementedError());

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final ValueNotifier<bool> appRedirectedFromNotificationNotifier =
    ValueNotifier(false);

final repositoryProvider = Provider<Repository>((ref) {
  return Repository(
      ref.read(apiServiceProvider), ref.read(sharedPreferencesServiceProvider));
});

final changeLanguageViewModelProvider =
    StateNotifierProvider<ChangeLanguageViewModel, BaseState>((ref) {
  return ChangeLanguageViewModel(ref.read(repositoryProvider));
});

final searchIndex = StateProvider<int>((ref) {
  return 0;
});

final searchContentProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

final navigationDrawerViewModelProvider =
    StateNotifierProvider<NavigationViewModel, BaseState>((ref) {
  return NavigationViewModel(ref.read(repositoryProvider));
});

final appBarTabsViewModelProvider =
    StateNotifierProvider<AppBarTabsViewModel, BaseState<AppBarState?>>((ref) {
  return AppBarTabsViewModel(ref.read(repositoryProvider));
});

final guidesTabBarViewModelProvider =
    StateNotifierProvider<GuidesTabBarViewModel, BaseState<GuidesTabBarState?>>(
        (ref) {
  return GuidesTabBarViewModel(ref.read(repositoryProvider));
});

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, UserData?>((ref) {
  return UserViewModel(ref.read(repositoryProvider));
});

final unseenNotificationCountProvider =
    StateNotifierProvider<UnseenNotificationCountViewModel, int>((ref) {
  return UnseenNotificationCountViewModel(ref.read(repositoryProvider));
});

final categoriesViewModelProvider =
    StateNotifierProvider<CategoriesViewModel, BaseState<List<Category>?>>(
        (ref) {
  return CategoriesViewModel(ref.read(repositoryProvider));
});

final toolsViewModelProvider =
    StateNotifierProvider<ToolsViewModel, BaseState<List<Tool>?>>((ref) {
  return ToolsViewModel(ref.read(repositoryProvider));
});

final toolDetailsViewModelProvider =
    StateNotifierProvider<ToolDetailsViewModel, BaseState<ToolDetailsState?>>(
        (ref) {
  return ToolDetailsViewModel(ref.read(repositoryProvider));
});

final cityViewModelProvider =
    StateNotifierProvider<CityViewModel, BaseState<List<City>?>>((ref) {
  return CityViewModel(ref.read(repositoryProvider));
});

final customSliderViewModelProvider = StateNotifierProvider.autoDispose<
    CustomSliderViewModel, BaseState<SliderItem>>((ref) {
  return CustomSliderViewModel(ref.read(repositoryProvider));
});

final messagesViewModelProvider =
    StateNotifierProvider<MessagesViewModel, BaseState<List<Message>?>>((ref) {
  return MessagesViewModel(ref.read(repositoryProvider));
});

final createCycleViewModelProvider = StateNotifierProvider<CreateCycleViewModel,
    BaseState<List<UserFormsErrors>>>((ref) {
  return CreateCycleViewModel(ref.read(repositoryProvider));
});

final cyclesListViewModelViewModelProvider =
    StateNotifierProvider<CyclesListViewModel, BaseState<List<Cycle>?>>((ref) {
  return CyclesListViewModel(ref.read(repositoryProvider));
});

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, BaseState<SearchModel?>>((ref) {
  return SearchViewModel(ref.read(repositoryProvider));
});

final bottomNavigationViewModelProvider = StateNotifierProvider<
    MainBottomNavigationViewModel, BaseState<BottomNavigationState>>((ref) {
  return MainBottomNavigationViewModel();
});

// final createCbCycleViewModelProvider = StateNotifierProvider<CyclesListViewModel,
//     BaseState<List<UserFormsErrors>>>((ref) {
//   return CyclesListViewModel(ref.read(repositoryProvider));
// });

final CbcyclesListViewModelViewModelProvider =
    StateNotifierProvider<CbCyclesListViewModel, BaseState<List<CbCycle>?>>(
        (ref) {
  return CbCyclesListViewModel(ref.read(repositoryProvider));
});

// about us view model
final aboutUsViewModelProvider =
    StateNotifierProvider<AboutUsViewModel, BaseState<Map<String, dynamic>?>>(
        (ref) {
  return AboutUsViewModel(ref.read(repositoryProvider));
});
