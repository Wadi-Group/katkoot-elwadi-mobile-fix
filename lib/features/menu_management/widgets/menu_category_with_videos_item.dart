import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/guides_management/screens/video_player_youtube_iframe_screen.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/menu_video_item.dart';

class MenuCategoryWithVideosItem extends StatefulWidget {
  final Category? category;

  const MenuCategoryWithVideosItem({required this.category});

  @override
  _MenuCategoryWithVideosItemState createState() =>
      _MenuCategoryWithVideosItemState();
}

class _MenuCategoryWithVideosItemState
    extends State<MenuCategoryWithVideosItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Title (Expandable)
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.APP_CARDS_BLUE.withAlpha(25),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: Offset(1, 2),
                )
              ],
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.category?.title ?? '', // Category title
                          style: TextStyle(
                            color: AppColors.Dark_spring_green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: context.locale.toString() == 'en'
                                ? "Arial"
                                : "GE_SS_Two",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.Dark_spring_green,
                ),
              ],
            ),
          ),
        ),

        // Video List (Collapsible)
        if (_isExpanded && (widget.category?.videosList?.isNotEmpty ?? false))
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.category?.videosList?.length,
            itemBuilder: (context, index) => MenuVideoRowItem(
              onTap: (video) {
                AppConstants.navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerYouTubeIframeScreen(
                      url: widget.category?.videosList?[index].url ?? Url(),
                    ),
                  ),
                );
              },
              video: widget.category?.videosList?[index],
            ),
          ),
      ],
    );
  }
}
