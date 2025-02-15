class Pullets {
  String? unit;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  Pullets(
      {this.unit, this.defaultValue, this.maxValue, this.minValue});

  Pullets.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    minValue = json["min-value"];
    maxValue = json["max-value"];
    defaultValue = json["default-value"];
  }
}
