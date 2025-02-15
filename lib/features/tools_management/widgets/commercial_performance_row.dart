import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/models/column.dart'
    as Coll;
import 'package:katkoot_elwady/features/tools_management/models/tool_section.dart';

class CommercialPerformanceRow extends StatelessWidget {
  final ToolSection? section;

  CommercialPerformanceRow({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buiTableHeader(context),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: section?.data?.length,
              itemBuilder: (context, index) =>
                  ParentFlockRequirementRowItem(column: section?.data?[index])),
        ),
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
              title: (section?.showColumnTitle ?? false)
                  ? (section?.columns?.requirement ?? "")
                  : '',
              fontSize: 14,
              textOverflow: TextOverflow.visible),
        ),
        Expanded(
          // child: CustomText(
          //     textColor: AppColors.Dark_spring_green,
          //     title:  (section?.showColumnTitle ?? false) ? (section?.columns?.value ?? "") : '' ,
          //     fontSize: 14,
          //     fontWeight: FontWeight.bold,
          //     textAlign: TextAlign.center,
          //     textOverflow:TextOverflow.visible
          // ),
          child: Container(),
        )
      ]),
    );
  }
}

class ParentFlockRequirementRowItem extends StatelessWidget {
  final Coll.Column? column;

  const ParentFlockRequirementRowItem({required this.column});

  @override
  Widget build(BuildContext context) {
    return buiTableRow(context, column);
  }

  Widget buiTableRow(BuildContext context, Coll.Column? column) {
    if (column == null) return Container();
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 5),
      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.Light_Tea_green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Row(children: [
        Expanded(
          child: CustomText(
              fontWeight: FontWeight.bold,
              textColor: AppColors.Dark_spring_green,
              title: column.requirement ?? "",
              fontSize: 14,
              textOverflow: TextOverflow.visible),
        ),
        Expanded(
          child: CustomText(
            textOverflow: TextOverflow.visible,
            textColor: AppColors.Liver,
            title: column.value ?? "",
            textAlign: TextAlign.center,
            fontSize: 14,
          ),
        )
      ]),
    );
  }
}
