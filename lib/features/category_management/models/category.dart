import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class Category {
  int? id;
  String? title;
  String? subTitle;
  String? description;
  String? imageUrl;
  int? categoryId;
  bool? haveTools;
  bool? haveGuides;
  bool? haveFaqs;
  bool? haveVideos;
  List<Video>? videosList;

  Category(
      {this.id,
        this.title,
        this.subTitle,
        this.description,
        this.imageUrl,
        this.categoryId,
        this.haveTools,
        this.haveGuides,
        this.haveFaqs,
        this.videosList,
        this.haveVideos});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title= json["title"];
    subTitle= json["sub_title"];
    description= json["description"];
    imageUrl= json["image"];
    categoryId= json["category_id"];
    haveTools= json["have_tools"];
    haveGuides= json["have_guides"];
    haveFaqs= json["have_faqs"];
    haveVideos= json["have_videos"];

    if (json['videos'] != null) {
      videosList = [];
      json['videos'].forEach((v) {
        videosList!.add(Video.fromJson(v));
      });
    }
  }

  factory Category.fromJsonObject(Map<Object?, Object?> json) {
    return Category(
      id: json['id'] as int,
      title: json["title"] as String,
    );
  }

  int getTabsNumber(){
     int count = 1 ;
    if(haveTools ?? true)
      count+=1;
    if(haveGuides! || haveVideos! || haveFaqs! )
      count+=1;
    return count;
  }
  int getGuidesTabsNumber(){
    int count = 0 ;
    if(haveGuides ?? true)
      count+=1;
    if(haveVideos ?? true)
      count+=1;
    if(haveFaqs ?? true)
      count+=1;
    return count;
  }
}
