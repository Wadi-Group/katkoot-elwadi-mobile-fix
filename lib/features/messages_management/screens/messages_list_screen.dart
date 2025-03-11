import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/messages_management/widgets/message_row_item.dart';

import 'message_content_screen.dart';

enum MessagesCategory { wadi, international, local }

class MessagesListScreen extends StatefulWidget {
  static const routeName = "./messages_list_screen";
  final bool showOnlyWadi;

  MessagesListScreen({this.showOnlyWadi = false});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSelectionMode = false;
  Set<int> selectedMessageIds = {}; // Stores selected message IDs

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.showOnlyWadi ? 1 : MessagesCategory.values.length,
      vsync: this,
      initialIndex: 0,
    );
    getMessages(showLoading: true, refresh: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode; // Toggle selection mode
      if (!isSelectionMode)
        selectedMessageIds.clear(); // Clear selections when hiding
    });
  }

  void toggleMessageSelection(int messageId) {
    setState(() {
      if (selectedMessageIds.contains(messageId)) {
        selectedMessageIds.remove(messageId);
      } else {
        selectedMessageIds.add(messageId);
      }
    });
  }

  Future<void> markAsRead() async {
    if (selectedMessageIds.isNotEmpty) {
      for (var id in selectedMessageIds) {
        ProviderScope.containerOf(context, listen: false)
            .read(di.messagesViewModelProvider.notifier)
            .readMessage(id);
      }
      getMessages(refresh: true);
      toggleSelectionMode();
    }
  }

  void confirmDeleteMessages() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: EdgeInsets.all(15),
        title: CustomText(
          title: "confirm_deletion".tr(),
          textColor: AppColors.APP_BLUE,
          fontSize: 18,
        ), // Localized title
        content: CustomText(
          title: "delete_message_confirmation".tr(),
          textColor: AppColors.APP_BLUE,
          fontSize: 16,
        ), // Localized content
        actions: [
          CustomElevatedButton(
            title: "cancel".tr(),
            onPressed: () => Navigator.pop(context),
            backgroundColor: AppColors.APP_BLUE,
            textColor: AppColors.white,
            fontSize: 16,
          ),
          CustomElevatedButton(
            title: "delete".tr(),
            onPressed: () {
              Navigator.pop(context);
              deleteMessages();
            },
            backgroundColor: AppColors.REGULAR_RED,
            textColor: AppColors.white,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Future<void> deleteMessages() async {
    if (selectedMessageIds.isNotEmpty) {
      for (var id in selectedMessageIds) {
        // TODO :: Delete message api integration is pending

        // await ProviderScope.containerOf(context, listen: false)
        //     .read(di.messagesViewModelProvider.notifier)
        //     .deleteMessage(id);
      }
      getMessages(refresh: true); // Refresh messages after deletion
      toggleSelectionMode(); // Exit selection mode
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_smoke,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showDrawer: true,
        hasbackButton: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Category Tab Bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        offset: const Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  child: TabBar(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    indicatorPadding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    controller: _tabController,
                    labelColor: AppColors.APP_BLUE,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.APP_BLUE,
                    indicator: BoxDecoration(
                      color: AppColors.Tabs_Blue.withValues(
                          alpha: widget.showOnlyWadi
                              ? 0
                              : 1), // Background color for selected tab
                      borderRadius: BorderRadius.circular(30),
                    ),
                    tabs: (widget.showOnlyWadi
                            ? [MessagesCategory.wadi]
                            : MessagesCategory.values)
                        .map((category) => SizedBox(
                              height: 45,
                              child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        title:
                                            getCategoryLocalizedName(category),
                                        textColor: AppColors.APP_BLUE,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        title: "str_news".tr(),
                                        textColor: AppColors.APP_BLUE,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        lineSpacing: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (_, ref, __) {
                      var messagesViewModel =
                          ref.watch(di.messagesViewModelProvider);
                      var messages = messagesViewModel.data ?? [];

                      return TabBarView(
                        controller: _tabController,
                        children: (widget.showOnlyWadi
                                ? [MessagesCategory.wadi]
                                : MessagesCategory.values)
                            .map((category) {
                          var filteredMessages = messages
                              .where((message) =>
                                  _getCategoryName(message.category) ==
                                  category)
                              .toList();

                          return filteredMessages.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: 2,
                                      bottom: isSelectionMode &&
                                              selectedMessageIds.isNotEmpty
                                          ? 50
                                          : 0),
                                  child: PaginationList(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    itemBuilder: (context, index) {
                                      var message = filteredMessages[index];
                                      return GestureDetector(
                                        onLongPress: toggleSelectionMode,
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
                                            SizedBox(height: 8),
                                            Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                bottom: 10,
                                                start: 20,
                                                end: 20,
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: message.isSeen!
                                                    ? AppColors.Message_seen
                                                    : AppColors.Tabs_Blue,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  if (isSelectionMode)
                                                    Checkbox(
                                                      checkColor:
                                                          AppColors.white,
                                                      activeColor:
                                                          AppColors.APP_BLUE,
                                                      value: selectedMessageIds
                                                          .contains(message.id),
                                                      onChanged: (_) =>
                                                          toggleMessageSelection(
                                                              message.id!),
                                                    ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        MessageRowItem(
                                                            message: message),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.APP_BLUE,
                                              thickness: .1,
                                              height: .2,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: filteredMessages.length,
                                    onLoadMore: () =>
                                        getMessages(showLoading: false),
                                    hasMore: ref
                                        .read(di
                                            .messagesViewModelProvider.notifier)
                                        .hasNext,
                                    onRefresh: () => getMessages(
                                        showLoading: true, refresh: true),
                                    loading: messagesViewModel.isLoading,
                                  ),
                                )
                              : Center(
                                  child: CustomText(
                                  title: "no_notifications".tr(),
                                  fontSize: 16,
                                  textColor: AppColors.APP_BLUE,
                                  fontWeight: FontWeight.bold,
                                ));
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
            // "Mark as Read" Button
            // "Mark as Read" & "Delete" Buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: isSelectionMode && selectedMessageIds.isNotEmpty,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      // Delete Button
                      Expanded(
                        child: CustomElevatedButton(
                          title: "delete".tr(),
                          onPressed: confirmDeleteMessages,
                          backgroundColor: AppColors.REGULAR_RED,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10), // Spacing between buttons
                      // Mark as Read Button
                      Expanded(
                        child: CustomElevatedButton(
                          title: "mark_as_read".tr(),
                          onPressed: markAsRead,
                          backgroundColor: AppColors.APP_BLUE,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getMessages({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(di.messagesViewModelProvider.notifier)
          .getMessages(context, refresh: refresh, showLoading: showLoading);
    });
  }

  MessagesCategory _getCategoryName(Category? category) {
    switch (category?.categoryId) {
      case 1:
        return MessagesCategory.wadi;
      case 2:
        return MessagesCategory.international;
      case 3:
        return MessagesCategory.local;
      default:
        return MessagesCategory.wadi;
    }
  }

  String getCategoryLocalizedName(MessagesCategory category) {
    switch (category) {
      case MessagesCategory.wadi:
        return "wadi".tr();
      case MessagesCategory.international:
        return "international".tr();
      case MessagesCategory.local:
        return "local".tr();
      default:
        return "unknown".tr();
    }
  }
}
