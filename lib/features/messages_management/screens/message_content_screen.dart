import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/notification_click_handler.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/photo_hero.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class MessageContentScreen extends StatefulWidget {
  static const routeName = "./message_content";
  Message message;
  MessageContentScreen({required this.message});

  @override
  State<MessageContentScreen> createState() => _MessageContentScreenState();
}

class _MessageContentScreenState extends State<MessageContentScreen>
    with BaseViewModel {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      appBar: CustomAppBar(
        hasbackButton: true,
        onBackClick: () async {
          if(await onWillPop()){
            Navigator.pop(context);
          }
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.2,
                      horizontal: MediaQuery.of(context).size.width * .18),
                  child: Image.asset(
                    "assets/images/bg_image.png",
                  )),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: widget.message.title!,
                          textColor: AppColors.Dark_spring_green,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        CustomText(
                          title: widget.message.schedule!,
                          textColor: AppColors.Liver,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: AppColors.Snow.withOpacity(0.45),
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.message.attachmentType != "")
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  NotificationClickHandler
                                      .handleNotificationRedirection(
                                      widget.message, context);
                                },
                                child: widget.message.attachmentType !=
                                    "Image"
                                    ? Container(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 10, end: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.Liver,
                                          style: BorderStyle.solid,
                                        ),
                                        color: AppColors.white,
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                    width: MediaQuery.of(context)
                                        .orientation ==
                                        Orientation.portrait
                                        ? MediaQuery.of(context).size.width *
                                        0.6
                                        : MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.3,
                                    height: MediaQuery.of(context)
                                        .orientation ==
                                        Orientation.portrait
                                        ? MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.05
                                        : MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.1,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: widget.message
                                              .attachmentType ==
                                              "PDF" ||
                                              widget.message
                                                  .attachmentType ==
                                                  "Guide"
                                              ? Image.asset(
                                            "assets/images/group_3147.png",
                                            fit: BoxFit.contain,
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .height *
                                                0.03,
                                          )
                                              : widget.message
                                              .attachmentType ==
                                              "Video"
                                              ? Image.asset(
                                            "assets/images/video.png",
                                            fit: BoxFit
                                                .contain,
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .height *
                                                0.03,
                                          )
                                              : widget.message
                                              .attachmentType ==
                                              "External URL"
                                              ? Image.asset(
                                            "assets/images/link.png",
                                            fit: BoxFit
                                                .contain,
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .height *
                                                0.03,
                                          )
                                              : Container(),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: CustomText(
                                            title: widget.message
                                                .attachmentTitle ??
                                                "",
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ))
                                    : Container(),
                              ),
                              if (widget.message.attachmentType != "Image")
                                SizedBox(
                                  height: 25,
                                ),
                            ],
                          ),
                        CustomText(
                          title: widget.message.content!,
                          textColor: AppColors.Liver,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            NotificationClickHandler
                                .handleNotificationRedirection(
                                widget.message, context);
                          },
                          child: widget.message.attachmentType == "Image"
                              ? PhotoHero(message: widget.message)
                              : Container(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
        onWillPop: onWillPop);
  }

  @override
  void initState() {
    readMessage();
    super.initState();
  }

  Future readMessage() async {
    await Future.delayed(Duration.zero, () {
      if (widget.message.isSeen != null && widget.message.isSeen == false) {
        print("call read");

        ProviderScope.containerOf(context,
            listen: false)
            .read(di.messagesViewModelProvider.notifier)
            .readMessage(widget.message.id!);
      }
    });
  }

  Future<bool> onWillPop() async {
    if (di.appRedirectedFromNotificationNotifier.value) {
      if (await ProviderScope.containerOf(context,
          listen: false)
          .read(di.changeLanguageViewModelProvider.notifier)
          .isOnBoardingComplete()) {
        navigateToScreen(MainBottomAppBar.routeName, removeTop: true);
      } else {
        navigateToScreen(ChangeLanguageScreen.routeName, removeTop: true);
      }
      di.appRedirectedFromNotificationNotifier.value = false;
      return Future.value(false);
    }
    else {
      return Future.value(true);
    }
  }
}
