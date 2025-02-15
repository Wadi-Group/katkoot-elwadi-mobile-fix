class PhoneContact {
  String? phone;
  PhoneContact({this.phone});

  PhoneContact.fromJson(Map<String, dynamic> json) {
    phone = json["phone"];
  }
}
