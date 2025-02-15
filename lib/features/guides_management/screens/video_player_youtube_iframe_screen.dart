import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:io' show Platform;

class VideoPlayerYouTubeIframeScreen extends StatefulWidget {
  static const routeName = "./videos_player";

  final Url url;

  const VideoPlayerYouTubeIframeScreen({required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerYouTubeIframeScreen> {
  FlickManager? flickManager;
  YoutubePlayerController? youtubeController;

  bool isYoutube = false;

  @override
  void initState() {
    //enterFullScreen();
    if (widget.url.url != null) {
      if (widget.url.provider == AppConstants.YOUTUBE_PROVIDER) {
        isYoutube = true;
        String? id = YoutubePlayerController.convertUrlToId(widget.url.url!);
        if (id != null) {
          youtubeController = YoutubePlayerController(
            params: const YoutubePlayerParams(
              loop: true,
              showControls: true,
              //showFullscreenButton: true,
              strictRelatedVideos: true,
              showVideoAnnotations: false,
            ),
          )
            ;
            // ..onInit = () {
            //   youtubeController?.loadVideoById(videoId: id);
            // }
            // ..onFullscreenChange = (isFullScreen) {
            //   if (isFullScreen) {
            //     SystemChrome.setPreferredOrientations([
            //       DeviceOrientation.landscapeLeft,
            //       DeviceOrientation.landscapeRight,
            //     ]);
            //     print('Entered Fullscreen');
            //   } else {
            //     resetOrientation();
            //   }
            // };
        }
      } else {
        isYoutube = false;
        flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(widget.url.url!),
        );
      }
    }

    super.initState();
  }

  Future resetOrientation() async {
    await Future.delayed(Duration.zero, () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });
  }

  enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() async {
    flickManager?.dispose();
    youtubeController?.close();

    resetOrientation();
    //SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isYoutube) {
      return Container(
        child: flickManager != null
            ? FlickVideoPlayer(flickManager: flickManager!)
            : Container(),
      );
    } else {
      return youtubeController != null
          ? SafeArea(
            child: GestureDetector(
              onTap: () {
                AppConstants.navigatorKey.currentState?.pop();
              },
              child: Material(
                color: AppColors.black,
                child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Center(child: YoutubePlayer(
                        controller: youtubeController ?? YoutubePlayerController(),  
                      )),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              AppConstants.navigatorKey.currentState?.pop();
                            },
                            icon: Container(
                              padding: EdgeInsetsDirectional.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.Pastel_gray.withOpacity(
                                      0.5)),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ]),
              ),
            ),
          )
          : Container();
    }
  }

  void deactivate() {
    // Pauses video while navigating to next page.
    youtubeController?.pauseVideo();

    super.deactivate();
  }
}
