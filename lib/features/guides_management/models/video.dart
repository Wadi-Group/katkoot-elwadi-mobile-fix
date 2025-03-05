import 'dart:convert';
import 'package:hive/hive.dart';
import 'url.dart'; // Ensure `Url` model is also Hive-compatible

part 'video.g.dart'; // Required for Hive code generation

@HiveType(typeId: 17) // Ensure unique typeId across models
class Video extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  Url? url;

  @HiveField(3)
  int? parentCategoryId;

  @HiveField(4)
  int? parentId;

  @HiveField(5)
  String? parentCategoryTitle;

  @HiveField(6)
  String? lft;

  @HiveField(7)
  String? rgt;

  @HiveField(8)
  String? depth;

  Video({
    this.id,
    this.title,
    this.parentCategoryId,
    this.parentId,
    this.parentCategoryTitle,
    this.lft,
    this.depth,
    this.url,
    this.rgt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json["title"],
      url: (json['url'] != null && json['url'].toString().isNotEmpty)
          ? Url.fromJson(jsonDecode(json['url']))
          : null,
      parentCategoryId: json["parent_category_id"],
      parentId: json["parent_id"],
      lft: json["lft"],
      rgt: json["rgt"],
      depth: json["depth"],
      parentCategoryTitle: json["parent_category_title"],
    );
  }
}
