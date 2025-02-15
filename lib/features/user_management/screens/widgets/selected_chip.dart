import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

class SelectedChip extends StatelessWidget {
  Category category;
  Function onTap;
  SelectedChip({required this.category, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(category.title);
        onTap();
      },
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
        margin: EdgeInsetsDirectional.only(end: 5),
        decoration: BoxDecoration(
          color: AppColors.Olive_Drab.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            CustomText(
              title: category.title!,
              textColor: AppColors.white,
            ),
            Icon(
              Icons.close,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
