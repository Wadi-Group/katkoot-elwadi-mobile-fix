import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/confirmation_dialog.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text_button.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/add_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/add_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_production_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/screens/report_generator/view_rearing_week_data_screen.dart';
import 'package:katkoot_elwady/features/tools_management/view_models/report_generator/manage_cycle_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/week_row_item.dart';

import 'edit_production_week_data_screen.dart';
import 'edit_rearing_week_data_screen.dart';

class ManageCycleScreen extends StatefulWidget {
  static const routeName = "./manage_cycle_screen";
  final Cycle cycle;

  const ManageCycleScreen({required this.cycle});

  @override
  _ManageCycleScreenState createState() => _ManageCycleScreenState();
}

class _ManageCycleScreenState extends State<ManageCycleScreen>
    with BaseViewModel {
  final _manageCycleViewModelProvider =
      StateNotifierProvider<ManageCycleViewModel, BaseState>((ref) {
    return ManageCycleViewModel(ref.read(repositoryProvider));
  });

  ScrollController weeksScrollController = ScrollController();
  int selectedWeek = 0;

  @override
  void initState() {
    selectedWeek = widget.cycle.getMaxWeek();
    // widget.cycle.weeksList!.forEach((element) {
    //   print(element.duration);
    //   print(element.id);
    //   print(element.value != null);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.height * .1;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Stack(children: [
              Stack(children: [
                Container(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 1.2,
                      padding: EdgeInsetsDirectional.only(
                          start: MediaQuery.of(context).size.width * .18,
                          end: MediaQuery.of(context).size.width * .18,
                          bottom: 0),
                      child: Image.asset(
                        "assets/images/bg_image.png",
                      )),
                ),
                Column(
                  children: [
                    buildHeader(getWeeks()),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: padding,
                            ),
                            if (!widget.cycle.weekIsExists(selectedWeek))
                              buildAddDataBtn(),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.cycle.weekIsExists(selectedWeek))
                              buildEditDataBtn(),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.cycle.weekIsExists(selectedWeek))
                              buildViewDataBtn(),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.cycle.weekIsExists(selectedWeek))
                              buildDeleteDataBtn(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (_, watch, __) {
                    return ScreenHandler(
                        screenProvider: _manageCycleViewModelProvider);
                  },
                )
              ])
            ]),
          ),
        ]),
        // ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   shouldPop: true,
      // ),
    );
  }

  buildDeleteDataBtn() {
    return CustomTextButton(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: 10,
      onTap: () {
        if (selectedWeek != 0) {
          String message = context.locale.toString() == 'en' ? " data" : "";
          ConfirmationDialog.show(
            btnRadiusCorners: 30,
            context: context,
            title: 'delete_week_data'.tr(),
            message:
                'delete_week_data_message'.tr() + " $selectedWeek" + message,
            confirmText: 'delete'.tr(),
            cancelText: 'str_cancel'.tr(),
            onConfirm: () async {
              //Navigator.of(context).pop();
              deleteCycleWeek(widget.cycle.id!, selectedWeek);
            },
            //onCancel: () => Navigator.of(context).pop()
          );
        }
      },
      title: 'str_delete_data'.tr(),
      backgroundColor: AppColors.Gamboge,
      startIcon: Container(
        width: 25,
      ),
    );
  }

  buildEditDataBtn() {
    return CustomTextButton(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: 10,
      title: 'str_edit_data'.tr(),
      startIcon: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          KatkootELWadyIcons.edit_data,
          color: AppColors.white,
          size: 20,
        ),
      ),
      onTap: () {
        if (selectedWeek != 0) {
          if (selectedWeek >= AppConstants.REARING_MIN_VALUE &&
              selectedWeek <= AppConstants.REARING_MAX_VALUE) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditRearingWeekDataScreen(
                  cycleId: widget.cycle.id.toString(),
                  weekNumber: selectedWeek.toString());
            }));
            // navigateToScreen(EditRearingWeekDataScreen.routeName,
            //     arguments: EditRearingWeekDataScreenData(
            //         cycleId: widget.cycle.id.toString(),
            //         weekNumber: selectedWeek.toString()));
          } else if (selectedWeek >= AppConstants.PRODUCTION_MIN_VALUE &&
              selectedWeek <= AppConstants.PRODUCTION_MAX_VALUE) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditProductionWeekDataScreen(
                  cycleId: widget.cycle.id.toString(),
                  weekNumber: selectedWeek.toString());
            }));

            // navigateToScreen(EditProductionWeekDataScreen.routeName,
            //     arguments: EditProductionWeekDataScreenData(
            //         cycleId: widget.cycle.id.toString(),
            //         weekNumber: selectedWeek.toString()));
          }
        }
      },
    );
  }

  buildViewDataBtn() {
    return CustomTextButton(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: 10,
      title: 'str_view_data'.tr(),
      startIcon: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          KatkootELWadyIcons.view_weeks,
          color: AppColors.white,
          size: 20,
        ),
      ),
      onTap: () {
        if (selectedWeek != 0) {
          if (selectedWeek >= AppConstants.REARING_MIN_VALUE &&
              selectedWeek <= AppConstants.REARING_MAX_VALUE) {
            navigateToScreen(ViewRearingWeekDataScreen.routeName,
                arguments: ViewRearingWeekDataScreenData(
                    cycleName: widget.cycle.name,
                    cycleId: widget.cycle.id.toString(),
                    weekNumber: selectedWeek));
          } else if (selectedWeek >= AppConstants.PRODUCTION_MIN_VALUE &&
              selectedWeek <= AppConstants.PRODUCTION_MAX_VALUE) {
            navigateToScreen(ViewProductionWeekDataScreen.routeName,
                arguments: ViewProductionWeekDataScreenData(
                    cycleName: widget.cycle.name,
                    cycleId: widget.cycle.id.toString(),
                    weekNumber: selectedWeek));
          }
        }
      },
    );
  }

  buildAddDataBtn() {
    return CustomTextButton(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: 10,
      title: 'str_add_data'.tr(),
      startIcon: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          KatkootELWadyIcons.add_weekly_data,
          color: AppColors.white,
          size: 20,
        ),
      ),
      onTap: () {
        if (selectedWeek != 0) {
          if (selectedWeek >= AppConstants.REARING_MIN_VALUE &&
              selectedWeek <= AppConstants.REARING_MAX_VALUE) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddRearingWeekDataScreen(
                cycleId: widget.cycle.id.toString(),
                weekNumber: selectedWeek.toString(),
              );
            })).then((value) {
              if (value) {
                Navigator.of(context).pop(true);
              }
            });
            // AppConstants.navigatorKey.currentState
            //     ?.pushNamed(AddRearingWeekDataScreen.routeName,
            //     arguments: AddRearingWeekDataScreenData(
            //         cycleId: widget.cycle.id.toString(),
            //         weekNumber: selectedWeek.toString()))
            //     .then((value) => Navigator.of(context).pop(true));
          } else if (selectedWeek >= AppConstants.PRODUCTION_MIN_VALUE &&
              selectedWeek <= AppConstants.PRODUCTION_MAX_VALUE) {
            // AppConstants.navigatorKey.currentState
            //     ?.pushNamed(AddProductionWeekDataScreen.routeName,
            //     arguments: AddProductionWeekDataScreenData(
            //         cycleId: widget.cycle.id.toString(),
            //         weekNumber: selectedWeek.toString()))
            //     .then((value) => Navigator.of(context).pop(true));

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddProductionWeekDataScreen(
                  cycleId: widget.cycle.id.toString(),
                  weekNumber: selectedWeek.toString());
            })).then((value) {
              if (value != null) {
                Navigator.of(context).pop(true);
              }
            });
          }
        }
      },
    );
  }

  Widget buildHeader(List<String> weeks) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: AppColors.white,
      child: GestureDetector(
        onTap: () {
          double dialogVerticalPadding = 24;
          weeksScrollController = ScrollController(
              initialScrollOffset:
                  getWeeksTargetOffset(weeks.length, dialogVerticalPadding));

          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  insetPadding: EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: dialogVerticalPadding),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: Container(
                      child: ListView.builder(
                    controller: weeksScrollController,
                    shrinkWrap: true,
                    itemCount: weeks.length,
                    itemBuilder: (context, index) => Container(
                        color: AppColors.white,
                        child: WeekRowItem(
                          hasData: widget.cycle.weekIsExists(index + 1),
                          week: weeks[index],
                          onTap: () {
                            setState(() {
                              selectedWeek = index + 1;
                            });
                            Navigator.of(context).pop();
                          },
                        )),
                  )));
            },
          );
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(
                      Icons.close_rounded,
                      size: 28,
                      color: AppColors.Ash_grey,
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20, end: 10),
                    padding: EdgeInsetsDirectional.only(
                        start: 15, end: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.Pastel_gray, width: 1.5),
                        color: AppColors.OFF_WHITE,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        CustomText(
                          title: selectedWeek == 0
                              ? 'str_week'.tr() + " 1"
                              : 'str_week'.tr() + " $selectedWeek",
                          textColor: AppColors.Dark_spring_green,
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.Ash_grey,
                              size: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    title: widget.cycle.getLevel(selectedWeek),
                    textColor: AppColors.Liver,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ]),
      ),
    );
  }

  List<String> getWeeks() {
    List<String> list = [];
    for (var i = 1; i < 65; i++) {
      list.add('str_week'.tr() + " ${i}");
    }
    return list;
  }

  deleteCycleWeek(int cycleId, int duration) async {
    ProviderScope.containerOf(context, listen: false)
        .read(_manageCycleViewModelProvider.notifier)
        .deleteCycleWeek(context, cycleId, duration);
  }

  double getWeeksTargetOffset(int itemsLength, double dialogVerticalPadding) {
    int itemHeight = 40;
    double dialogHeight = MediaQuery.of(context).size.height -
        (dialogVerticalPadding * 2) -
        MediaQuery.of(context).viewPadding.top;
    int maxNumberOfItemsInDialog = (dialogHeight / itemHeight).ceil();

    int target = itemHeight * (selectedWeek - 1);
    if ((selectedWeek) > (itemsLength - maxNumberOfItemsInDialog)) {
      target = ((itemsLength - maxNumberOfItemsInDialog) * itemHeight) + 10;
    }
    return target.toDouble();
  }
}
