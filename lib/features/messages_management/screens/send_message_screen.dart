import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/menu_management/entities/navigation_item.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/navigation_drawer.dart';
import 'package:katkoot_elwady/features/messages_management/widgets/custom_message_widget.dart';

class SendSupportMessageScreen extends StatefulWidget
    with NavigationDrawerMixin {
  static const routeName = "./send_support_message";

  @override
  _SendSupportMessageScreenState createState() =>
      _SendSupportMessageScreenState();
}

class _SendSupportMessageScreenState extends State<SendSupportMessageScreen> with AutomaticKeepAliveClientMixin {
  int val = 1;
  TextEditingController messageTextController = TextEditingController();
  String? msgError;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * .06;
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
            showDrawer: true,
            showNotificationsButton: true,
            hasbackButton: true,
            // onBackClick: () => context.read(di.contentProvider).state =
            //     DrawerItemType.drawer.index
        ),
        // drawer: NavigationDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                    child: Column(
                      children: [
                        CustomText(
                          title: "ask_for_support".tr(),
                          textColor: AppColors.Liver,
                          fontSize: 20,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 30, top: 20, bottom: 05),
                                  child: CustomText(
                                    title: "category".tr(),
                                    fontSize: 17,
                                    textColor: AppColors.Liver,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Consumer(builder: (_, ref, __) {
                                var categoriesViewModel =
                                ref.watch(di.categoriesViewModelProvider);
                                var categories = categoriesViewModel.data;

                                return ListView.builder(
                                  itemCount: categories != null
                                      ? categories.length
                                      : 0,
                                  itemBuilder: (context, index) => Center(
                                    child: Container(
                                      child: ListTile(
                                        title:
                                        Text(categories![index].title!),
                                        leading: Radio(
                                          value: categories[index].id!,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = value as int;
                                            });
                                          },
                                          activeColor:
                                          AppColors.Princeton_Orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                );
                              }),
                            ],
                          ),
                        ),
                        Consumer(builder: (_, ref, __) {
                          var messageViewModel =
                          ref.watch(di.messagesViewModelProvider.notifier);
                          return Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomMessageWidget(
                                    controller: messageTextController,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (msgError != null)
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15, end: 15),
                                      child: Text(
                                        msgError!.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: AppColors.ERRORS_RED,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsetsDirectional.only(
                                    start: 15, end: 15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.3,
                                      child: CustomElevatedButton(
                                        title: "str_send".tr(),
                                        textColor: AppColors.white,
                                        backgroundColor:
                                        AppColors.Olive_Drab,
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();

                                          setState(() {
                                            msgError = messageViewModel
                                                .validateMessage(
                                                context,
                                                messageTextController
                                                    .text,
                                                val,
                                                messageTextController);
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.3,
                                      child: CustomElevatedButton(
                                        title: "str_cancel".tr(),
                                        textColor: AppColors.white,
                                        backgroundColor:
                                        AppColors.calc_bef_btn,
                                        onPressed: () {
                                          //widget.resetDrawerSelection();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (_, watch, __) {
                  return ScreenHandler(
                    screenProvider: di.messagesViewModelProvider,
                    noDataMessage: "str_no_data".tr(),
                    onDeviceReconnected: () {},
                    noDataWidget: NoDataWidget(),
                  );
                },
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    resetMessages();
    super.initState();
  }

  Future resetMessages() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(di.messagesViewModelProvider.notifier).resetState();
    });
  }
}
