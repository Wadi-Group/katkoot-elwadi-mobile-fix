import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

class ToolCategoryHeader extends StatelessWidget {
  final Category? category;
  const ToolCategoryHeader({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CachedNetworkImage(
          fit: BoxFit.fill,
          height: 50,
          width: 50,
          imageUrl: category?.imageUrl ?? '',
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 14, bottom: 2, left: 12, right: 12),
            child: CustomText(
              textAlign: TextAlign.start,
              maxLines: 3,
              title: category?.subTitle ?? "",
              fontWeight: FontWeight.w700,
              fontSize: 15,
              fontFamily: 'Arial',
              textColor: AppColors.black,
            ),
          ),
        ),
      ]),
    );
    ;
  }
}
