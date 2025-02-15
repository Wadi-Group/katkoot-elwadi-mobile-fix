class BroilerLivability {
  String? unit;
  String? title;
  int? minValue;
  int? maxValue;
  int? defaultValue;
  int? step;

  BroilerLivability(
      {this.unit, this.defaultValue, this.maxValue, this.minValue,this.step,this.title});

  BroilerLivability.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    title = json['name'];
    minValue = json["min-value"];
    maxValue = json["max-value"];
    defaultValue = json["default-value"];
    step = json["step"];
  }
}
