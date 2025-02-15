class HatchingHen {
  String? unit;
  String? title;
  int? minValue;
  int? maxValue;
  int? value;
  int? step;

  HatchingHen({this.unit, this.value, this.maxValue, this.minValue,this.step,this.title});

  HatchingHen.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    title = json['name'];
    minValue = json["min-value"];
    maxValue = json["max-value"];
    value = json["value"];
    step = json["step"];
  }
}
