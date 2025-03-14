class User {
  String? name;
  String? phone;
  String? email;
  var categoryId;
  var cityId;
  String? cachedToolsParameter;
  String? notificationToken;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? birthDate;
  DateTime? creationDate;
  String? state;
  String? flockSize;

  User(
      {this.name,
      this.phone,
      this.email,
      this.categoryId,
      this.cityId,
      this.cachedToolsParameter,
      this.creationDate,
      this.notificationToken,
      this.updatedAt,
      this.birthDate,
      this.createdAt,
      this.id,
      this.flockSize,
      this.state});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    categoryId = json['categories'];
    cityId = json['city_id'];
    birthDate = json["birth_date"];
    cachedToolsParameter = json['cached_tools_parameter'];
    notificationToken = json['notification_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    state = json["village"];
    flockSize = json["flock_size"];

    id = json['id'];
    if (createdAt != null) {
      creationDate = DateTime.parse(createdAt!);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['categories'] = this.categoryId;
    data['city_id'] = this.cityId;
    data["birth_date"] = this.birthDate;
    data['cached_tools_parameter'] = this.cachedToolsParameter;
    data['notification_token'] = this.notificationToken;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data["village"] = this.state;
    data["flock_size"] = this.flockSize;
    data['id'] = this.id;

    return data;
  }
}
