import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/category_management/widgets/category_tab_widget.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/di/injection_container.dart' as di;
import '../../../core/services/remote/weather_service.dart';
import '../../../core/utils/check_internet_connection.dart';
import '../../app_base/entities/base_state.dart';
import '../../app_base/screens/custom_drawer.dart';
import '../../guides_management/models/video.dart';
import '../../menu_management/view_models/menu_categorized_videos_view_model.dart';
import '../models/category.dart';
import '../sections/alaf_alwadi_prices_section.dart';
import '../sections/auto_scrolling_text_section.dart';
import '../sections/live_chat_and_news_section.dart';
import '../sections/report_generator_section.dart';
import '../sections/video_section.dart';
import '../sections/weather_and_prices_section.dart';
import '../widgets/in_app_message_pop_up.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget with BaseViewModel {
  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // ===================================================== Variables =====================================================
  late String? date = '';
  late String? city = '';
  late String? weather = '';

  late Map<String, dynamic> homeData = {};
  late Map<String, dynamic> inAppMessageData = {};
  final List<Map<String, String>> alaafPrices = [];
  // ===================================================== Functions =====================================================
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    initUserLocalData();
    getListOfCategories();
    getNews();
  }

  //  Fetch weather data from the API
  Future fetchWeatherData() async {
    var data = await WeatherService.getWeatherByCity();
    if (data != null) {
      setState(() {
        city = data['city'];
        weather = data['weather']['temperature'].toString();
        date = data['date'];
      });

      print("City: ${data['city']}");
      print("Temperature: ${data['weather']['temperature']}°C");
      print("Date: ${data['date']}");
    } else {
      print("Failed to fetch weather.");
    }
  }

  // Get list of categories
  Future getListOfCategories() async {
    setState(() {
      homeData = {}; // Reset before fetching
    });

    var categoriesViewModel = ProviderScope.containerOf(context, listen: false)
        .read(di.categoriesViewModelProvider.notifier);

    // Check network connectivity

    bool isOnline = await checkInternetConnection();

    if (isOnline) {
      print("Fetching categories and home data (Online)...");

      // Fetch data from API
      await categoriesViewModel.getListOfCategories(mainCategories: true);
      homeData = await categoriesViewModel.getHomeData();

      if (homeData.isNotEmpty) {
        alaafPrices.clear(); // Clear old data
        alaafPrices.addAll([
          {
            "title": "starter_feed".tr(),
            "price": homeData["starter_feed_price"] ?? "N/A",
            "image": "assets/images/starter_feed.png"
          },
          {
            "title": "grower_feed".tr(),
            "price": homeData["grower_feed_price"] ?? "N/A",
            "image": "assets/images/grower_feed.png"
          },
          {
            "title": "finisher_feed".tr(),
            "price": homeData["finisher_feed_price"] ?? "N/A",
            "image": "assets/images/finisher_feed.png"
          },
        ]);

        // Save data to Hive for offline access
        var box = await Hive.openBox<Map>('homeDataBox');
        await box.put('homeData', homeData);
      }

      // Fetch In-App Messages and Show
      inAppMessageData = await categoriesViewModel.getInAppMessageData();
      print("inAppMessageData: $inAppMessageData");
      showInAppMessage(inAppMessageData, context);
    } else {
      print("No internet connection. Loading cached categories...");
      await categoriesViewModel.getListOfCategories(mainCategories: true);

      // Load cached data from Hive
      var box = await Hive.openBox<Map>('homeDataBox');
      var cachedData = box.get('homeData', defaultValue: {}) ?? {};

      homeData = Map<String, dynamic>.from(cachedData);

      if (homeData.isNotEmpty) {
        alaafPrices.clear(); // Clear old data
        alaafPrices.addAll([
          {
            "title": "starter_feed".tr(),
            "price": homeData["starter_feed_price"] ?? "N/A",
            "image": "assets/images/starter_feed.png"
          },
          {
            "title": "grower_feed".tr(),
            "price": homeData["grower_feed_price"] ?? "N/A",
            "image": "assets/images/grower_feed.png"
          },
          {
            "title": "finisher_feed".tr(),
            "price": homeData["finisher_feed_price"] ?? "N/A",
            "image": "assets/images/finisher_feed.png"
          },
        ]);
      }
    }

    setState(() {}); // Refresh UI after loading data
  }

  // Show in-app message

