// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:katkoot_elwady/core/constants/app_colors.dart';
// import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
// import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
// import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
// import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
// import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
// import 'package:katkoot_elwady/features/tools_management/entities/cb_cycle_edit_week_data_state.dart';
// import 'package:katkoot_elwady/features/tools_management/entities/cb_cycle_week_data_fields_extension.dart';
// import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/week_data.dart';
// import 'package:katkoot_elwady/features/tools_management/view_models/cb_report_generator/edit_week_data_view_model.dart';
// import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/cycle_action_buttons.dart';
// import 'package:katkoot_elwady/features/tools_management/widgets/cb_report_generator/cycle_week_data_item.dart';
// import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
//
// class EditRearingWeekDataScreenData {
//   final String? cycleId;
//   final String? weekNumber;
//
//   EditRearingWeekDataScreenData(
//       {required this.cycleId, required this.weekNumber});
// }
//
// class EditRearingWeekDataScreen extends StatefulWidget {
//   static const routeName = "./edit_rearing_week_data";
//
//   final String? cycleId;
//   final String? weekNumber;
//
//   const EditRearingWeekDataScreen(
//       {required this.cycleId, required this.weekNumber});
//
//   @override
//   _EditRearingWeekDataScreenState createState() =>
//       _EditRearingWeekDataScreenState();
// }
//
// class _EditRearingWeekDataScreenState extends State<EditRearingWeekDataScreen>
//     with BaseViewModel {
//   final _screenViewModelProvider = StateNotifierProvider<EditWeekDataViewModel,
//       BaseState<CycleEditWeekDataState>>((ref) {
//     return EditWeekDataViewModel(ref.read(di.repositoryProvider));
//   });
//
//   late final _weekDataProvider = Provider.autoDispose<WeekData?>((ref) {
//     return ref.watch(_screenViewModelProvider).data.weekData;
//   });
//
//   late final _errorsProvider =
//       Provider.autoDispose<List<UserFormsErrors>>((ref) {
//     return ref.watch(_screenViewModelProvider).data.errorsList ?? [];
//   });
//
//   TextEditingController femaleFeedController = TextEditingController();
//   TextEditingController maleFeedController = TextEditingController();
//   TextEditingController femaleWeightController = TextEditingController();
//   TextEditingController maleWeightController = TextEditingController();
//   TextEditingController femaleMortController = TextEditingController();
//   TextEditingController maleMortController = TextEditingController();
//   TextEditingController sexErrorsController = TextEditingController();
//   TextEditingController cullsController = TextEditingController();
//
//   @override
//   void initState() {
//     getWeekData();
//
//     super.initState();
//   }
//
//   Future getWeekData() async {
//     await Future.delayed(Duration.zero, () {
//       ProviderScope.containerOf(context,
//           listen: false).read(_screenViewModelProvider.notifier)
//           .getWeekData(widget.cycleId, widget.weekNumber);
//     });
//   }
//
//   submitWeekData() {
//     ProviderScope.containerOf(context,
//         listen: false).read(_screenViewModelProvider.notifier).checkDataFields(
//         context: context,
//         cycleId: widget.cycleId.toString(),
//         weekNumber: widget.weekNumber.toString(),
//         femaleFeed: femaleFeedController.text,
//         maleFeed: maleFeedController.text,
//         femaleWeight: femaleWeightController.text,
//         maleWeight: maleWeightController.text,
//         femaleMort: femaleMortController.text,
//         maleMort: maleMortController.text,
//         sexErrors: sexErrorsController.text,
//         culls: cullsController.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CustomAppBar(
//         onBackClick: () => Navigator.of(context).pop(),
//         title: 'edit_rearing_data'.tr(), //widget.tool!.title
//       ),
//       body: GestureDetector(
//         onTap: () {
//           hideKeyboard();
//         },
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Consumer(builder: (_, ref, __) {
//                 var weekData = ref.watch(_weekDataProvider);
//
//                 return weekData != null
//                     ? Container(
//                         padding: EdgeInsetsDirectional.only(start: 20, end: 20),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               CustomText(
//                                 title: 'str_week'.tr() +
//                                     ' ' +
//                                     widget.weekNumber.toString(),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 textColor: AppColors.DARK_SPRING_GREEN,
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                               ),
//                               buildDataFieldsView(),
//                               SizedBox(height: 40),
//                               CycleActionButtons(
//                                 submitButtonTitle: 'edit_data'.tr(),
//                                 onSubmit: () {
//                                   hideKeyboard();
//                                   if (widget.cycleId != null) {
//                                     submitWeekData();
//                                   }
//                                 },
//                                 onCancel: () {
//                                   hideKeyboard();
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : Container();
//               }),
//               ScreenHandler(
//                 screenProvider: _screenViewModelProvider,
//                 onDeviceReconnected: () {
//                   if (ProviderScope.containerOf(context,
//                       listen: false).read(_weekDataProvider) != null) {
//                     submitWeekData();
//                   } else {
//                     getWeekData();
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: BottomNavigationBarWidget(
//       //   shouldPop: true,
//       // ),
//     );
//   }
//
//   buildDataFieldsView() {
//     _setWeekDataToControllers();
//
//     return Consumer(builder: (_,ref, __) {
//       final errors = ref.watch(_errorsProvider);
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CycleWeekDataItem(
//               title: 'female_feed'.tr(),
//               controller: femaleFeedController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.FEMALE_FEED.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           CycleWeekDataItem(
//               title: 'male_feed'.tr(),
//               controller: maleFeedController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.MALE_FEED.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           CycleWeekDataItem(
//               title: 'female_weight'.tr(),
//               controller: femaleWeightController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.FEMALE_WEIGHT.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           CycleWeekDataItem(
//               title: 'male_weight'.tr(),
//               controller: maleWeightController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.MALE_WEIGHT.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           CycleWeekDataItem(
//               title: 'female_mort'.tr(),
//               controller: femaleMortController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.FEMALE_MORT.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           CycleWeekDataItem(
//               title: 'male_mort'.tr(),
//               controller: maleMortController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.MALE_MORT.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//           if (int.parse(widget.weekNumber!) > 15)
//             CycleWeekDataItem(
//                 title: 'sex_errors'.tr(),
//                 controller: sexErrorsController,
//                 errorMessage: errors
//                     .firstWhere(
//                         (element) =>
//                             element.field == CycleWeekDataFields.SEX_ERRORS.id,
//                         orElse: () => UserFormsErrors())
//                     .message),
//           CycleWeekDataItem(
//               title: 'culls'.tr(),
//               controller: cullsController,
//               errorMessage: errors
//                   .firstWhere(
//                       (element) =>
//                           element.field == CycleWeekDataFields.CULLS.id,
//                       orElse: () => UserFormsErrors())
//                   .message),
//         ],
//       );
//     });
//   }
//
//   _setWeekDataToControllers() {
//     WeekData? weekData = ProviderScope.containerOf(context,
//         listen: false).read(_weekDataProvider);
//
//     femaleFeedController.text =
//         weekData?.value?.params?.femaleFeed.toString() ?? '';
//     maleFeedController.text =
//         weekData?.value?.params?.maleFeed.toString() ?? '';
//     femaleWeightController.text =
//         weekData?.value?.params?.femaleWeight.toString() ?? '';
//     maleWeightController.text =
//         weekData?.value?.params?.maleWeight.toString() ?? '';
//     femaleMortController.text =
//         weekData?.value?.params?.femaleMort.toString() ?? '';
//     maleMortController.text =
//         weekData?.value?.params?.maleMort.toString() ?? '';
//     sexErrorsController.text =
//         weekData?.value?.params?.sexErrors.toString() ?? '';
//     cullsController.text = weekData?.value?.params?.culls.toString() ?? '';
//   }
// }
