class TotalEggPerHatchedHen {
  String? unit;
  double? value;
  double? standard;

  TotalEggPerHatchedHen({this.unit, this.value, this.standard});

  TotalEggPerHatchedHen.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = (json["value"] is int) ? json["value"].toDouble() : json["value"];
    standard = (json["standard"] is int) ? json["standard"].toDouble() : json["standard"];
  }
}
