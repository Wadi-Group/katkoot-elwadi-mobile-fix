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

enum MessagesCategory { wadi, international, local }

class MessagesListScreen extends StatefulWidget {
  static const routeName = "./messages_list_screen";

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
    _tabController =
        TabController(length: MessagesCategory.values.length, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_smoke,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showDrawer: true,
        hasbackButton: true,
        title: "Messages".tr(),
      ),
      body: Stack(
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
                  controller: _tabController,
                  labelColor: AppColors.APP_BLUE,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.APP_BLUE,
                  tabs: MessagesCategory.values
                      .map((category) => Tab(
                            child: CustomText(
                              title: getCategoryLocalizedName(category),
                              textColor: AppColors.APP_BLUE,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
                      children: MessagesCategory.values.map((category) {
                        var filteredMessages = messages
                            .where((message) =>
                                _getCategoryName(message.category) == category)
                            .toList();

                        return filteredMessages.isNotEmpty
                            ? PaginationList(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 60),
                                itemBuilder: (context, index) {
                                  var message = filteredMessages[index];
                                  return GestureDetector(
                                    onLongPress: toggleSelectionMode,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: message.isSeen!
                                            ? AppColors.Message_seen
                                            : AppColors.Tabs_Blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          if (isSelectionMode)
                                            Checkbox(
                                              checkColor: AppColors.white,
                                              activeColor: AppColors.APP_BLUE,
                                              side: BorderSide(
                                                color: message.isSeen!
                                                    ? Colors.grey
                                                        .withValues(alpha: 0.5)
                                                    : AppColors
                                                        .APP_BLUE, // Grey if disabled
                                                width: 2,
                                              ),
                                              value: selectedMessageIds
                                                  .contains(message.id),
                                              onChanged: message
                                                      .isSeen! // Disable if seen
                                                  ? null
                                                  : (_) =>
                                                      toggleMessageSelection(
                                                          message.id!),
                                            ),
                                          Expanded(
                                            child: MessageRowItem(
                                                message: message),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: filteredMessages.length,
                                onLoadMore: () =>
                                    getMessages(showLoading: false),
                                hasMore: ref
                                    .read(di.messagesViewModelProvider.notifier)
                                    .hasNext,
                                onRefresh: () => getMessages(
                                    showLoading: true, refresh: true),
                                loading: messagesViewModel.isLoading,
                              )
                            : Center(child: Text("No messages available"));
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
          // "Mark as Read" Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: isSelectionMode && selectedMessageIds.isNotEmpty,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                child: CustomElevatedButton(
                  title: "mark_as_read".tr(),
                  onPressed: markAsRead,
                  backgroundColor: AppColors.APP_BLUE,
                  textColor: Colors.white,
                ),
                //  ElevatedButton(
                //   onPressed: markAsRead,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.APP_BLUE,
                //     padding: EdgeInsets.symmetric(vertical: 12),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   child: Text(
                //     "mark_as_read".tr(),
                //     style: TextStyle(color: Colors.white, fontSize: 16),
                //   ),
                // ),
              ),
            ),
          ),
        ],
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
