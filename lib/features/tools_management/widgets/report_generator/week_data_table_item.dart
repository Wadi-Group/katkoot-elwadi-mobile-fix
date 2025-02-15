import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class WeekDataTableItem extends StatelessWidget {
  final  String? title , value, standard;

  const WeekDataTableItem({required this.title,required this.value,required this.standard});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Container(
                color: AppColors.Tea_green,
                child: Center(
                  child: CustomText(
                    title: title ?? '',
                    textColor: AppColors.Dark_spring_green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                color: AppColors.Light_Tea_green,
                child: Center(
                  child: CustomText(
                    title: value ?? '',
                    textColor: AppColors.Liver,
                    fontSize: 14,
                    padding: EdgeInsets.all(7),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Container(
                color: AppColors.Light_Tea_green,
                child: Center(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    title: standard ?? '',
                    textColor: AppColors.Liver,
                    fontSize: 14,
                    padding: EdgeInsets.all(7),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
