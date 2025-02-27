import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';
import 'package:share_plus/share_plus.dart';

import '../../app_base/widgets/app_text_field.dart';

class MenuVideoRowItem extends StatefulWidget {
  final Video? video;
  final Function onTap;

  const MenuVideoRowItem({required this.video, required this.onTap});

  @override
  State<MenuVideoRowItem> createState() => _MenuVideoRowItemState();
}

class _MenuVideoRowItemState extends State<MenuVideoRowItem> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            maxLines: 2,
            title: widget.video?.title.toString() ?? '',
            fontSize: 18,
            lineSpacing: 1.2,
            fontWeight: FontWeight.w400,
            textColor: AppColors.APP_BLUE,
            padding: EdgeInsets.all(5),
            textAlign: TextAlign.start,
            textOverflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(widget.video),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
                            spreadRadius: .5,
                            blurRadius: 1,
                            offset: Offset(1, 2),
                          )
                        ]),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          widget.video?.url?.image ?? '',
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
              ),
              SizedBox(width: 5),
              IconColumn(
                onLikeTap: () {
                  print("onLikeTap");
                },
                onCommentTap: () {
                  print("onCommentTap");
                  _commentFocusNode.requestFocus();
                },
                onShareTap: () {
                  print("onShareTap");
                  Share.share(widget.video?.url?.url ?? '',
                      subject: widget.video?.title.toString() ?? '');
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          // add comment
          Padding(
            padding: context.locale.languageCode == "en"
                ? const EdgeInsets.only(right: 45)
                : const EdgeInsets.only(right: 45.0),
            child: CustomTextField(
              borderRadius: 30,
              hintText: "write_comment".tr(),
              controller: _commentController,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              focusNode: _commentFocusNode,
              endWidget: IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppColors.APP_BLUE,
                ),
                onPressed: () {
                  print(_commentController.text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconColumn extends StatelessWidget {
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;

  const IconColumn({
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIcon("assets/images/like.png", onLikeTap),
        SizedBox(height: MediaQuery.of(context).size.width * .05),
        _buildIcon("assets/images/comment.png", onCommentTap),
        SizedBox(height: MediaQuery.of(context).size.width * .05),
        _buildIcon("assets/images/login.png", onShareTap),
      ],
    );
  }

  Widget _buildIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: ImageIcon(
            AssetImage(assetPath),
            color: AppColors.APP_BLUE,
            size: 20,
          ),
        ),
      ),
    );
  }
}
