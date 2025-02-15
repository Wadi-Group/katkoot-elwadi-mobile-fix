import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class WhereToFindUsSupplierItem extends StatelessWidget {
  final Supplier? supplier;

  const WhereToFindUsSupplierItem({required this.supplier}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          new BoxShadow(
            color: AppColors.SHADOW_GREY,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDataItem('name'.tr(),[supplier?.name ?? '']),
                flex: 1,
              ),
              Expanded(
                child: _buildDataItem('phone'.tr(),supplier?.phones,isPhone: true),
                flex: 1,
              ),
            ],
          ),
          SizedBox(height: 15,),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: _buildDataItem('area'.tr(), (supplier?.cities ?? []).map((e) => e.name ?? '').toList()),
          //       flex: 1,
          //     ),
          //     Expanded(
          //       child: _buildDataItem('specialty'.tr(),supplier?.specialties),
          //       flex: 1,
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDataItem('category'.tr(), [supplier?.category?.title ?? '']),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildDataItem(String? title,List<String>? values,{bool? isPhone}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          padding: EdgeInsets.only(bottom: 5),
          title: title ?? '',
          textColor: AppColors.Dark_spring_green,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: values?.length ?? 0,
          itemBuilder: (context, index) => GestureDetector(
            child: CustomText(
              title: values?[index] ?? '',
              textColor: AppColors.Liver,
              fontSize: 14,
            ),
            onTap:()=> (isPhone ?? false) ? launch("tel:${values?[index] ?? ''}") : null,
          ),
        )
      ],
    );
  }
}
