import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/category_management/screens/category_details_base_screen_modification.dart';

class CategoryTabWidget extends StatelessWidget {
  final Category category;

  CategoryTabWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                CategoryDetailsBaseScreenModification(category: category),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          clipBehavior: Clip.none, // Allows the image to overflow
          children: [
            _buildCard(context),
            _buildCategoryImage(context),
          ],
        ),
      ),
    );
  }

  /// Builds the main category card
  Widget _buildCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.12
          : MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildSideContainer(context),
          _buildTextContent(context),
          Icon(Icons.chevron_right_outlined,
              color: AppColors.APP_BLUE, size: 40),
        ],
      ),
    );
  }

  /// Builds the colored side container
  Widget _buildSideContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: AppColors.APP_BLUE,
        borderRadius: context.locale.languageCode == "en"
            ? BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
    );
  }

  /// Builds the text content inside the card
  Widget _buildTextContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: category.title ?? " ",
              fontWeight: FontWeight.w600,
              fontSize: 18,
              maxLines: 2,
              textColor: AppColors.DARK_SPRING_GREEN,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            CustomText(
              title: category.subTitle ?? " ",
              fontSize: 16,
              fontFamily: 'Arial',
              textOverflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
              textColor: AppColors.APPLE_GREEN,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the category image positioned above the card
  Widget _buildCategoryImage(BuildContext context) {
    return Positioned(
      top: -20, // Moves the image 10 pixels above the card
      left: context.locale.languageCode == "en" ? 0 : null,
      right: context.locale.languageCode != "en" ? 0 : null,
      child: CachedNetworkImage(
        fit: BoxFit.fitHeight,
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.height * 0.15,
        imageUrl: category.imageUrl!,
      ),
    );
  }
}
