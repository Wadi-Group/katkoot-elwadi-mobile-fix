import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/utils/decimal_text_input_formatter.dart';
import 'package:katkoot_elwady/core/utils/integer_text_input_formatter.dart';
import 'package:katkoot_elwady/core/utils/max_number_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/entities/tool_details_state.dart';
import 'package:katkoot_elwady/features/tools_management/entities/tool_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/bef_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/tool_details_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tool_category_header.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tools_flexiple_app_bar.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class BEFScreenData {
  final Category? category;
  final Tool? tool;
  var fcrValue;

  BEFScreenData({required this.category, required this.tool, this.fcrValue});
}

class BEFScreen extends StatefulWidget {
  static const routeName = "./bef";
  final Category? category;
  final Tool? tool;
  var fcrValue;

  BEFScreen(
      {Key? key, required this.category, required this.tool, this.fcrValue})
      : super(key: key);

  @override
  _BEFScreenState createState() => _BEFScreenState();
}

class _BEFScreenState extends State<BEFScreen> with BaseViewModel {
  final toolDetailsViewModelProvider =
      StateNotifierProvider<ToolDetailsViewModel, BaseState<ToolDetailsState?>>(
          (ref) {
    return ToolDetailsViewModel(ref.read(di.repositoryProvider));
  });
  late final _toolDataProvider = Provider<Tool?>((ref) {
    return ref.watch(toolDetailsViewModelProvider).data?.tool;
  });

  final _resultDataProvider = StateProvider<double>((ref) {
    return 0.0;
  });
  final bEFViewModel =
      StateNotifierProvider<BEFViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return BEFViewModel();
  });

  @override
  void initState() {
    getToolDetails();
    if (widget.fcrValue != null) {
      FCRController.text = widget.fcrValue.toString();
    }
    super.initState();
  }

  Future getToolDetails() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(toolDetailsViewModelProvider.notifier)
          .getDetails(widget.tool?.id, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.DARK_SPRING_GREEN,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 0),
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: () {
          hideKeyboard();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.DARK_SPRING_GREEN,
              floating: true,
              pinned: true,
              centerTitle: false,
              expandedHeight: 100,
              collapsedHeight: kToolbarHeight,
              foregroundColor: Colors.white,
              flexibleSpace: Consumer(builder: (_, ref, __) {
                var tool = ref.watch(_toolDataProvider);
                return ToolsFlexibleAppBar(
                  title: tool?.title ?? "",
                  backgroundTitle: widget.category?.title ?? '',
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsetsDirectional.only(
                        top: 2, bottom: 8, start: 20, end: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildForm(),
                          SizedBox(
                            height: 30,
                          ),
                          Consumer(builder: (_, ref, __) {
                            final result = ref.watch(_resultDataProvider)
                                .toStringAsFixed(2);
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.Mansuel),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 60),
                              child: CustomText(
                                title: result.toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          SizedBox(
                            height: 30,
                          ),
                          buildCalculatePEFButton(),
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (_, watch, __) {
                      return ScreenHandler(
                        screenProvider: toolDetailsViewModelProvider,
                        noDataMessage: "str_no_data".tr(),
                        onDeviceReconnected: () {
                          getToolDetails();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   shouldPop: true,
      //   shouldPopToHome: false,
      // ),
    );
  }

  TextEditingController liveabilityController = TextEditingController();
  TextEditingController liveWeightPerBirdController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController FCRController = TextEditingController();
  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(bEFViewModel).data;
  });

  buildForm() {
    return Column(
      children: [
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          textColor: AppColors.Liver,
          title: "Livability %".tr(),
          padding:
              const EdgeInsets.only(top: 14, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: liveabilityController,
              inputType: TextInputType.numberWithOptions(decimal: true),
              fontSize: 14,
              inputFormatter: [
                MaxNumberTextInputFormatter(max: 100),
                DecimalTextInputFormatter(maxDecimalDigits: 2),
              ],
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == ToolFields.LIVABILITY.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          textColor: AppColors.Liver,
          title: "Live weight per bird".tr(),
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: liveWeightPerBirdController,
              maxLength: 10,
              inputType: TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [
                DecimalTextInputFormatter(),
              ],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == ToolFields.LIVE_WEIGHT.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          textColor: AppColors.Liver,
          title: "age_per_day".tr(),
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: ageController,
              maxLength: 10,
              inputType: TextInputType.number,
              inputFormatter: [IntegerTextInputFormatter()],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == ToolFields.AGE.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 1,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          textColor: AppColors.Liver,
          title: "str_fcr".tr(),
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: FCRController,
              isEnabled: widget.fcrValue == null,
              maxLength: 10,
              inputType: TextInputType.numberWithOptions(decimal: true),
              inputFormatter: [
                DecimalTextInputFormatter(),
              ],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) => element.field == ToolFields.FCR.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
      ],
    );
  }

  buildCalculatePEFButton() {
    return Consumer(builder: (_, ref, __) {
      var tool = ref.watch(_toolDataProvider);
      return Container(
        width: MediaQuery.of(context).size.width,
        child: CustomElevatedButton(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            title: 'calculate'.tr() + " ${widget.tool?.title}",
            textColor: AppColors.white,
            backgroundColor: AppColors.Olive_Drab,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: () {
              hideKeyboard();
              double result = ProviderScope.containerOf(context,
                  listen: false).read(bEFViewModel.notifier)
                  .checkCalculatePEF(
                      age: ageController.text,
                      FCRValue: FCRController.text.replaceAll("٫", "."),
                      liveability:
                          liveabilityController.text.replaceAll("٫", "."),
                      liveWeightPerBird:
                          liveWeightPerBirdController.text.replaceAll("٫", "."),
                      tool: tool);
              ProviderScope.containerOf(context,
                  listen: false).read(_resultDataProvider.notifier).state = result;
            }),
      );
    });
  }
}
