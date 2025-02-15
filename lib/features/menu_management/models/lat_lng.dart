class LatLng {
  double? latitude;
  double? longitude;
  LatLng({this.latitude, this.longitude});

  LatLng.fromJson(Map<String, dynamic> json) {
    latitude = json["lat"];
    longitude = json["lng"];
  }
}
