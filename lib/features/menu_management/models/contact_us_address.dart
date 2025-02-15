import 'package:katkoot_elwady/features/menu_management/models/lat_lng.dart';

class ContactUsAddress {
  String? value;
  LatLng? latlng;
  String? route;
  String? adminstritiveAreaLevel1;

  String? adminstritiveAreaLevel2;

  String? adminstritiveAreaLevel3;
  String? country;

  ContactUsAddress(
      {this.value,
      this.latlng,
      this.country,
      this.route,
      this.adminstritiveAreaLevel1,
      this.adminstritiveAreaLevel2,
      this.adminstritiveAreaLevel3});

  ContactUsAddress.fromJson(Map<String, dynamic> json) {
    value = json["value"];
    latlng = LatLng.fromJson(json["latlng"]);
    route = json["route"];
    country = json["country"];
    adminstritiveAreaLevel1 = json["administrative_area_level_1"];
    adminstritiveAreaLevel2 = json["administrative_area_level_2"];
    adminstritiveAreaLevel3 = json["administrative_area_level_3"];
  }
}
