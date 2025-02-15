class EggWeight {
  String? unit;
  double? value;
  double? standard;

  EggWeight({this.unit, this.value, this.standard});

  EggWeight.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = (json["value"] is int) ? json["value"].toDouble() : json["value"];
    standard = (json["standard"] is int) ? json["standard"].toDouble() : json["standard"];
  }
}
