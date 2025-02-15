class PulletLivabilityToCap {
  String? unit;
  String? title;
  int? minValue;
  int? maxValue;
  int? defaultValue;
  int? step;

  PulletLivabilityToCap(
      {this.unit, this.defaultValue, this.maxValue, this.minValue,this.step,this.title});

  PulletLivabilityToCap.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    title = json['name'];
    minValue = json["min-value"];
    maxValue = json["max-value"];
    step = json["step"];
    defaultValue = json["default-value"];
  }
}
