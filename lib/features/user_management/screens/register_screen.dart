import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/core/utils/country_code_picker.dart';
import 'package:katkoot_elwady/core/utils/integer_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/screens/widgets/customDialog.dart';
import 'package:katkoot_elwady/features/user_management/screens/widgets/selected_chip.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "./RegisterScreen";

  @override
  State<RegisterScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RegisterScreen> with BaseViewModel {
  @override
  void initState() {
    super.initState();
    getCategoriesAndCities();
  }

  final authViewProvider =
      StateNotifierProvider<AuthViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return AuthViewModel(ref.read(di.repositoryProvider));
  });
  Future getCategoriesAndCities() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(di.categoriesViewModelProvider.notifier)
          .getListOfCategories(mainCategories: false);
      ProviderScope.containerOf(context,
          listen: false).read(di.cityViewModelProvider.notifier).getListOfCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showDrawer: false,
        showNotificationsButton: true,
        hasbackButton: false,
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  padding: EdgeInsetsDirectional.only(
                      top: 2, bottom: 8, start: 20, end: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          title: 'You need to register'.tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        buildForm(),
                        Consumer(builder: (_, ref, __) {
                          var categoriesViewModelProvider =
                          ref.watch(di.categoriesViewModelProvider);
                          var categories = categoriesViewModelProvider.data;
                          return buildCategoriesDropDown(categories!);
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer(builder: (_, ref, __) {
                          var cityViewModelProvider =
                          ref.watch(di.cityViewModelProvider);
                          var cities = cityViewModelProvider.data;
                          return buildLocationDropDown(cities!);
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        Consumer(builder: (_, ref, __) {
                          final errors = ref.watch(_errorsProvider);
                          return CustomTextField(
                              controller: stateController,
                              hintText: "state".tr(),
                              contentPadding:
                              EdgeInsetsDirectional.only(start: 20),
                              inputType: TextInputType.text,
                              fontSize: 14,
                              errorMessage: errors
                                  .firstWhere(
                                      (element) =>
                                  element.field ==
                                      UserFields.STATE.field,
                                  orElse: () => UserFormsErrors())
                                  .message);
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            // launch datePicker
                            _selectDate(context);
                          },
                          child:
                          Consumer(builder: (_, ref, __) {
                            final errors = ref.watch(_errorsProvider);
                            var error = errors.firstWhere(
                                    (element) =>
                                element.field == UserFields.DATE.field,
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
                                EdgeInsetsDirectional.only(start: 20),
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
                          height: 15,
                        ),
                        Consumer(builder: (_, ref, __) {
                          final errors = ref.watch(_errorsProvider);
                          return CustomTextField(
                              controller: flockSizeContoller,
                              hintText: "flock_size".tr(),
                              contentPadding:
                              EdgeInsetsDirectional.only(start: 20),
                              inputType: TextInputType.number,
                              fontSize: 14,
                              errorMessage: errors
                                  .firstWhere(
                                      (element) =>
                                  element.field ==
                                      UserFields.FLOCK_SIZE.field,
                                  orElse: () => UserFormsErrors())
                                  .message);
                        }),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            CustomText(
                              title: 'Already have an account ?'.tr(),
                              fontSize: 13,
                            ),
                            InkWell(
                              onTap: () {
                                ProviderScope.containerOf(context,
                                    listen: false)
                                    .read(authViewProvider.notifier)
                                    .resetState();
                                Navigator.of(context).pop();
                                },
                              child: CustomText(
                                title: 'Sign in'.tr(),
                                fontSize: 13,
                                textColor: AppColors.Olive_Drab,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                underline: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildButtons(context),
                      ],
                    ),
                  ),
                ),
                Consumer(
                  builder: (_, watch, __) {
                    return ScreenHandler(
                      screenProvider: di.categoriesViewModelProvider,
                      noDataMessage: "str_no_data".tr(),
                      // onDeviceReconnected: getListfCategories,
                      noDataWidget: NoDataWidget(),
                      onDeviceReconnected: () {
                        getCategoriesAndCities();
                      },
                    );
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController stateController = TextEditingController();
  TextEditingController flockSizeContoller = TextEditingController();
  TextEditingController arrivalDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(authViewProvider).data;
  });
  String _countryCode = "+20";
  ValueNotifier<String> _countryImageNotifier = ValueNotifier("🇪🇬");

  buildForm() {
    return Column(
      children: [
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: nameController,
              hintText: "name".tr(),
              contentPadding: EdgeInsetsDirectional.only(start: 20),
              inputType: TextInputType.text,
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == UserFields.NAME.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        SizedBox(
          height: 10,
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: phoneController,
              hintText: "phone_number".tr(),
              inputType: TextInputType.phone,
              fontSize: 14,
              inputFormatter: [IntegerTextInputFormatter()],
              fontWeight: FontWeight.bold,
              prefixIcon: buildCountryDialog(),
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == UserFields.PHONE.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        SizedBox(
          height: 10,
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
              bottomSheetHeight: MediaQuery.of(context).size.height - 100,
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

  buildCategoriesDropDown(List<Category> categories) {
    return Consumer(builder: (_, ref, __) {
      final errors = ref.watch(_errorsProvider);
      var error = errors
          .firstWhere((element) => element.field == UserFields.CATEGORY.field,
              orElse: () => UserFormsErrors())
          .message;
      var categoriesList =
          categories.map((e) => MultiSelectItem(e, e.title!)).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showMultiSelect(context, categoriesList),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: AppColors.Tea_green,
                  borderRadius: BorderRadius.circular(10)),
              child: selectedCategories.isEmpty
                  ? Container(
                      padding: selectedCategories.isEmpty
                          ? EdgeInsetsDirectional.only(top: 10, bottom: 10)
                          : null,
                      child: CustomText(
                        title: 'choose_category'.tr(),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.Liver,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...selectedCategories
                              .map((e) => SelectedChip(
                                    category: e.value!,
                                    onTap: () {
                                      setState(() {
                                        selectedCategories.remove(e);
                                      });
                                    },
                                  ))
                              .toList()
                        ],
                      ),
                    ),
              // DropdownButton<Category>(
              //   items: Categories.map((Category value) {
              //     return

              //      DropdownMenuItem<Category>(
              //       value: value,
              //       child: CustomText(
              //         title: value.title!,
              //         fontSize: 13,
              //         fontWeight: FontWeight.bold,
              //         textAlign: TextAlign.start,
              //         padding: EdgeInsetsDirectional.only(start: 10),
              //       ),
              //     );
              //   }).toList(),
              //   value: selectedCategory,
              //   onChanged: (value) {
              //     selectedCategory = value;
              //     setState(() {});
              //   },
              //   underline: SizedBox(),
              //   iconSize: 30,
              //   isExpanded: true,
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     color: AppColors.Liver,
              //   ),
              //   hint: CustomText(
              //     title: 'choose_category'.tr(),
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //     textColor: AppColors.Liver,
              //     padding: EdgeInsets.symmetric(horizontal: 8),
              //   ),
              // ),
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
  }

  List<MultiSelectItem<Category?>> selectedCategories = [];
  void _showMultiSelect(
      BuildContext context, List<MultiSelectItem<Category?>> _items) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          items: _items,
          selectedCategories: selectedCategories,
          onTap: () {
            setState(() {});
          },
        );

        //  MultiSelectDialog<Category?>(

        //   onSelectionChanged: (val) {
        //     setState(() {
        //       selectedCategories =
        //           val.map((e) => MultiSelectItem(e, e!.title!)).toList();
        //     });
        //   },
        //   checkColor: AppColors.white,
        //   selectedColor: AppColors.Dark_spring_green,
        //   height: MediaQuery.of(context).size.height * 0.18,
        //   confirmText: Text(""),
        //   cancelText: Text(""),
        //   title: Text(""),
        //   searchable: false,
        //   items: _items,
        //   initialValue: selectedCategories.map((e) => e.value).toList(),
        // );
      },
    );
  }

  buildLocationDropDown(List<City> cities) {
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
                color: AppColors.Tea_green,
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<City>(
              items: cities.map((City value) {
                return DropdownMenuItem<City>(
                  value: value,
                  child: CustomText(
                    title: value.name!,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    padding: EdgeInsetsDirectional.only(start: 10),
                  ),
                );
              }).toList(),
              value: selectedCity,
              onChanged: (value) {
                selectedCity = value;
                setState(() {});
              },
              underline: SizedBox(),
              iconSize: 30,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.Liver,
              ),
              hint: CustomText(
                title: 'choose_city'.tr(),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textColor: AppColors.Liver,
                padding: EdgeInsets.symmetric(horizontal: 8),
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
  }

  City? selectedCity;
  Category? selectedCategory;

  buildButtons(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 15, end: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: CustomElevatedButton(
              title: 'Register'.tr(),
              fontSize: 17,
              textColor: AppColors.white,
              backgroundColor: AppColors.Olive_Drab,
              onPressed: () {
                hideKeyboard();
                ProviderScope.containerOf(context,
                    listen: false).read(authViewProvider.notifier).validateFeilds(
                    context: context,
                    fullName: nameController.text,
                    phone: phoneController.text,
                    date: arrivalDateController.text,
                    countryCode: _countryCode,
                    cityId: selectedCity?.id ?? 0,
                    categoryId: selectedCategories.isNotEmpty
                        ? selectedCategories.map((e) => e.value!.id!).toList()
                        : [],
                    userState: stateController.text,
                    flockSize: flockSizeContoller.text);
                final errors = ProviderScope.containerOf(context,
                    listen: false).read(_errorsProvider);
                print(errors.length);
                errors.forEach((element) {
                  print(element.message);
                });
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: CustomElevatedButton(
                fontSize: 17,
                title: 'skip'.tr(),
                textColor: AppColors.white,
                backgroundColor: AppColors.calc_bef_btn,
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    print("can pop");
                    Navigator.of(context).pop();
                  } else {
                    print("can't pop");
                    // AppConstants.navigatorKey.currentContext!
                    //     .read(di.contentProvider)
                    //     .state = DrawerItemType.home.index;
                  }
                }),
          )
        ],
      ),
    );
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
    // final DateTime? selected = await showDatePicker(
    //   builder: (context, child) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         colorScheme: ColorScheme.light(
    //           primary: AppColors.Dark_spring_green, // header background color
    //           onPrimary: AppColors.white, // header text color
    //           // onSurface: Colors.green, // body text color
    //         ),
    //         textButtonTheme: TextButtonThemeData(
    //           style: TextButton.styleFrom(
    //             primary: AppColors.Dark_spring_green, // button text color
    //           ),
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime.utc(2020, 1, 1),
    //   lastDate: DateTime(2030),
    // );
    if (selected != null) {
      selectedDate = selected;
      arrivalDateController.text = DateFormat('yyyy-MM-dd').format(selected);
    }
  }
}
