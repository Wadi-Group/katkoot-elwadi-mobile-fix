import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class VideoRowItem extends StatelessWidget {
  final Video? video;
  final Function onTap;
  bool hasTitle;

  VideoRowItem({
    required this.video,
    required this.onTap,
    this.hasTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var videoImageHeight = MediaQuery.of(context).size.width *
        ((orientation == Orientation.portrait) ? 0.3 : .2);

    return GestureDetector(
      onTap: () => onTap(video),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            new BoxShadow(
              color: AppColors.white_smoke,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        height: videoImageHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: videoImageHeight,
                  height: videoImageHeight,
                  color: AppColors.white_smoke,
                  child: Stack(
                    children: [
                      Image.network(
                        video?.url?.image ?? '',
                        fit: BoxFit.fill,
                        width: videoImageHeight,
                        height: videoImageHeight,
                      ),
                      Center(
                          child: Container(
                        child: ImageIcon(
                          AssetImage("assets/images/ic_play_video.png"),
                          color: AppColors.white,
                          size: 25,
                        ),
                      ))
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      lineSpacing: 1.5,
                      maxLines: 5,
                      title: video?.title ?? '',
                      fontSize: 18,
                      textColor: AppColors.Liver,
                      padding: EdgeInsets.all(5),
                      textAlign: TextAlign.start,
                    ),
                    if (hasTitle)
                      CustomText(
                        title: video!.parentCategoryTitle ?? "",
                        fontSize: 14,
                        textColor: AppColors.Dark_spring_green,
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                        fontFamily: "Arial",
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              // SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
