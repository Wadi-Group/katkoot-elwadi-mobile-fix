import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class MenuVideoRowItem extends StatelessWidget {
  final Video? video;
  final Function onTap;

  const MenuVideoRowItem({required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var videoImageHeight = MediaQuery.of(context).size.width * 0.2;
    return GestureDetector(
      onTap: () => onTap(video),
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            new BoxShadow(
              color: AppColors.SHADOW_GREY,
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
                height: videoImageHeight,
                width: videoImageHeight,
                child: Stack(
                    children: [
                      Image.network(
                        video?.url?.image ?? '',
                        fit: BoxFit.fill,
                        width: videoImageHeight,
                        height: videoImageHeight,
                      ),
                      Center(
                          child: Container(child: ImageIcon(
                            AssetImage("assets/images/ic_play_video.png"),
                            color: AppColors.white,
                            size: 25,
                          ),))
                      ,
                    ]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomText(
                  maxLines: 2,
                  title: video?.title.toString() ?? '',
                  fontSize: 16,
                  lineSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.Dim_gray,
                  padding: EdgeInsets.all(5),
                  textAlign: TextAlign.start,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
