import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class WhereToFindUsState {
  List<Supplier>? suppliers;
  List<City>? cities;
  List<City>? suppliersCities;
  List<Category>? categories;
  City? selectedCity;
  int? selectedCategoryId;
  bool? hasNoData;
  double? lat;
  double? long;
  Set<Marker>? markers;

  WhereToFindUsState({
    this.suppliers,
    this.cities,
    this.suppliersCities,
    this.categories,
    this.selectedCity,
    this.selectedCategoryId,
    this.hasNoData = false,
    this.lat,
    this.long,
    this.markers,
  });

  WhereToFindUsState copyWith({
    List<Supplier>? suppliers,
    List<City>? cities,
    List<City>? suppliersCities,
    List<Category>? categories,
    City? selectedCity,
    int? selectedCategoryId,
    bool? hasNoData,
    double? lat,
    double? long,
    Set<Marker>? markers,
  }){
    return WhereToFindUsState(
      suppliers: suppliers ?? this.suppliers,
      cities: cities ?? this.cities,
      suppliersCities: suppliersCities ?? this.suppliersCities,
      categories: categories ?? this.categories,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      hasNoData: hasNoData ?? this.hasNoData,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      markers: markers ?? this.markers,
    );
  }

}
