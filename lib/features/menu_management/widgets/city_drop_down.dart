import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/models/edit_profile_data.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/edit_profile_view_model.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';

import '../../../core/di/injection_container.dart' as di;

class CityDropDown extends StatefulWidget {
  List<City>? cities;

  City? selectedCity;
  Function onChange;
  CityDropDown({this.cities, this.selectedCity, required this.onChange});

  @override
  _CityDropDownState createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropDown> {
  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(authViewProvider).data;
  });

  final authViewProvider =
      StateNotifierProvider<AuthViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return AuthViewModel(ref.read(di.repositoryProvider));
  });
  final editProfileProvider =
      StateNotifierProvider<EditProfileViewModel, BaseState<EditProdileData?>>(
          (ref) {
    return EditProfileViewModel(ref.read(di.repositoryProvider));
  });
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final errors = ref.watch(_errorsProvider);

      var error = errors
          .firstWhere((element) => element.field == UserFields.CITY.field,
              orElse: () => UserFormsErrors())
          .message;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
            child: DropdownButton<City>(
              items: widget.cities!.map((City value) {
                return DropdownMenuItem<City>(
                  value: value,
                  child: CustomText(
                    title: value.name!,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    textAlign: TextAlign.start,
                    padding: EdgeInsetsDirectional.only(start: 10),
                  ),
                );
              }).toList(),
              value: widget.selectedCity,
              onChanged: (value) {
                widget.onChange(value);
                // widget.selectedCity = value;
                // setState(() {});
              },
              underline: SizedBox(),
              iconSize: 30,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.TEXTFIELD_HINT,
              ),
              hint: CustomText(
                title: 'choose_city'.tr(),
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
