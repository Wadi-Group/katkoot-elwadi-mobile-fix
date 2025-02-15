import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/guides_management/screens/video_player_youtube_iframe_screen.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/menu_video_item.dart';

class MenuCategoryWithVideosItem extends StatelessWidget {
  final Category? category;

  const MenuCategoryWithVideosItem({required this.category}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.Tea_green,
              ),
              color: AppColors.Tea_green,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: CustomText(
            padding: EdgeInsets.all(5),
            textAlign: TextAlign.center,
            title: "${category?.title ?? ''}",
            textColor: AppColors.Dark_spring_green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if(category?.videosList?.isNotEmpty ?? false)
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category?.videosList?.length,
              itemBuilder: (context, index) => MenuVideoRowItem(
                  onTap: (video) {
                    AppConstants.navigatorKey.currentState?.push(
                      MaterialPageRoute(builder: (context) => VideoPlayerYouTubeIframeScreen(url: category?.videosList?[index].url ?? Url()))
                    );

                    //Navigator.of(context)..pushNamed(VideoPlayerYouTubeIframeScreen.routeName,arguments: category?.videosList?[index].url);
                  },
                  video: category?.videosList?[index]
              ),
            ),
          ),
      ],
    );
  }
}
