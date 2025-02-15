import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_expansion_tile.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';

class FaqRowItem extends StatefulWidget {
  final Faq faq;
  final Function(bool status) toggleExpand;
  final bool expanded;
  bool hasTitle;
  FaqRowItem({
    required this.faq,
    required this.toggleExpand,
    this.expanded = false,
    this.hasTitle = false,
  });
  @override
  _FaqRowItemState createState() => _FaqRowItemState();
}

class _FaqRowItemState extends State<FaqRowItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      key: ValueKey(widget.faq.id),
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.expanded ? AppColors.Tea_green : AppColors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            new BoxShadow(
              color: AppColors.SHADOW_GREY,
              blurRadius: 5.0,
            ),
          ],
          color: widget.expanded ? AppColors.Tea_green : AppColors.white),
      width: MediaQuery.of(context).size.width,
      child: CustomExpansionTile(
        maintainState: false,
        initiallyExpanded: widget.expanded,
        trailing: widget.expanded
            ? Icon(Icons.remove, size: 30)
            : Icon(Icons.add, size: 30),
        iconColor: AppColors.Olive_Drab,
        collapsedIconColor: AppColors.Olive_Drab,
        backgroundColor: Colors.transparent,
        tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        collapsedBackgroundColor: Colors.transparent,
        onExpansionChanged: (status) {
          // setState(() {
          widget.toggleExpand(status);
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: "${widget.faq.question}",
              textColor: widget.expanded
                  ? AppColors.Olive_Drab
                  : AppColors.Dark_spring_green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            if (widget.hasTitle)
              CustomText(
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                title: widget.faq.parentCategoryTitle ?? "",
                textColor: widget.expanded
                    ? AppColors.Olive_Drab
                    : AppColors.Dark_spring_green,
                fontSize: 14,
              ),
          ],
        ),
        children: <Widget>[
          // widget.expanded
          // ?
          Container(
            color: AppColors.Tea_green,
            child: Container(
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: CustomText(
                  textAlign: TextAlign.start,
                  title: "${widget.faq.answer}",
                  textColor: AppColors.Dark_spring_green,
                  //fontSize: 12,
                )),
          )
          // : Container(),
        ],
      ),
    );
  }
}
