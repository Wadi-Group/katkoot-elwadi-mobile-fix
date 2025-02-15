import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_loader.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_connection.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';

class ScreenHandler extends StatefulWidget {
  final StateNotifierProvider<dynamic, BaseState<dynamic>> screenProvider;
  final void Function()? onDeviceReconnected;
  final String? noDataMessage;
  final Widget? noDataWidget;
  final bool showLoading;

  ScreenHandler({
    required this.screenProvider,
    this.onDeviceReconnected,
    this.noDataMessage,
    this.noDataWidget,
    this.showLoading = true,
  });

  @override
  ScreenHandlerState createState() {
    return ScreenHandlerState();
  }
}

class ScreenHandlerState extends State<ScreenHandler> {
  bool isConnectedAtLastTime = true;

  late final _isLoadingProvider = Provider.autoDispose<bool>((ref) {
    return ref.watch(widget.screenProvider).isLoading;
  });

  late final _successMessageProvider = Provider.autoDispose<String>((ref) {
    return ref.watch(widget.screenProvider).successMessage;
  });

  late final  AutoDisposeProvider<bool> _noConnectionProvider = Provider.autoDispose<bool>((ref) {
    return ref.watch(widget.screenProvider).hasNoConnection;
  });

  late final AutoDisposeProvider<bool> _noConnectionHasBackgroundProvider =
      Provider.autoDispose<bool>((ref) {
    return ref.watch(widget.screenProvider).noConnectionHasBackground;
  });

  late final AutoDisposeProvider<bool> _noDataProvider = Provider.autoDispose<bool>((ref) {
    return ref.watch(widget.screenProvider).hasNoData;
  });

  late final AutoDisposeProvider<bool> _isPerformingRequestProvider =
      Provider.autoDispose<bool>((ref) {
    return ref.watch(widget.screenProvider).isPerformingRequest;
  });

  late final _isReconnectedProvider = Provider.autoDispose<bool>((ref) {
    bool isConnected = ref.watch(di.isConnectedProvider);
    bool isPerformingRequest = ref.read(_isPerformingRequestProvider);
    if (isConnected &&
        !isConnectedAtLastTime &&
        widget.onDeviceReconnected != null &&
        !isPerformingRequest) {
      Future.delayed(Duration.zero, () {
        widget.onDeviceReconnected!();
      });
    }
    isConnectedAtLastTime = isConnected;
    return isConnected;
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(
          builder: (_, ref, __) {
            final bool noData = ref.watch(_noDataProvider);
            return AppNoData(
                show: noData,
                noDataView: widget.noDataWidget,
                msg: widget.noDataMessage ?? "str_no_data".tr());
          },
        ),
        Consumer(
          builder: (_, ref, __) {
            final bool noConnection = ref.watch(_noConnectionProvider);
            final bool noConnectionHasBackground =
            ref.watch(_noConnectionHasBackgroundProvider);
            ref.watch(_isReconnectedProvider);
            return noConnection
                ? AppNoConnection(
                    onTap: widget.onDeviceReconnected,
                    hasBackground: noConnectionHasBackground,
                  )
                : SizedBox();
          },
        ),
        if (widget.showLoading)
          Consumer(
            builder: (_, ref, __) {
              final bool isLoading = ref.watch(_isLoadingProvider);
              return isLoading ? AppLoader() : SizedBox();
            },
          ),
      ],
    );
  }
}
