import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class WhereToFindUsData {
  List<Supplier>? suppliers;
  City? city;

  WhereToFindUsData({
    this.suppliers,
    this.city,
  });

  WhereToFindUsData.fromJson(Map<String, dynamic> json) {
    city = json["city"] != null ? City.fromJson(json["city"]) : null;

    if (json['suppliers'] != null) {
      suppliers = [];
      json['suppliers'].forEach((v) {
        suppliers!.add(Supplier.fromJson(v));
      });
    }
  }
}
