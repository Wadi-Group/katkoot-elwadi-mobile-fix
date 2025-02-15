class Pef {
  String? pef;
  Pef({this.pef});

  Pef.fromJson(Map<String, dynamic> json) {
    pef = json["pef"];
  }
}
