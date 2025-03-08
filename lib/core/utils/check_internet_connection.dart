import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/manage_cycle_view_model.dart';

import '../../features/tools_management/view_models/report_generator/add_week_data_view_model.dart';
import '../../features/tools_management/view_models/report_generator/create_cycle_view_model.dart';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false; // No internet
  }
}

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final CreateCycleViewModel viewModel;
  final AddWeekDataViewModel addWeekDataViewModel;
  final ManageCycleViewModel manageCycleViewModel;

  ConnectivityService(
    this.viewModel,
    this.addWeekDataViewModel,
    this.manageCycleViewModel,
  );

  void checkConnectivityAndSync() {
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.any((result) => result != ConnectivityResult.none)) {
        await viewModel.syncPendingCycles();
        await addWeekDataViewModel.syncPendingWeekData();
        await manageCycleViewModel.syncPendingDeletions();
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
