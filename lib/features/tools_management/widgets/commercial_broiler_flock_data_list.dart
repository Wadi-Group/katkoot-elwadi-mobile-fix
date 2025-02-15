import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool_section.dart';

class CommercialBroilerFlockDataListView extends StatelessWidget {
  final ToolSection? section;

  CommercialBroilerFlockDataListView({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buiTableHeader(context),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: section?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 5),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                color: AppColors.Light_Tea_green,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomText(
                      fontSize: 15,
                      title: section?.data?[index].requirement ?? '',
                      textColor: AppColors.DARK_SPRING_GREEN,
                      fontWeight: FontWeight.bold,
                      textOverflow: TextOverflow.visible,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomText(
                            title:
                                (section?.data?[index].requirement == "Flow" ||
                                        section?.data?[index].requirement ==
                                            "ضغط الماء")
                                    ? (section?.data?[index].value ?? "") +
                                        "ml/s".tr()
                                    : (section?.data?[index].value ?? '')
                                        .replaceAll('%', ' % '),
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            textOverflow: TextOverflow.visible)),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget buiTableHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 0, left: 12, right: 12),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.Tea_green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(children: [
        Expanded(
          child: CustomText(
              textColor: AppColors.Dark_spring_green,
              title: section?.sectionName ?? "",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textOverflow: TextOverflow.visible),
        ),
        Expanded(
          child: CustomText(
              textColor: AppColors.Dark_spring_green,
              title: (section?.showColumnTitle ?? false)
                  ? (section?.columns?.value ?? "")
                  : '',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.visible),
        )
      ]),
    );
  }
}
