import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/utils/integer_text_input_formatter.dart';
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
import 'package:katkoot_elwady/features/tools_management/screens/bef_screen.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/fcr_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/tool_details_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/tools_flexiple_app_bar.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class FCRScreenData {
  final Category? category;
  final Tool? tool;

  FCRScreenData({required this.category, required this.tool});
}

class FCRScreen extends StatefulWidget {
  static const routeName = "./FCRScreen";
  final Category? category;
  final Tool? tool;

  const FCRScreen({Key? key, required this.category, required this.tool})
      : super(key: key);

  @override
  _FCRScreenState createState() => _FCRScreenState();
}

class _FCRScreenState extends State<FCRScreen> with BaseViewModel {
  late final _toolDataProvider = Provider<Tool?>((ref) {
    return ref.watch(toolDetailsViewModelProvider).data?.tool;
  });
  final toolDetailsViewModelProvider =
      StateNotifierProvider<ToolDetailsViewModel, BaseState<ToolDetailsState?>>(
          (ref) {
    return ToolDetailsViewModel(ref.read(di.repositoryProvider));
  });

  final _resultDataProvider = StateProvider<double>((ref) {
    return 0.0;
  });

  final _showResutlProvider = StateProvider<bool>((ref) {
    return false;
  });
  final fCRViewModel =
      StateNotifierProvider<FCRViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return FCRViewModel();
  });

  @override
  void initState() {
    getToolDetails();

    super.initState();
  }

  Future getToolDetails() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(toolDetailsViewModelProvider.notifier)
          .getDetails(widget.tool!.id, 10);
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
                                title: "${widget.tool?.title}     ${result.toString()}",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          SizedBox(
                            height: 30,
                          ),
                          buildCalculateFCRButton(),
                          SizedBox(
                            height: 30,
                          ),
                          buildPEFButton(),
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

  TextEditingController feedWeightFlockController = TextEditingController();
  TextEditingController meatWeightFlockController = TextEditingController();
  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(fCRViewModel).data;
  });

  buildForm() {
    return Column(
      children: [
        CustomText(
          textAlign: TextAlign.center,
          maxLines: 2,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "Feed weight per bird GM".tr(),
          padding:
              const EdgeInsets.only(top: 14, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: feedWeightFlockController,
              maxLength: 10,
              inputType: TextInputType.number,
              inputFormatter: [IntegerTextInputFormatter()],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == ToolFields.FEED_WEIGHT.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
        CustomText(
          textAlign: TextAlign.center,
          maxLines: 1,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          textColor: AppColors.Liver,
          title: "Meat weight per bird GM".tr(),
          padding:
              const EdgeInsets.only(top: 35, bottom: 10, left: 12, right: 12),
        ),
        Consumer(builder: (_, ref, __) {
          final errors = ref.watch(_errorsProvider);
          return CustomTextField(
              controller: meatWeightFlockController,
              maxLength: 10,
              inputType: TextInputType.number,
              inputFormatter: [IntegerTextInputFormatter()],
              fontSize: 14,
              errorMessage: errors
                  .firstWhere(
                      (element) =>
                          element.field == ToolFields.MEAT_WEIGHT.field,
                      orElse: () => UserFormsErrors())
                  .message);
        }),
      ],
    );
  }

  buildCalculateFCRButton() {
    return Consumer(builder: (_, ref, __) {
      var tool = ref.watch(_toolDataProvider);
      return Container(
        width: MediaQuery.of(context).size.width,
        child: CustomElevatedButton(
            fontSize: 17,
            title: 'calculate'.tr() + " ${widget.tool?.title}",
            textColor: AppColors.white,
            backgroundColor: AppColors.Olive_Drab,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: () {
              hideKeyboard();
              double result = ProviderScope.containerOf(context,
                  listen: false).read(fCRViewModel.notifier)
                  .checkCalculateFCR(
                      feedWeight: feedWeightFlockController.text,
                      meatWeight: meatWeightFlockController.text,
                      tool: tool);
              ProviderScope.containerOf(context,
                  listen: false).read(_resultDataProvider.notifier).state = result;
              var errors = ref.watch(_errorsProvider);
              if (errors.isEmpty) {
                ProviderScope.containerOf(context,
                    listen: false).read(_showResutlProvider.notifier).state = true;
              } else {
                ProviderScope.containerOf(context,
                    listen: false).read(_showResutlProvider.notifier).state = false;
              }
            }),
      );
    });
  }

  buildPEFButton() {
    return Consumer(builder: (_, ref, __) {
      bool showResutlProvider = ref.watch(_showResutlProvider);
      final result = ref.watch(_resultDataProvider).toStringAsFixed(2);
      return Visibility(
        visible: showResutlProvider,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                        fontSize: 17,
                        title: 'calculate'.tr() +
                            " ${widget.tool!.relatedTool?.title}",
                        textColor: AppColors.white,
                        backgroundColor: AppColors.calc_bef_btn,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        onPressed: () {
                          hideKeyboard();
                          navigateToScreen(BEFScreen.routeName,
                              arguments: BEFScreenData(
                                  category: widget.category,
                                  tool: widget.tool!.relatedTool,
                                  fcrValue: result));
                        }),
                  ),
                ],
              ),
              Positioned(
                  right: context.locale.toString() == 'en' ? 20 : null,
                  left: context.locale.toString() == 'en' ? null : 20,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.white,
                  ))
            ],
          ),
        ),
      );
    });
  }
}
