class PhoneExistence {
  bool? exist;
  String? message;

  PhoneExistence({
    this.exist,
    this.message,
  });

  factory PhoneExistence.fromJson(Map<String, dynamic> json) {
    return PhoneExistence(
      exist: json['exist']??false,
      message: json["message"]??"",
    );
  }
}
