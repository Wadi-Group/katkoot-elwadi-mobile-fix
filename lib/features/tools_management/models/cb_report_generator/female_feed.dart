class FemaleFeed {
  String? unit;
  double? value;
  double? standard;

  FemaleFeed({this.unit, this.value, this.standard});

  FemaleFeed.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = (json["value"] is int) ? json["value"].toDouble() : json["value"];
    standard = (json["standard"] is int) ? json["standard"].toDouble() : json["standard"];
  }
}
