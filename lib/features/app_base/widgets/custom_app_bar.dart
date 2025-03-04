import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:katkoot_elwady/features/search_management/widgets/search_widget.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/report_generator/custom_toggle.dart';

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
  final bool showNotificationsButton;
  final bool showToggle;
  bool? fromMore;
  bool hasbackButton;

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
  _CustomAppBarState createState() {
    // TODO: implement createState
    return _CustomAppBarState();
  }
}

class _CustomAppBarState extends State<CustomAppBar>
    with NavigationDrawerMixin {
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
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
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
                  height: 70, // Set a fixed height to avoid extra padding
                  child: Image.asset(
                    "assets/images/home_logo.png",
                    fit: BoxFit.fill, // Adjust as needed
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
              SizedBox(
                width: 15,
              )
            ]
          : (widget.showNotificationsButton)
              ? [
                  Consumer(
                    builder: (_, ref, __) {
                      return ref.watch(_unseenNotificationCountProvider).when(
                          data: (unseenNotificationCount) => Stack(
                                children: [
                                  Center(
                                    child: IconButton(
                                        padding: EdgeInsetsDirectional.only(
                                            end: unseenNotificationCount != 0
                                                ? 20
                                                : 20),
                                        onPressed: () {
                                          // navigateToRoute(
                                          //     NavigationItem.received_messages);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return MessagesListScreen();
                                          }));
                                        },
                                        icon: Container(
                                          width: 25,
                                          height: 30,
                                          padding: EdgeInsetsDirectional.all(5),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/notification.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                  ),
                                  unseenNotificationCount != 0
                                      ? PositionedDirectional(
                                          end: 8,
                                          top: 12,
                                          child: GestureDetector(
                                            child: Container(
                                              padding:
                                                  EdgeInsetsDirectional.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.white,
                                                    width: 1.5,
                                                  ),
                                                  color: AppColors.Gamboge),
                                              child: Text(
                                                unseenNotificationCount > 99
                                                    ? 'plus_99'.tr()
                                                    : unseenNotificationCount
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            onTap: () {
                                              // context
                                              //         .read(di.contentProvider)
                                              //         .state =
                                              //     DrawerItemType
                                              //         .messagesList.index;
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MessagesListScreen();
                                              }));
                                            },
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                          loading: () {
                            return Container();
                          },
                          error: (Object error, StackTrace? stackTrace) {
                            return Container();
                          });
                    },
                  )
                ]
              : [Container()],
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
                  child: Image.asset(
                    "assets/images/menu.png",
                    fit: BoxFit.fitWidth,
                    color: Colors.white,
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
