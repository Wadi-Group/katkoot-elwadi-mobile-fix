import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  ConnectivityService(this.viewModel);

  void checkConnectivityAndSync() {
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        viewModel.syncPendingCycles(); // Call the ViewModel method
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
