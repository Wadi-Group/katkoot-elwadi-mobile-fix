import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/category_management/screens/category_details_base_screen_modification.dart';

class CategoryTabWidget extends StatelessWidget {
  final Category category;

  // final Function onTap;
  CategoryTabWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(CategoryDetailsBaseScreen.routeName,
        //     arguments: category);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return CategoryDetailsBaseScreenModification(category: category);
            })
        );
      },
      child: OrientationBuilder(builder: (context, orientation) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.18
              : MediaQuery.of(context).size.height * 0.35,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.15
                          : MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: AppColors.APPLE_GREEN,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.08
                                  : MediaQuery.of(context).size.height * 0.16)),
                    ),
                    Positioned(
                        left: context.locale.languageCode != "en" ? null : 0,
                        right: context.locale.languageCode != "en" ? 0 : null,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.15
                                  : MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.15
                                  : MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  color: AppColors.OLIVE_DRAB,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.15)),
                            ),
                          ],
                        )),
                    Positioned(
                        right: context.locale.languageCode != "en" ? null : 0,
                        left: context.locale.languageCode != "en" ? 0 : null,
                        child: Container(
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.15
                              : MediaQuery.of(context).size.height * 0.3,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.15
                              : MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.15)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Positioned(
                        left: context.locale.languageCode != "en"
                            ? null
                            : MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.16
                                : MediaQuery.of(context).size.height * 0.32,
                        right: context.locale.languageCode != "en"
                            ? MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.16
                                : MediaQuery.of(context).size.height * 0.32
                            : null,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.25
                              : MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CustomText(
                                  title: category.title != null
                                      ? category.title!
                                      : " ",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  maxLines: 2,
                                  lineSpacing: 1.1,
                                  textColor: AppColors.DARK_SPRING_GREEN,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CustomText(
                                  title: category.subTitle != null
                                      ? category.subTitle!
                                      : " ",
                                  fontSize: 13,
                                  fontFamily: 'Arial',
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Positioned(
                bottom:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.025
                        : MediaQuery.of(context).size.height * 0.05,
                left: context.locale.languageCode != "en"
                    ? null
                    : MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.015
                        : MediaQuery.of(context).size.height * 0.03,
                right: context.locale.languageCode != "en"
                    ? MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.015
                        : MediaQuery.of(context).size.height * 0.03
                    : null,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.14
                          : MediaQuery.of(context).size.height * 0.28,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.12
                          : MediaQuery.of(context).size.height * 0.25,
                  imageUrl: category.imageUrl!,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
