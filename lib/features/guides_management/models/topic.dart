import 'guide.dart';

class Topic {
  String? title;
  String? subTitle;
  String? description;
  String? image;
  bool? haveTools;
  bool? haveGuides;
  bool? haveFaqs;
  int? categoryId;
  List<Guide>? guides;

  Topic(
      {
        this.title,
        this.subTitle,
        this.description,
        this.image,
        this.haveTools,
        this.haveGuides,
        this.haveFaqs,
        this.categoryId,
        this.guides});

  Topic.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    image = json['image'];
    haveTools = json['have_tools'];
    haveGuides = json['have_guides'];
    haveFaqs = json['have_faqs'];
    categoryId = json['category_id'];
    if (json['guides'] != null) {
      guides =  [];
      json['guides'].forEach((v) {
        guides!.add(new Guide.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['description'] = this.description;
    data['image'] = this.image;
    data['have_tools'] = this.haveTools;
    data['have_guides'] = this.haveGuides;
    data['have_faqs'] = this.haveFaqs;
    data['category_id'] = this.categoryId;
    if (this.guides != null) {
      data['guides'] = this.guides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