// Initialize user local data
  Future initUserLocalData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(di.userViewModelProvider.notifier)
          .getLocalUserData();
    });
  }

  // Get News
  Future getNews({bool showLoading = true, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      ProviderScope.containerOf(context, listen: false)
          .read(di.messagesViewModelProvider.notifier)
          .getMessages(context, refresh: refresh, showLoading: showLoading);
    });
  }

  @override
  Widget build(BuildContext context) {
    final SizedBox _sizedBox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.025,
    );
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: customAppBar,
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Consumer(builder: (_, ref, __) {
                      var categoriesViewModel =
                          ref.watch(di.categoriesViewModelProvider);
                      var categories = categoriesViewModel.data;

                      return Column(children: [
                        //  WeatherAndPricesSection
                        WeatherAndPricesSection(
                          city: city,
                          date: date,
                          weather: weather,
                          liveBroilersPrice: homeData["live_broilers_price"],
                          whiteEggTrayPrice: homeData["white_egg_tray_price"],
                          brownEggTrayPrice: homeData["brown_egg_tray_price"],
                          katkootPrice:
                              homeData["katkoot_alwadi_broilers_price"],
                        ),
                        _sizedBox,

                        // CategoriesSection

                        ListView.builder(
                          itemCount: categories!.length,
                          itemBuilder: (context, index) => Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CategoryTabWidget(
                                category: categories[index],
                              ),
                            ),
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),

                        //  AlafAlWadiPricesSection
                        AlafAlWadiPrices(
                          prices: alaafPrices,
                        ),
                        _sizedBox,
                      ]);
                    }),

                    //  AutoScrollingTextSection
                    Consumer(builder: (_, ref, __) {
                      var messagesViewModel =
                          ref.watch(di.messagesViewModelProvider);
                      var messages = messagesViewModel.data;

                      if (messages == null || messages.isEmpty) {
                        // Show a placeholder message when there are no messages
                        return AutoScrollingTextSection(
                          rotatingTexts: [
                            Message(
                                id: 1, content: "No messages available".tr()),
                          ],
                        );
                      }
                      return AutoScrollingTextSection(rotatingTexts: messages);
                    }),
                    _sizedBox,

                    //  LiveChatAndNewsSection
                    LiveChatAndNewsSection(),
                    _sizedBox,

                    // VideoSection
                    Consumer(builder: (_, ref, __) {
                      if (homeData.isEmpty) return SizedBox.shrink();
                      var homeVideo = Category(
                          id: 0,
                          imageUrl: homeData["video_image"],
                          videosList: [
                            Video(
                                id: 0,
                                title: homeData["video_title"],
                                url: Url(
                                    url: homeData["home_page_video"],
                                    provider: AppConstants.YOUTUBE_PROVIDER))
                          ]);
                      return VideoSection(video: homeVideo);
                    }),
                    _sizedBox,

                    // ReportGeneratorSection
                    ReportGeneratorSection(),
                  ],
                ),
              ),
            ),
          ),
          Consumer(
            builder: (_, watch, __) {
              return ScreenHandler(
                screenProvider: di.categoriesViewModelProvider,
                noDataMessage: "str_no_data".tr(),
                onDeviceReconnected: getListOfCategories,
                noDataWidget: NoDataWidget(),
              );
            },
          ),
          Consumer(
            builder: (_, watch, __) {
              return ScreenHandler(
                screenProvider: di.navigationDrawerViewModelProvider,
                noDataMessage: "str_no_data".tr(),
                onDeviceReconnected: () {},
                noDataWidget: NoDataWidget(),
              );
            },
          ),
        ],
      ),
    );
  }

  var customAppBar = CustomAppBar(
    showDrawer: true,
    showNotificationsButton: true,
    hasbackButton: false,
  );
}
