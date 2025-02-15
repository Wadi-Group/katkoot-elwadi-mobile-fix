import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import '../../../../core/di/injection_container.dart' as di;
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CustomDialog extends StatefulWidget {
  List<MultiSelectItem<Category?>> items;
  List<MultiSelectItem<Category?>> selectedCategories;
  Function onTap;
  Function? onChange;

  CustomDialog(
      {required this.items,
      required this.selectedCategories,
      required this.onTap,
      this.onChange});
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: widget.items.map((val) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTap();

                          setState(() {
                            if (widget.selectedCategories.indexWhere(
                                    (element) => element.label == val.label) !=
                                -1) {
                              widget.selectedCategories.removeWhere(
                                  (element) => element.label == val.label);
                            } else {
                              widget.selectedCategories.add(val);
                            }
                          });
                          if (widget.onChange != null) {
                            widget.onChange!(widget.selectedCategories
                                .map((e) => e.value!)
                                .toList());
                          }
                        },
                        child: Row(
                          children: [
                            new Checkbox(
                              activeColor: AppColors.Dark_spring_green,
                              checkColor: AppColors.white,
                              value: widget.selectedCategories.indexWhere(
                                      (element) =>
                                          element.label == val.label) !=
                                  -1,
                              onChanged: (value) {
                                widget.onTap();
                                setState(() {
                                  if (widget.selectedCategories.indexWhere(
                                          (element) =>
                                              element.label == val.label) !=
                                      -1) {
                                    widget.selectedCategories.removeWhere(
                                        (element) =>
                                            element.label == val.label);
                                  } else {
                                    widget.selectedCategories.add(val);
                                  }
                                  if (widget.onChange != null) {
                                    widget.onChange!(widget.selectedCategories
                                        .map((e) => e.value!)
                                        .toList());
                                  }
                                });
                              },
                            ),
                            Expanded(child: CustomText(title: val.label))
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
