import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class ProductionBaseTableRowItem extends StatelessWidget {
 final  String? title , value;
  const ProductionBaseTableRowItem({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: AppColors.Tea_green.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(2))
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              title:title ?? "",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: AppColors.DARK_SPRING_GREEN,
            ),
          ),
          SizedBox(width: 10,),
         Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Container(
                  decoration: new BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: AppColors.SHADOW_GREY,
                        blurRadius:
                        .5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4),
                  ),
                child:CustomText(
                  padding: EdgeInsets.all(10),
                  title: value ?? "",
                  fontSize: 14,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.Liver,
                ),
              ),

          )
        ],
      ),
    );
  }
}
