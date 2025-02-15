import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

class CategoryDetailsScreen extends ConsumerWidget {
  final Category category;
  static const routeName = "./category_details_screen";
  const CategoryDetailsScreen({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
            width * 0.05, height * 0.05, width * 0.05, height * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.4,
                  imageUrl: category.imageUrl!,
                  placeholder: (context, url) {
                    return Image.asset('assets/images/ic_placeholder.png');
                  },
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          title: category.title!,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          textColor: AppColors.DARK_SPRING_GREEN,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          maxLines: 6,
                          textColor: AppColors.Liver,
                          title: category.subTitle!,
                          fontSize: 10,
                          fontFamily: 'Arial',
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            CustomText(
                lineSpacing: 1.5,
                maxLines: 100,
                textAlign: TextAlign.start,
                title: category.description.toString(),
                fontSize: 17)
          ],
        ),
      ),
    );
  }
}
