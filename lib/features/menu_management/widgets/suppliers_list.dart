import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/where_to_find_us_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/where_to_find_us_supplier_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/injection_container.dart' as di;

class SuppliersListWidget extends StatelessWidget {
  List<Supplier> suppliers;
  WhereToFindUsViewModel notifier;
  bool isLoading;

  SuppliersListWidget(
      {required this.suppliers,
      required this.notifier,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return PaginationList(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, index) {
        var supplier = suppliers[index];
        return WhereToFindUsSupplierItem(supplier: supplier);
      },
      itemCount: suppliers.length,
      onLoadMore: () =>
          notifier.getSuppliers(showLoading: false, fromPagination: true),
      hasMore: notifier.hasNext,
      loading: isLoading,
    );
  }
}
