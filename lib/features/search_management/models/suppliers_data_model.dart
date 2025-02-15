
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';

class SuppliersDataModel {
  List<Supplier>? suppliers;
  bool? hasMore;

  SuppliersDataModel(
      {this.suppliers,this.hasMore});

  SuppliersDataModel.fromJson(Map<String, dynamic> json) {
    Iterable suppliersIterable = json['items'] ?? [];

    suppliers =
    List<Supplier>.from(suppliersIterable.map((model) => Supplier.fromJson(model)));
    hasMore = json['has_more'];
  }
}
