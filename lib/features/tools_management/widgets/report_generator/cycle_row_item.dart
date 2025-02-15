import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/widgets/confirmation_dialog.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_cycle_data.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/cycle_context_menu_item.dart';

class CycleRowItem extends StatefulWidget {
  final Cycle cycle;
  final Function onTap;
  final Function onDelete;
  final Function onViewData;

  const CycleRowItem(
      {required this.cycle,
      required this.onTap,
      required this.onDelete,
      required this.onViewData});

  @override
  State<CycleRowItem> createState() => _CycleRowItemState();
}

class _CycleRowItemState extends State<CycleRowItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.cycle),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.white,
            boxShadow: [
              new BoxShadow(
                color: AppColors.SHADOW_GREY,
                blurRadius: 5.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${widget.cycle.farmName} | ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Liver,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${widget.cycle.location}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.Dark_spring_green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        fontWeight: FontWeight.w400,
                        title: "${widget.cycle.getDateFormatted()}",
                        fontSize: 14,
                        textColor: AppColors.Liver,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // CustomText(
                      //   title: video.url!.title!,
                      //   fontSize: 14,
                      //   textColor: AppColors.Liver,
                      //   padding: EdgeInsets.all(5),
                      //   fontFamily: "Arial",
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 35,
                height: 80,
                padding: EdgeInsets.all(0),
                color: AppColors.Olive_Drab,
                child: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case "view":
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewCycleData(
                                  cycle: widget.cycle,
                                )));

                        break;

                      case "delete":
                        ConfirmationDialog.show(
                          btnRadiusCorners: 30,
                          context: context,
                          title: 'delete_cycle'.tr(),
                          message: 'delete_cycle_message'.tr(),
                          confirmText: 'delete'.tr(),
                          cancelText: 'str_cancel'.tr(),
                          onConfirm: () async {
                            this.widget.onDelete();
                          },
                          //onCancel: () => Navigator.of(context).pop()
                        );

                        break;

                      case "data":
                        this.widget.onViewData();
                        break;

                      case "manage":
                        widget.onTap(widget.cycle);
                        break;
                      default:
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: AppColors.white,
                    ),
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                        value: "view",
                        child: CycleContextMenuItem(
                          title: 'view_cycle'.tr(),
                          icon: Icons.remove_red_eye_outlined,
                        )),
                    PopupMenuItem<String>(
                        value: "delete",
                        child: CycleContextMenuItem(
                            icon: Icons.delete_outlined,
                            title: 'delete_cycle'.tr())),
                    PopupMenuItem<String>(
                      value: "data",
                      child: CycleContextMenuItem(
                          icon: Icons.remove_red_eye_outlined,
                          title: 'view_data'.tr()),
                    ),
                    PopupMenuItem<String>(
                      value: "manage",
                      child: CycleContextMenuItem(
                        icon: Icons.content_paste_outlined,
                        title: 'manage_weeks'.tr(),
                        hasUnderLine: false,
                      ),
                    ),
                  ],
                ),
              ),

              // SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
