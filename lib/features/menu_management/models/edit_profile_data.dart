import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class EditProdileData {
  List<Category>? selectedCategory;

  City? selectedCity;
  String? phoneNumber;
  String? userName;
  String? birthDate;
  String? state;
  String? flockSize;
  List<City>? cities;
  List<Category>? categories;
  int? userId;
  EditProdileData(
      {

        this.phoneNumber,
      this.selectedCategory,
      this.selectedCity,
      this.categories,
      this.birthDate,
      this.cities,
      this.flockSize,
      this.state,
      this.userName,
      this.userId,});
}
