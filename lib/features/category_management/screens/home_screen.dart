import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/category_management/widgets/category_tab_widget.dart';
import '../../../core/di/injection_container.dart' as di;
import '../../../core/services/remote/weather_service.dart';
import '../../app_base/entities/base_state.dart';
import '../../app_base/screens/custom_drawer.dart';
import '../../menu_management/view_models/menu_categorized_videos_view_model.dart';
import '../models/category.dart';
import '../sections/alaf_alwadi_prices_section.dart';
import '../sections/live_chat_and_news_section.dart';
import '../sections/report_generator_section.dart';
import '../sections/auto_scrolling_text_section.dart';
import '../sections/video_section.dart';
import '../sections/weather_and_prices_section.dart';

class HomeScreen extends StatefulWidget with BaseViewModel {
  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ===================================================== Variables =====================================================
  late String? date = '';
  late String? city = '';
  late String? weather = '';

  final List<Map<String, String>> prices = [
    {
      "title": "starter_feed".tr(),
      "price": "24,750",
      "image": "assets/images/starter_feed.png"
    },
    {
      "title": "grower_feed".tr(),
      "price": "24,500",
      "image": "assets/images/grower_feed.png"
    },
    {
      "title": "finisher_feed".tr(),
      "price": "24,250",
      "image": "assets/images/finisher_feed.png"
    },
  ];

  // ===================================================== Functions =====================================================
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    initUserLocalData();
    getListOfCategories();
    getNews();
    getAllVideos();
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
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      ProviderScope.containerOf(context, listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .getRemoteUnseenNotificationCount();
      ProviderScope.containerOf(context, listen: false)
          .read(di.categoriesViewModelProvider.notifier)
          .getListOfCategories(mainCategories: true);
    });
  }

// Initialize user local data
  Future initUserLocalData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(di.userViewModelProvider.notifier)
          .getLocalUserData();
    });
  }

  // Get News
  Future getNews({bool showLoading = false, bool refresh = false}) async {
    await Future.delayed(Duration.zero, () {
      print("call categoryGuideViewModel");
      ProviderScope.containerOf(context, listen: false)
          .read(di.messagesViewModelProvider.notifier)
          .getMessages(context, refresh: refresh, showLoading: showLoading);
    });
  }

  // Get latest video
  final _categorizedVideosViewModelProvider = StateNotifierProvider<
      MenuCategorizedVideosViewModel, BaseState<List<Category>?>>((ref) {
    return MenuCategorizedVideosViewModel(ref.read(di.repositoryProvider));
  });
  Future getAllVideos() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(_categorizedVideosViewModelProvider.notifier)
          .getVideos();
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
                    //  WeatherAndPricesSection
                    WeatherAndPricesSection(
                      city: city ?? "Cairo",
                      date: date ?? '',
                      weather: weather ?? "",
                      liveBroilersPrice: "70.50",
                      eggTrayPrice: "125.25",
                      katkootPrice: "70.50",
                    ),
                    _sizedBox,

                    // CategoriesSection
                    Consumer(builder: (_, ref, __) {
                      var categoriesViewModel =
                          ref.watch(di.categoriesViewModelProvider);
                      var categories = categoriesViewModel.data;
                      return ListView.builder(
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
                      );
                    }),

                    //  AlafAlWadiPricesSection
                    AlafAlWadiPrices(
                      prices: prices,
                    ),
                    _sizedBox,

                    //  AutoScrollingTextSection
                    Consumer(builder: (_, ref, __) {
                      var messagesViewModel =
                          ref.watch(di.messagesViewModelProvider);
                      var messages = messagesViewModel.data;
                      if (messages != null && messages.isNotEmpty) {
                        return AutoScrollingTextSection(
                            rotatingTexts: messages);
                      }
                      return Container();
                    }),
                    _sizedBox,

                    //  LiveChatAndNewsSection
                    LiveChatAndNewsSection(),
                    _sizedBox,

                    // VideoSection
                    Consumer(builder: (_, ref, __) {
                      var videosViewModel =
                          ref.watch(_categorizedVideosViewModelProvider);
                      var videos = videosViewModel.data;
                      var latestVideo = videos?.last;
                      return videos != null && videos.isNotEmpty
                          ? VideoSection(video: latestVideo)
                          : Container();
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
