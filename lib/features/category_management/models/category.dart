import 'package:hive/hive.dart';
import '../../guides_management/models/video.dart';

part 'category.g.dart'; // Required for Hive code generation

@HiveType(typeId: 16) // Ensure a unique typeId across models
class Category extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? subTitle;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? imageUrl;

  @HiveField(5)
  int? categoryId;

  @HiveField(6)
  bool? haveTools;

  @HiveField(7)
  bool? haveGuides;

  @HiveField(8)
  bool? haveFaqs;

  @HiveField(9)
  bool? haveVideos;

  @HiveField(10)
  List<Video>? videosList;

  Category({
    this.id,
    this.title,
    this.subTitle,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.haveTools,
    this.haveGuides,
    this.haveFaqs,
    this.haveVideos,
    this.videosList,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json["title"],
      subTitle: json["sub_title"],
      description: json["description"],
      imageUrl: json["image"],
      categoryId: json["category_id"],
      haveTools: json["have_tools"],
      haveGuides: json["have_guides"],
      haveFaqs: json["have_faqs"],
      haveVideos: json["have_videos"],
      videosList: json['videos'] != null
          ? (json['videos'] as List).map((v) => Video.fromJson(v)).toList()
          : [],
    );
  }

  factory Category.fromJsonObject(Map<Object?, Object?> json) {
    return Category(
      id: json['id'] as int?,
      title: json["title"] as String?,
    );
  }

  int getTabsNumber() {
    int count = 1;
    if (haveTools ?? true) count += 1;
    if (haveGuides == true || haveVideos == true || haveFaqs == true)
      count += 1;
    return count;
  }

  int getGuidesTabsNumber() {
    int count = 0;
    if (haveGuides == true) count += 1;
    if (haveVideos == true) count += 1;
    if (haveFaqs == true) count += 1;
    return count;
  }
}
