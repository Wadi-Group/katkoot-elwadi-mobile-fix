import 'package:katkoot_elwady/features/guides_management/models/guide.dart';

class GuidesDataModel {
  List<Guide>? guides;
  bool? hasMore;

  GuidesDataModel(
      {this.guides,this.hasMore});

  GuidesDataModel.fromJson(Map<String, dynamic> json) {
    Iterable guidesIterable = json['items'] ?? [];

    guides =
    List<Guide>.from(guidesIterable.map((model) => Guide.fromJson(model)));
    hasMore = json['has_more'];
  }
}
