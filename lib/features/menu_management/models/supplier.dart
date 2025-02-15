import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class Supplier {
  int? id;
  String? name;
  Category? category;
  List<String>? phones;
  List<String>? specialties;
  List<City>? cities;

  Supplier({
    this.id,
    this.name,
    this.category,
    this.phones,
    this.specialties,
    this.cities
  });

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json["name"];
    category = json["category"]!= null ? Category.fromJson(json["category"]) : null;

    if (json['phone'] != null) {
      phones = [];
      json['phone'].forEach((v) {
        phones!.add(v.toString());
      });
    }

    if (json['specialty'] != null) {
      specialties = [];
      json['specialty'].forEach((v) {
        specialties!.add(v.toString());
      });
    }

    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((city) {
        (cities ?? []).add(City.fromJson(city));
      });
    }
  }
}
