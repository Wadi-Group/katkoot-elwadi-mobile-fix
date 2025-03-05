import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../guides_management/screens/video_player_youtube_iframe_screen.dart';

class CarouselSliderVideosSection extends StatelessWidget {
  final List<Video> videos;

  CarouselSliderVideosSection({required this.videos});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: .6,
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
        clipBehavior: Clip.antiAlias,
      ),
      items: videos.map((video) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(AppConstants.navigatorKey.currentContext!)
                  ..pushNamed(VideoPlayerYouTubeIframeScreen.routeName,
                      arguments: video.url);
              },
              child: Container(
                padding: EdgeInsets.all(0.0),
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        video.url?.image ?? '',
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Center(
                        child: Container(
                          child: ImageIcon(
                            AssetImage("assets/images/ic_play_video.png"),
                            color: AppColors.white.withValues(alpha: 0.7),
                            size: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
