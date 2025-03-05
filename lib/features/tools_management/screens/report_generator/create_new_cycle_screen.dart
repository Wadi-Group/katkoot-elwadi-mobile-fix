import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class CreateNewCycleScreen extends StatefulWidget {
  static const routeName = "./create_new_cycle";
  final Category? category;
  final Tool? tool;

  const CreateNewCycleScreen({required this.category, required this.tool});

  @override
  _CreateNewCycleScreenState createState() => _CreateNewCycleScreenState();
}

class _CreateNewCycleScreenState extends State<CreateNewCycleScreen>
    with BaseViewModel {
  String date = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController farmNameController = TextEditingController();
  TextEditingController flockNumberController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController arrivalDateController = TextEditingController();
  TextEditingController femaleNumController = TextEditingController();
  TextEditingController maleNumController = TextEditingController();

  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(di.createCycleViewModelProvider).data;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      appBar: CustomAppBar(
        showDrawer: false,
        title: 'create_new_cycle'.tr(),
        onBackClick: () => Navigator.of(context).pop(), //widget.tool!.title
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsetsDirectional.only(bottom: 8, start: 20, end: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      buildForm(),
                      SizedBox(
                        height: 40,
                      ),
                      buildActionsButtons(),
                    ],
                  ),
                ),
              ),
              Consumer(
                builder: (_, watch, __) {
                  return ScreenHandler(
                    screenProvider: di.createCycleViewModelProvider,
                    noDataMessage: "str_no_data".tr(),
                    noDataWidget: NoDataWidget(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   shouldPop: true,
      // ),
    );
  }

  buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "str_farm_name".tr(),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: farmNameController,
              inputType: TextInputType.text,
              maxLength: 50,
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == CycleFields.FARM_NAME.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "str_room_name".tr(),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: roomNameController,
              maxLength: 50,
              inputType: TextInputType.text,
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == CycleFields.ROOM_NAME.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "str_arrival_date".tr(),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
        ),
        GestureDetector(
          onTap: () {
            // launch datePicker
            _selectDate(context);
          },
          child: Consumer(builder: (_, ref, __) {
            final errors = ref.watch(_errorsProvider);
            return Stack(children: [
              CustomTextField(
                  endWidget: Icon(
                    KatkootELWadyIcons.calendar,
                    color: AppColors.Olive_Drab,
                    size: 20,
                  ),
                  isEnabled: false,
                  controller: arrivalDateController,
                  maxLength: 10,
                  inputType: TextInputType.none,
                  fontSize: 14,
                  errorMessage: errors
                      .firstWhere(
                          (element) =>
                              element.field == CycleFields.ARRIVAL_DATE.field,
                          orElse: () => UserFormsErrors())
                      .message),
            ]);
          }),
        ),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "str_female_number".tr(),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: femaleNumController,
              maxLength: 9,
              inputType: TextInputType.number,
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleFields.FEMALE_NUMBER.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "str_male_number".tr(),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: maleNumController,
              maxLength: 9,
              inputType: TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == CycleFields.MALE_NUMBER.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
      ],
    );
  }

  buildActionsButtons() {
    return Consumer(builder: (_, watch, __) {
      // var tool = watch(_toolDataProvider);
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: CustomElevatedButton(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: "Almarai",
                title: 'str_create_cycle'.tr(),
                textColor: AppColors.white,
                backgroundColor: AppColors.Olive_Drab,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  hideKeyboard();
                  if (widget.tool?.id != null) {
                    ProviderScope.containerOf(context, listen: false)
                        .read(di.createCycleViewModelProvider.notifier)
                        .checkCycleFields(
                            context: context,
                            farmName: farmNameController.text,
                            roomName: roomNameController.text,
                            arrivalDate: arrivalDateController.text,
                            femaleNumber: femaleNumController.text,
                            maleNumber: maleNumController.text,
                            toolId: widget.tool!.id);
                  }
                }),
          ),
          SizedBox(
            width: 40,
          ),
          Expanded(
              child: Container(
            child: CustomElevatedButton(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                title: 'str_cancel'.tr(),
                fontFamily: "Almarai",
                textColor: AppColors.white,
                backgroundColor: AppColors.calc_bef_btn,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  hideKeyboard();
                  Navigator.of(context).pop(false);
                }),
          )),
        ]),
      );
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.Dark_spring_green, // header background color
                onPrimary: AppColors.white, // header text color
                // onSurface: Colors.green, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                      color: AppColors.Dark_spring_green), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.utc(2020, 1, 1),
        lastDate: DateTime.now());
    if (selected != null)
      arrivalDateController.text = DateFormat('yyyy-MM-dd').format(selected);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ProviderScope.containerOf(context, listen: false)
          .read(di.createCycleViewModelProvider.notifier)
          .resetState();
    });

    super.initState();
  }
}
