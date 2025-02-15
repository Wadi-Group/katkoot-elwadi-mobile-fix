import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';

class ToolRowItem extends StatelessWidget {
  Tool tool;
  Function onTap;
  bool hasTitle;
  bool? isElite;
  ToolRowItem(
      {required this.tool,
      required this.onTap,
      this.isElite = false,
      this.hasTitle = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: AppColors.APPLE_GREEN.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    title: tool.title!,
                    maxLines: 5,
                    textColor: AppColors.Dark_spring_green,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  if (hasTitle)
                    CustomText(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                      title: tool.category?.title ?? "",
                      textColor: AppColors.Dark_spring_green,
                      fontSize: 14,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            isElite == false
                ? Icon(
                    Icons.chevron_right_sharp,
                    color: AppColors.Ash_grey,
                  )
                : Image.asset("assets/images/elite_logo.png"),
          ],
        ),
      ),
    );
  }
}
