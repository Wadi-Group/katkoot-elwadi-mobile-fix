import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class RearingViewTableRowItem extends StatelessWidget {
  final String? title;
  final Object? actual, standard;
  bool? hasDecimal;
  RearingViewTableRowItem(
      {this.title, this.actual, this.standard, this.hasDecimal = false});

  @override
  Widget build(BuildContext context) {
    return buiTableHeader(context);
  }

  Widget buiTableHeader(BuildContext context) {
    print(context.locale.languageCode);
    var formatter = NumberFormat.decimalPattern(context.locale.languageCode);

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 0, left: 12, right: 12),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.Tea_green.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: CustomText(
              textColor: AppColors.Dark_spring_green,
              title: title ?? "",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textOverflow: TextOverflow.visible),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: new BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                new BoxShadow(
                  color: AppColors.SHADOW_GREY,
                  blurRadius: .5,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  textColor: AppColors.Dark_spring_green,
                  title:
                      "${actual != null ? formatter.format(double.parse(double.parse(actual.toString()).toStringAsFixed(hasDecimal! ? 2 : 0))) : 0.00}",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        (standard != null)
            ? Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: new BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: AppColors.SHADOW_GREY,
                        blurRadius: .5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CustomText(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      maxLines: 1,
                      textColor: AppColors.Dark_spring_green,
                      title:
                          "${standard != null ? formatter.format(double.parse(double.parse(actual.toString()).toStringAsFixed(hasDecimal! ? 2 : 0))) : 0.00}",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      textOverflow: TextOverflow.visible),
                ),
              )
            : Expanded(child: Container()),
      ]),
    );
  }
}
