import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/models/edit_profile_data.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/edit_profile_view_model.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';

class SingleCategoryDropDown extends StatefulWidget {
  List<Category>? categories;
  Function onChange;
  Category? selectedCategory;
  SingleCategoryDropDown(
      {this.categories, this.selectedCategory, required this.onChange});

  @override
  _SingleCategoryDropDownState createState() => _SingleCategoryDropDownState();
}

class _SingleCategoryDropDownState extends State<SingleCategoryDropDown> {
  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(authViewProvider).data;
  });
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
      final errors = ref.watch(_errorsProvider);
      var error = errors
          .firstWhere((element) => element.field == UserFields.CATEGORY.field,
              orElse: () => UserFormsErrors())
          .message;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: AppColors.Tea_green,
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<Category>(
              items: widget.categories!.map((Category val) {
                return DropdownMenuItem<Category>(
                  value: val,
                  child: CustomText(
                    title: val.title!,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    textAlign: TextAlign.start,
                    padding: EdgeInsetsDirectional.only(start: 10),
                  ),
                );
              }).toList(),
              value: widget.selectedCategory,
              onChanged: (value) {
                widget.onChange(value);
                // widget.selectedCategory = value;
                // setState(() {});
              },
              underline: SizedBox(),
              iconSize: 30,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.Liver,
              ),
              hint: CustomText(
                title: 'choose_category'.tr(),
                fontSize: 14,
                textColor: AppColors.Liver,
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          error.isNotEmpty
              ? CustomText(
                  fontSize: 14,
                  textColor: AppColors.ERRORS_RED,
                  textAlign: TextAlign.start,
                  padding: EdgeInsets.only(top: 5),
                  title: error)
              : SizedBox()
        ],
      );
    });
  }
}
