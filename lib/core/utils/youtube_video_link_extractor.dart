import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeVideoLinkExtarctor {

  static String _getVideoId(String url) {
    try {
      return url.substring(url.indexOf('?v=')+3);
    } catch (e) {
      return '';
    }
  }

  static Future<String> extractVideoUrl(String youTubeUrl) async {
    final extractor = YoutubeExplode();
    final videoId = _getVideoId(youTubeUrl);
    print(videoId);
    final streamManifest = await extractor.videos.streamsClient.getManifest(videoId);
    final streamInfo = streamManifest.muxed.sortByVideoQuality().last;
    //final streamInfo = streamManifest.muxed.withHighestBitrate();


    extractor.close();
    return streamInfo.url.toString();

  }

   static Future<String?> getVideoThumbnail(String youTubeUrl) async {
    final extractor = YoutubeExplode();
    var video = await extractor.videos.get(youTubeUrl); // Returns a Video instance.
  print(video.thumbnails.standardResUrl);
  String thumbnail =  video.thumbnails.highResUrl;
if (thumbnail.contains("sddefault")) {

  thumbnail.replaceRange((thumbnail.length -11) , (thumbnail.length -9), "");
}
return thumbnail;
    

   }
}
