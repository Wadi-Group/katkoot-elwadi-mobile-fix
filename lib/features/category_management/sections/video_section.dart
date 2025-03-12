// ============================= VIDEO SECTION =============================
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../app_base/widgets/custom_text.dart';
import '../../guides_management/screens/video_player_youtube_iframe_screen.dart';
import '../../menu_management/screens/categorized_videos_screen.dart';

class VideoSection extends StatelessWidget {
  const VideoSection({Key? key, this.video}) : super(key: key);
  final Category? video;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MenuCategorizedVideosScreen();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: CustomText(
                title: "videos".tr(),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                textColor: AppColors.APP_BLUE,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            AppConstants.navigatorKey.currentState?.push(MaterialPageRoute(
                builder: (context) => VideoPlayerYouTubeIframeScreen(
                    url: video?.videosList?[0].url ?? Url())));
          },
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    getThumbnailUrl(video?.videosList?[0].url?.url)),
                fit: BoxFit.cover,
              ),
              color: AppColors.Ash_grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Icon(Icons.play_circle_filled, size: 60, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

String getThumbnailUrl(String? youtubeUrl) {
  final Uri uri = Uri.parse(youtubeUrl ?? "");
  if (uri.queryParameters.containsKey('v')) {
    return "https://img.youtube.com/vi/${uri.queryParameters['v']}/hqdefault.jpg";
  }
  return "https://placehold.co/600x400"; // Fallback image
}
