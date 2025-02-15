import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/utils/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/integer_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/models/edit_profile_data.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/edit_profile_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/category_drop_down.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/city_drop_down.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/user.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';
import 'package:katkoot_elwady/features/user_management/view_models/user_data_view_model.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_view_model.dart';
import '../../user_management/screens/login_screen.dart';
import '../view_models/navigation_view_model.dart';
class EditProfileScreen extends StatefulWidget with NavigationDrawerMixin {
  static const routeName = "./edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> with BaseViewModel {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  late bool userIsLoggedIn;
  String _countryCode = "+20";
  ValueNotifier<String> _countryImageNotifier = ValueNotifier("🇪🇬");

  @override
  Widget build(BuildContext context,{bool isAuth = false}) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        hasbackButton: false,
        showDrawer: true,
        showNotificationsButton: true,
      ),
      // drawer: NavigationDrawer(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    height: MediaQuery.of(context).size.height,
                    child: Consumer(builder: (ctx, ref, __) {
                      var viewModel = ref.watch(editProfileProvider);
                      var viewmodelNotifier =
                      ref.watch(editProfileProvider.notifier);
                      var data = viewModel.data;
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 35),
                                  child: CustomText(
                                    textAlign: TextAlign.center,
                                    title: "str_profile".tr(),
                                    textColor: AppColors.Liver,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.05),
                                buildForm(),
                                CategoryDropDown(
                                  categories:
                                  viewModel.data!.categories ?? [],
                                  selectedCategories: viewModel
                                      .data!.selectedCategory !=
                                      null
                                      ? viewModel.data!.selectedCategory!
                                      .map((e) =>
                                      MultiSelectItem(e, e.title!))
                                      .toList()
                                      : [],
                                  onChange: viewmodelNotifier
                                      .changeCurrentCategory,
                                  errorProvider: _errorsProvider,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CityDropDown(
                                  cities: viewModel.data!.cities ?? [],
                                  selectedCity:
                                  viewModel.data!.selectedCity,
                                  onChange:
                                  viewmodelNotifier.changeCurrentCity,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Consumer(
                                    builder: (_,ref, __) {
                                      final errors = ref.watch(_errorsProvider);
                                      return CustomTextField(
                                          controller: stateController,
                                          hintText: "state".tr(),
                                          contentPadding:
                                          EdgeInsetsDirectional.only(
                                              start: 20),
                                          inputType: TextInputType.text,
                                          fontSize: 14,
                                          errorMessage: errors
                                              .firstWhere(
                                                  (element) =>
                                              element.field ==
                                                  UserFields.STATE.field,
                                              orElse: () =>
                                                  UserFormsErrors())
                                              .message);
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // launch datePicker
                                    _selectDate(context);
                                  },
                                  child: Consumer(
                                      builder: (_, watch, __) {
                                        final errors = ref.watch(_errorsProvider);
                                        var error = errors.firstWhere(
                                                (element) =>
                                            element.field ==
                                                UserFields.DATE.field,
                                            orElse: () => UserFormsErrors());
                                        return Container(
                                          child: CustomTextField(
                                            endWidget: Icon(
                                              KatkootELWadyIcons.calendar,
                                              color: AppColors.Olive_Drab,
                                              size: 20,
                                            ),
                                            isEnabled: false,
                                            controller: arrivalDateController,
                                            contentPadding:
                                            EdgeInsetsDirectional.only(
                                                start: 20),
                                            hintText: "birth_date".tr(),
                                            maxLength: 10,
                                            inputType: TextInputType.none,
                                            fontSize: 14,
                                            errorMessage: error.message,
                                          ),
                                        );
                                      }),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Consumer(
                                    builder: (_, ref, __) {
                                      final errors = ref.watch(_errorsProvider);
                                      return CustomTextField(
                                          controller: flockSizeContoller,
                                          hintText: "flock_size".tr(),
                                          contentPadding:
                                          EdgeInsetsDirectional.only(
                                              start: 20),
                                          inputType: TextInputType.number,
                                          fontSize: 14,
                                          errorMessage: errors
                                              .firstWhere(
                                                  (element) =>
                                              element.field ==
                                                  UserFields
                                                      .FLOCK_SIZE.field,
                                              orElse: () =>
                                                  UserFormsErrors())
                                              .message);
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                Consumer(
                                  builder: (context, ref, _) {
                                    var modelView = ref.watch(di.navigationDrawerViewModelProvider.notifier);
                                    userIsLoggedIn = ref.watch(di.userViewModelProvider.notifier).isUserLoggedIn();
                                    // var test = data!.userName;
                                    return TextButton(
                                      child: Text("delete_account".tr()),
                                      onPressed: () {
                                        // You can use `ref` here.
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title : Text("delete_account_message".tr()),
                                              // title: Text(data!.userName.toString()),
                                              content: Text(data!.phoneNumber.toString()),
                                              //
                                              // content: Text("Sds"),
                                              actions: <Widget>[
                                                CustomElevatedButton(
                                                  title: "str_cancel".tr(),
                                                  textColor: AppColors.white,
                                                  backgroundColor:
                                                  AppColors.APP_GREEN,
                                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                                ),
                                                CustomElevatedButton(
                                                  title: "delete".tr(),
                                                  textColor: AppColors.white,
                                                  backgroundColor:
                                                  AppColors.CADMIUM_RED,
                                                  onPressed: ()=>ProviderScope.containerOf(context)
                                                      .read(di.userViewModelProvider
                                                      .notifier).deleteUser(int.tryParse(data!.userId.toString())),
                                                  // onPressed: () => Navigator.pop(context, 'OK'),

                                                  // onPressed: ()=>Navigator.pop(context,  modelView.signOut() ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  start: 15, end: 15, top: 10),
                              decoration:
                              BoxDecoration(color: AppColors.white),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.35,
                                    child: CustomElevatedButton(
                                      title: "str_save".tr(),
                                      textColor: AppColors.white,
                                      backgroundColor: AppColors.Olive_Drab,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        ProviderScope.containerOf(context,
                                            listen: false)
                                            .read(authViewProvider.notifier)
                                            .validateFeilds(
                                            context: context,
                                            fullName:
                                            nameController.text,
                                            phone: phoneController.text,
                                            countryCode: _countryCode,
                                            cityId: viewModel.data!
                                                .selectedCity?.id ??
                                                0,
                                            date: arrivalDateController
                                                .text,
                                            categoryId: viewModel.data!
                                                .selectedCategory !=
                                                null
                                                ? viewModel.data!
                                                .selectedCategory!
                                                .map((e) => e.id!)
                                                .toList()
                                                : [],
                                            flockSize:
                                            flockSizeContoller.text,
                                            userState:
                                            stateController.text,
                                            isEdit: true);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.35,
                                    child: CustomElevatedButton(
                                      title: "str_cancel".tr(),
                                      textColor: AppColors.white,
                                      backgroundColor:
                                      AppColors.calc_bef_btn,
                                      onPressed: () {
                                        hideKeyboard();
                                        ProviderScope.containerOf(context,
                                            listen: false).read(di.bottomNavigationViewModelProvider.notifier).changeIndex(0);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  Consumer(
                    builder: (_, watch, __) {
                      return ScreenHandler(
                        screenProvider: authViewProvider,
                        noDataMessage: "str_no_data".tr(),
                        noDataWidget: NoDataWidget(),
                      );
                    },
                  ),
                  Consumer(
                    builder: (_, watch, __) {
                      return ScreenHandler(
                        screenProvider: editProfileProvider,
                        noDataMessage: "str_no_data".tr(),
                        noDataWidget: NoDataWidget(),
                        onDeviceReconnected: () => getData(context),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController flockSizeContoller = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController arrivalDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController idController = TextEditingController();
  late final _errorsProvider =
  Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(authViewProvider).data;
  });

  buildForm() {
    return Column(
      children: [
        Consumer(builder: (_,ref, __) {
          final errors = ref.watch(_errorsProvider);

          return CustomTextField(
              controller: nameController,
              hintText: "name".tr(),
              inputType: TextInputType.text,
              fontSize: 14,
              contentPadding: EdgeInsetsDirectional.only(start: 20),
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == UserFields.NAME.field,
                  orElse: () => UserFormsErrors())
                  .message);
        }),
        SizedBox(
          height: 20,
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: phoneController,
              hintText: "phone_number".tr(),
              inputType: TextInputType.phone,
              fontSize: 14,
              inputFormatter: [IntegerTextInputFormatter()],
              prefixIcon: buildCountryDialog(),
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == UserFields.PHONE.field,
                  orElse: () => UserFormsErrors())
                  .message);
        }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buildCountryDialog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (country) {
              _countryCode = country.countryCode;
              _countryImageNotifier.value = country.flagEmoji;
            },
            favorite: ['+20', 'EG'],
            countryListTheme: CountryListThemeData(
              flagSize: 30,
              backgroundColor: Colors.white,
              bottomSheetHeight: MediaQuery.of(context).size.height - 150,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              inputDecoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          );
        },
        child: ValueListenableBuilder<String>(
            valueListenable: _countryImageNotifier,
            builder: (context, countryImage, child){
              return Text(
                countryImage,
                style: TextStyle(fontSize: 25),
              );
            }
        ),
      ),
    );
  }

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
  void initState() {
    // TODO: implement initState
    getData(context);
    super.initState();
  }

  Future getData(BuildContext context) async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(editProfileProvider.notifier).getCategoriesAndCities(
          context,
          phoneController,
          nameController,
          arrivalDateController,
          stateController,
          flockSizeContoller,
          idController
         );
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.Dark_spring_green,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Container(),
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (selected != null) {
      selectedDate = selected;
      arrivalDateController.text = DateFormat('yyyy-MM-dd').format(selected);
    }
  }
}
