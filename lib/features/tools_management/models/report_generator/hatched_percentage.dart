class HatchedPercentage {
  String? unit;
  double? value;
  double? standard;

  HatchedPercentage({this.unit, this.value, this.standard});

  HatchedPercentage.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = (json["value"] is int) ? json["value"].toDouble() : json["value"];
    standard = (json["standard"] is int) ? json["standard"].toDouble() : json["standard"];
  }
}
