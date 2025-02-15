import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/menu_management/entities/navigation_item.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/navigation_drawer.dart';
import 'package:katkoot_elwady/features/messages_management/screens/message_content_screen.dart';
import 'package:katkoot_elwady/features/messages_management/widgets/message_row_item.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';

class MessagesListScreen extends StatefulWidget {
  static const routeName = "./messages_list_screen";

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
          showDrawer: true,
          hasbackButton: true,
          // onBackClick: () => context.read(di.contentProvider).state =
          //     DrawerItemType.drawer.index
      ),
      // drawer: NavigationDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomText(
                      textAlign: TextAlign.start,
                      title: 'str_received_messages'.tr(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Consumer(builder: (_, ref, __) {
                      var messagesViewModel =
                      ref.watch(di.messagesViewModelProvider);
                      var messages = messagesViewModel.data;
                      if (messages != null) {
                        return PaginationList(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            var message = messages[index];

                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(
                                //     MessageContentScreen.routeName,
                                //     arguments: message);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context){
                                    return MessageContentScreen(
                                      message: message,
                                    );
                                  }));
                              },
                              child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                      bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: messages[index].isSeen!
                                          ? AppColors.Mansuel
                                          : AppColors.APPLE_GREEN
                                          .withOpacity(0.3)),
                                  child: MessageRowItem(
                                      message: messages[index])),
                            );
                          },
                          itemCount: messages.length,
                          onLoadMore: () => getMessages(showLoading: false),
                          hasMore: ProviderScope.containerOf(context,
                              listen: false)
                              .read(di.messagesViewModelProvider.notifier)
                              .hasNext,
                          onRefresh: () =>
                              getMessages(showLoading: true, refresh: true),
                          loading: ProviderScope.containerOf(context,
                              listen: false).read(di.messagesViewModelProvider)
                              .isLoading,
                        );
                      } else {
                        return Container();
                      }
                    }),
                  )
                ],
              ),
            ),
            Consumer(
              builder: (_, watch, __) {
                return ScreenHandler(
                  screenProvider: di.messagesViewModelProvider,
                  noDataMessage: "str_no_data".tr(),
                  onDeviceReconnected: () => getMessages(
                      showLoading: true,
                      refresh:
                      ProviderScope.containerOf(context,
                          listen: false).read(di.messagesViewModelProvider).data !=
                          null),
                  noDataWidget: NoDataWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getMessages(showLoading: true, refresh: true);
    super.initState();
  }

  Future getMessages({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      ProviderScope.containerOf(context,
          listen: false)
          .read(di.messagesViewModelProvider.notifier)
          .getMessages(context, refresh: refresh, showLoading: showLoading);
    });
  }
}
