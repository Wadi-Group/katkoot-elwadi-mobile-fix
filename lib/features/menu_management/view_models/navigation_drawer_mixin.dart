import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/menu_management/entities/navigation_item.dart';

mixin NavigationDrawerMixin {
  // void resetDrawerSelection() {
  //   AppConstants.navigatorKey.currentContext
  //       ?.read(di.navigationDrawerViewModelProvider.notifier)
  //       .changeDrawerSelection(NavigationItem.home);
  // }

  // void navigateToRoute(NavigationItem item) {
  //   AppConstants.navigatorKey.currentContext
  //       ?.read(di.navigationDrawerViewModelProvider.notifier)
  //       .changeDrawerSelection(item);
  // }
}
