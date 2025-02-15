class City {
  int? id;
  String? name;
  String? lat;
  String? long;

  City({
    this.id,
    this.name,
    this.lat,
    this.long,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json["name"],
      lat: json["lat"],
      long: json["long"],
    );
  }
}
