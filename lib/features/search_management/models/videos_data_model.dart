
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class VideosDataModel {
  List<Video>? videos;
  bool? hasMore;

  VideosDataModel(
      {this.videos,this.hasMore});

  VideosDataModel.fromJson(Map<String, dynamic> json) {
    Iterable videosIterable = json['items'] ?? [];

    videos =
    List<Video>.from(videosIterable.map((model) => Video.fromJson(model)));
    hasMore = json['has_more'];
  }
}
