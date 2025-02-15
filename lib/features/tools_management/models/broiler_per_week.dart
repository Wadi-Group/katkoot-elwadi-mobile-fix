class BroilerPerWeek {
  String? unit;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  BroilerPerWeek(
      {this.unit, this.defaultValue, this.maxValue, this.minValue});

  BroilerPerWeek.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    minValue = json["min-value"];
    maxValue = json["max-value"];
    defaultValue = json["default-value"];
  }
}
