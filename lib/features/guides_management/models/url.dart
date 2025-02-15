class Url {
  String? id;
  String? provider;
  String? title;
  String? image;
  String? url;

  Url(
      {this.id,
      this.title,
      this.provider,
      this.image,
      this.url});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      id: json['id'],
      title: json["title"],
      provider: json["provider"],
      image: json["image"],
      url: json["url"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['provider'] = this.provider;
    data['url'] = this.url;
    data['image'] = this.image;
    return data;
  }
}
