
class SliderData {
  int? minValue;
  int? maxValue;
  int? step;
  int? defaultValue ;

  SliderData(
      {this.minValue,
        this.maxValue,
        this.step,
        this.defaultValue,
      });

  SliderData.fromJson(Map<String, dynamic> json) {
    minValue = json['min-value'];
    maxValue = json['max-value'];
    step = json["step"];
    defaultValue = json["default-value"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min-value'] = this.minValue;
    data['max-value'] = this.maxValue;
    data['step'] = this.step;
    data['default-value'] = this.defaultValue;
    return data;
  }
}
