import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/menu_management/entities/where_to_find_us_state.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/where_to_find_us_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/suppliers_list.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_placeholer.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';

class SuppliersWidget extends StatefulWidget {
  bool fromSearchScreen;

  SuppliersWidget({this.fromSearchScreen = false});

  @override
  State<SuppliersWidget> createState() => _SuppliersWidgetState();
}

class _SuppliersWidgetState extends State<SuppliersWidget> {
  final whereToFindUsViewModelProvider = StateNotifierProvider<
      WhereToFindUsViewModel, BaseState<WhereToFindUsState?>>((ref) {
    return WhereToFindUsViewModel(ref.read(di.repositoryProvider));
  });

  late final suppliersDataProvider = Provider<List<Supplier>>((ref) {
    return ref.watch(whereToFindUsViewModelProvider).data?.suppliers ?? [];
  });

  late final suppliersNoDataProvider = Provider<bool>((ref) {
    return ref.watch(whereToFindUsViewModelProvider).data?.hasNoData ?? false;
  });

  getData() async {
    Future.delayed(Duration(microseconds: 0), () {
      ProviderScope.containerOf(context,
          listen: false).read(whereToFindUsViewModelProvider.notifier)
          .getSuppliers(
          serachText: widget.fromSearchScreen ?
          ProviderScope.containerOf(context,
              listen: false).read(di.searchContentProvider) : null);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(builder: (_, ref, __) {
          var suppliers = ref.watch(suppliersDataProvider);
          var notifier = ref.watch(whereToFindUsViewModelProvider.notifier);
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SuppliersListWidget(
              suppliers: suppliers,
              notifier: notifier,
              isLoading: ref.watch(whereToFindUsViewModelProvider).isLoading,
            ),
          );
        }),
        Consumer(builder: (_, ref, __) {
          var noData = ref.watch(suppliersNoDataProvider);

          return noData ? NoDataWidget() : Container();
        }),
        Consumer(
          builder: (_, watch, __) {
            return ScreenHandler(
              screenProvider: whereToFindUsViewModelProvider,
              noDataMessage: "str_no_data".tr(),
              noDataWidget: NoDataWidget(),
            );
          },
        ),
        Consumer(
          builder: (_, ref, __) {
            var searchText = ref.watch(di.searchContentProvider);
            var isEmpty = searchText.trim().isEmpty;
            if (isEmpty && widget.fromSearchScreen) {
              return SearchPlaceHolder();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
