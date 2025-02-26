import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/messages_management/screens/message_content_screen.dart';
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
        child: Column(
          children: [
            // Category Tab Bar
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
                    spreadRadius: 0.5,
                    blurRadius: .5,
                    offset: const Offset(.5, .5),
                  ),
                ],
                color: AppColors.white,
              ),
              child: TabBar(
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                indicatorPadding: const EdgeInsets.only(top: 5, bottom: 5),
                controller: _tabController,
                labelColor: AppColors.APP_BLUE,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.APP_BLUE,
                indicator: BoxDecoration(
                  color: AppColors.Tabs_Blue.withValues(
                      alpha: 1), // Background color for selected tab
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: MessagesCategory.values
                    .map((category) => SizedBox(
                          height: 45,
                          child: Tab(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  title: getCategoryLocalizedName(category),
                                  textColor: AppColors.APP_BLUE,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  lineSpacing: 0,
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
                          )),
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                var message = filteredMessages[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MessageContentScreen(
                                                message: message),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        bottom: 10, start: 20, end: 20),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: message.isSeen!
                                          ? AppColors.Message_seen
                                          : AppColors.Tabs_Blue,
                                    ),
                                    child: MessageRowItem(message: message),
                                  ),
                                );
                              },
                              itemCount: filteredMessages.length,
                              onLoadMore: () => getMessages(showLoading: false),
                              hasMore: ref
                                  .read(di.messagesViewModelProvider.notifier)
                                  .hasNext,
                              onRefresh: () =>
                                  getMessages(showLoading: true, refresh: true),
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
        return "wadi".tr(); // Ensure "wadi" is in localization files
      case MessagesCategory.international:
        return "international".tr();
      case MessagesCategory.local:
        return "local".tr();
      default:
        return "unknown".tr();
    }
  }
}
