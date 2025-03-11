import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/messages_management/widgets/message_row_item.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_widget.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/custom_toggle.dart';
import '../../messages_management/screens/message_content_screen.dart';
import '../view_models/app_bar_tabs_view_model.dart';
import 'tabbar/app_tabbar.dart';
import 'tabbar/tabbar_data.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final List<TabbarData>? tabs;
  final TabController? controller;
  final Function()? onTapPressed;
  final String? title;
  final AppBarTabsViewModel? appBarTabsViewModel;
  final bool showDrawer;
  bool isSearchAppBar;
  final Function()? onSearchSubmit;
  final Function? onBackClick;
  final Function? onToggle;
  ToggleCases? intialCase;
  final bool showToggle;
  bool? fromMore;
  bool hasbackButton;
  final bool showNotificationsButton;

  CustomAppBar({
    Key? key,
    this.tabs,
    this.controller,
    this.onTapPressed,
    this.title,
    this.onBackClick,
    this.onSearchSubmit,
    this.fromMore,
    this.isSearchAppBar = false,
    this.hasbackButton = true,
    this.appBarTabsViewModel,
    this.onToggle,
    this.intialCase,
    this.showDrawer = false,
    this.showToggle = false,
    this.showNotificationsButton = false,
  })  : preferredSize = Size.fromHeight(tabs == null ? 70.0 : 130),
        super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _unseenNotificationCountProvider =
      StreamProvider.autoDispose<int>((ref) {
    ref.watch(di.unseenNotificationCountProvider);
    return Stream.fromFuture(ref
        .read(di.unseenNotificationCountProvider.notifier)
        .getUnseenNotificationCount());
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.white),
      toolbarHeight: 70,
      centerTitle: widget.isSearchAppBar ? false : !widget.showToggle,
      backgroundColor: AppColors.DARK_SPRING_GREEN,
      title: widget.isSearchAppBar
          ? SearchWidget(onSearchSubmit: widget.onSearchSubmit)
          : widget.title != null
              ? FittedBox(
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(
                  height: 70,
                  child: Image.asset(
                    "assets/images/home_logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
      automaticallyImplyLeading: true,
      actions: widget.showToggle
          ? [
              ToggleButton(
                onToggle: () {
                  if (widget.onToggle != null) {
                    return widget.onToggle!();
                  }
                },
                intialCase: widget.intialCase ?? ToggleCases.REARING,
              ),
              SizedBox(width: 15),
            ]
          : [
              if (widget.showNotificationsButton)
                Consumer(
                  builder: (_, ref, __) {
                    final messagesState =
                        ref.watch(di.messagesViewModelProvider);
                    final unseenNotificationCount =
                        ref.watch(_unseenNotificationCountProvider).maybeWhen(
                              data: (count) => count,
                              orElse: () => 0,
                            );

                    return PopupMenuButton<int>(
                      offset: Offset(0, 55),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.85,
                          maxHeight: MediaQuery.of(context).size.height * 0.75),
                      icon: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 25,
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/notification.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          if (unseenNotificationCount > 0)
                            PositionedDirectional(
                              end: 0,
                              top: 7,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 1.5,
                                    ),
                                    color: AppColors.Gamboge),
                                child: Text(
                                  unseenNotificationCount > 99
                                      ? '99+'
                                      : unseenNotificationCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      itemBuilder: (context) {
                        final messages = messagesState.data;

                        return [
                          PopupMenuItem(
                            enabled: false,
                            child: CustomText(
                              title: "notifications".tr(),
                              textColor: AppColors.DARK_SPRING_GREEN,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (messages == null || messages.isEmpty)
                            PopupMenuItem(
                              enabled: false,
                              child: Center(
                                child: CustomText(
                                  title: "no_notifications".tr(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  textColor: AppColors.DARK_SPRING_GREEN,
                                ),
                              ),
                            )
                          else
                            ...messages.map((message) => PopupMenuItem(
                                  enabled: false,
                                  padding: EdgeInsets.all(0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MessageContentScreen(
                                                  message: message),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        MessageRowItem(message: message),
                                        Divider(
                                          color: AppColors.DARK_SPRING_GREEN,
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MessagesListScreen(showOnlyWadi: true),
                                  ),
                                );
                              },
                              child: Center(
                                child: CustomText(
                                  title: "str_view_all".tr(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  textColor: AppColors.DARK_SPRING_GREEN,
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    );
                  },
                )
            ],
      leading: widget.hasbackButton
          ? IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColors.white,
              ),
              onPressed: () {
                if (widget.onBackClick != null) {
                  widget.onBackClick!();
                } else {
                  Navigator.pop(context);
                }
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            )
          : GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Transform.rotate(
                    angle: context.locale.languageCode == "ar" ? 3.14 : 0,
                    child: Image.asset(
                      "assets/images/menu.png",
                      fit: BoxFit.fitWidth,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
      bottom: widget.tabs != null
          ? AppTabbar(
              tabController: widget.controller,
              tabs: widget.tabs!,
              onTapPressed: widget.onTapPressed,
            )
          : null,
    );
  }
}
