import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_parameters.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_pullets_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/defaults.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/parent_flock_management_pullets_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_flock_management_parameter_item.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/parent_flock_management_parameters_header_view.dart';

class ParentFlockManagementPulletsParametersScreenData {
  final StateNotifierProvider<ParentFlockManagementPulletsViewModel,
      BaseState<ParentFlockManagementPulletsState>> screenProvider;
  final Defaults? defaults;

  ParentFlockManagementPulletsParametersScreenData(
      {required this.screenProvider, required this.defaults});
}

class ParentFlockManagementPulletsParametersScreen extends StatefulWidget {
  static const routeName = "./parent_flock_management_pullets_parameters";

  final StateNotifierProvider<ParentFlockManagementPulletsViewModel,
      BaseState<ParentFlockManagementPulletsState>> screenProvider;
  final Defaults? defaults;

  const ParentFlockManagementPulletsParametersScreen(
      {Key? key, required this.screenProvider, required this.defaults})
      : super(key: key);

  @override
  _ParentFlockManagementPulletsParametersScreenState createState() =>
      _ParentFlockManagementPulletsParametersScreenState();
}

class _ParentFlockManagementPulletsParametersScreenState
    extends State<ParentFlockManagementPulletsParametersScreen> {
  late final _broilerLivabilityProvider = Provider<int?>((ref) {
    return ref.watch(widget.screenProvider).data.parameters?.broilerLivability;
  });

  late final _hatchProvider = Provider<int?>((ref) {
    return ref.watch(widget.screenProvider).data.parameters?.hatch;
  });

  late final _hatchingHenProvider = Provider<int?>((ref) {
    return ref.watch(widget.screenProvider).data.parameters?.hatchingHen;
  });

  late final _pulletLivabilityProvider = Provider<int?>((ref) {
    return ref.watch(widget.screenProvider).data.parameters?.pulletLivability;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ParentFlockManagementParametersHeaderView(
          onEraseAllClick: () =>
              ProviderScope.containerOf(context, listen: false)
                  .read(widget.screenProvider.notifier)
                  .resetAllParametersSliders(),
        ),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              _buildBroilerLivabilityItem(),
              _buildHatchItem(),
              _buildHatchingHenItem(),
              _buildPulletLivabilityItem()
            ],
          ),
        ))
      ],
    ));
  }

  _buildBroilerLivabilityItem() {
    return Consumer(builder: (_, ref, __) {
      var broilerLivability = ref.watch(_broilerLivabilityProvider);
      return ParentFlockManagementParameterItem(
          step: widget.defaults?.broilerLivability?.step ?? 1,
          max: widget.defaults?.broilerLivability?.maxValue ?? 1,
          title: widget.defaults?.broilerLivability?.title ?? '',
          value: broilerLivability ??
              widget.defaults?.broilerLivability?.defaultValue ??
              1,
          min: widget.defaults?.broilerLivability?.minValue ?? 1,
          unit: widget.defaults?.broilerLivability?.unit ?? '',
          onDrag: (value) => ProviderScope.containerOf(context, listen: false)
              .read(widget.screenProvider.notifier)
              .onBroilerLivabilitySliderChange((value ?? 0).toInt()));
    });
  }

  _buildHatchItem() {
    return Consumer(builder: (_, ref, __) {
      var hatch = ref.watch(_hatchProvider);
      return ParentFlockManagementParameterItem(
          step: widget.defaults?.hatch?.step ?? 1,
          max: widget.defaults?.hatch?.maxValue ?? 1,
          title: widget.defaults?.hatch?.title ?? '',
          value: hatch ?? widget.defaults?.hatch?.defaultValue ?? 1,
          min: widget.defaults?.hatch?.minValue ?? 1,
          unit: widget.defaults?.hatch?.unit ?? '',
          onDrag: (value) => ProviderScope.containerOf(context,
              listen: false).read(widget.screenProvider.notifier)
              .onHatchSliderChange((value ?? 0).toInt()));
    });
  }

  _buildHatchingHenItem() {
    return Consumer(builder: (_, ref, __) {
      var hatchingHen = ref.watch(_hatchingHenProvider);
      return ParentFlockManagementParameterItem(
          step: widget.defaults?.hatchedHen?.step ?? 1,
          max: widget.defaults?.hatchedHen?.maxValue ?? 1,
          title: widget.defaults?.hatchedHen?.title ?? '',
          value: hatchingHen ?? widget.defaults?.hatchedHen?.value ?? 1,
          min: widget.defaults?.hatchedHen?.minValue ?? 1,
          unit: widget.defaults?.hatchedHen?.unit ?? '',
          onDrag: (value) => ProviderScope.containerOf(context,
              listen: false).read(widget.screenProvider.notifier)
              .onHatchingHenSliderChange((value ?? 0).toInt()));
    });
  }

  _buildPulletLivabilityItem() {
    return Consumer(builder: (_, ref, __) {
      var pulletLivability = ref.watch(_pulletLivabilityProvider);
      return ParentFlockManagementParameterItem(
          step: widget.defaults?.pulletLivabilityToCap?.step ?? 1,
          max: widget.defaults?.pulletLivabilityToCap?.maxValue ?? 1,
          title: widget.defaults?.pulletLivabilityToCap?.title ?? '',
          value: pulletLivability ??
              widget.defaults?.pulletLivabilityToCap?.defaultValue ??
              1,
          min: widget.defaults?.pulletLivabilityToCap?.minValue ?? 1,
          unit: widget.defaults?.pulletLivabilityToCap?.unit ?? '',
          onDrag: (value) => ProviderScope.containerOf(context,
              listen: false).read(widget.screenProvider.notifier)
              .onPulletLivabilitySliderChange((value ?? 0).toInt()));
    });
  }
}
