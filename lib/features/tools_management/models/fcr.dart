class Fcr {
  String? fcr;

  Fcr({this.fcr});

  Fcr.fromJson(Map<String, dynamic> json) {
    fcr = json["fcr"];
  }
}
