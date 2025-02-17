import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/models/edit_profile_data.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/edit_profile_view_model.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/screens/widgets/customDialog.dart';
import 'package:katkoot_elwady/features/user_management/screens/widgets/selected_chip.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../core/di/injection_container.dart' as di;

class CategoryDropDown extends StatefulWidget {
  List<Category>? categories;
  Function onChange;
  AutoDisposeProvider<List<UserFormsErrors>> errorProvider;
  // Category? selectedCategory;
  List<MultiSelectItem<Category?>>? selectedCategories;
  CategoryDropDown(
      {this.categories,
      required this.onChange,
      this.selectedCategories,
      required this.errorProvider}) {
    print("widget cat");
    print(selectedCategories!.length);
    if (selectedCategories == null) {
      selectedCategories = [];
    }
  }

  @override
  _CategoryDropDownState createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  final editProfileProvider =
      StateNotifierProvider<EditProfileViewModel, BaseState<EditProdileData?>>(
          (ref) {
    return EditProfileViewModel(ref.read(di.repositoryProvider));
  });
  final authViewProvider =
      StateNotifierProvider<AuthViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return AuthViewModel(ref.read(di.repositoryProvider));
  });
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final errors = ref.watch(widget.errorProvider);
      var error = errors
          .firstWhere((element) => element.field == UserFields.CATEGORY.field,
              orElse: () => UserFormsErrors())
          .message;
      print("error $error");
      var categoriesList =
          widget.categories!.map((e) => MultiSelectItem(e, e.title!)).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showMultiSelect(context, categoriesList),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.APP_CARDS_BLUE.withAlpha(25),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: Offset(1, 2),
                    )
                  ]),
              child: widget.selectedCategories!.isEmpty
                  ? Container(
                      padding: widget.selectedCategories!.isEmpty
                          ? EdgeInsetsDirectional.only(top: 10, bottom: 10)
                          : null,
                      child: CustomText(
                        title: 'choose_category'.tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.Liver,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...widget.selectedCategories!
                              .map((e) => SelectedChip(
                                    category: e.value!,
                                    onTap: () {
                                      setState(() {
                                        widget.selectedCategories!.remove(e);
                                        List<Category> cats = widget
                                            .selectedCategories!
                                            .map((e) => e.value!)
                                            .toList();
                                        widget.onChange(cats);
                                      });
                                    },
                                  ))
                              .toList()
                        ],
                      ),
                    ),
            ),
          ),
          error.isNotEmpty
              ? CustomText(
                  fontSize: 12,
                  textColor: AppColors.ERRORS_RED,
                  textAlign: TextAlign.start,
                  padding: EdgeInsets.only(top: 5),
                  title: error)
              : SizedBox()
        ],
      );
    });
    // return Consumer(builder: (_, ScopedReader watch, __) {
    //   final errors = watch(_errorsProvider);
    //   var error = errors
    //       .firstWhere((element) => element.field == UserFields.CATEGORY.field,
    //           orElse: () => UserFormsErrors())
    //       .message;
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    //         decoration: BoxDecoration(
    //             color: AppColors.Tea_green,
    //             borderRadius: BorderRadius.circular(10)),
    //         child: DropdownButton<Category>(
    //           items: widget.categories!.map((Category val) {
    //             return DropdownMenuItem<Category>(
    //               value: val,
    //               child: CustomText(
    //                 title: val.title!,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 13,
    //                 textAlign: TextAlign.start,
    //                 padding: EdgeInsetsDirectional.only(start: 10),
    //               ),
    //             );
    //           }).toList(),
    //           value: widget.selectedCategory,
    //           onChanged: (value) {
    //             widget.onChange(value);
    //             // widget.selectedCategory = value;
    //             // setState(() {});
    //           },
    //           underline: SizedBox(),
    //           iconSize: 30,
    //           isExpanded: true,
    //           icon: Icon(
    //             Icons.arrow_drop_down,
    //             color: AppColors.Liver,
    //           ),
    //           hint: CustomText(
    //             title: 'choose_category'.tr(),
    //             fontSize: 14,
    //             textColor: AppColors.Liver,
    //             padding: EdgeInsets.symmetric(horizontal: 8),
    //           ),
    //         ),
    //       ),
    //       error.isNotEmpty
    //           ? CustomText(
    //               fontSize: 14,
    //               textColor: AppColors.ERRORS_RED,
    //               textAlign: TextAlign.start,
    //               padding: EdgeInsets.only(top: 5),
    //               title: error)
    //           : SizedBox()
    //     ],
    //   );
    // });
  }

  void _showMultiSelect(
      BuildContext context, List<MultiSelectItem<Category?>> _items) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          items: _items,
          selectedCategories: widget.selectedCategories!,
          onTap: () {
            setState(() {});
          },
          onChange: widget.onChange,
        );
      },
    );
  }
}
