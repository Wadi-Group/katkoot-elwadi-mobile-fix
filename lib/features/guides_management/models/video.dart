import 'dart:convert';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';

class Video {
  int? id;
  String? title;
  Url? url;
  int? parentCategoryId;
  int? parentId;
  String? parentCategoryTitle;
  String? lft;
  String? rgt;
  String? depth;

  Video(
      {this.id,
      this.title,
      this.parentCategoryId,
      this.parentId,
      this.parentCategoryTitle,
      this.lft,
      this.depth,
      this.url,
      this.rgt});

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
        parentCategoryTitle: json["parent_category_title"]);
  }
}
