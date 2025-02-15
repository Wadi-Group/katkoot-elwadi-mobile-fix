class SocialMediaLink {
  String? name;
  String? url;
  String? image;
  SocialMediaLink({this.image, this.name, this.url});

  SocialMediaLink.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
    image = json["image"];
  }
}
