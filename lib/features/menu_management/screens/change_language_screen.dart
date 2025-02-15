import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/change_language_widget.dart';
import '../../../core/di/injection_container.dart' as di;

class ChangeLanguageScreen extends StatefulWidget {
  static const routeName = "./change_language";

  @override
  ChangeLanguageState createState() {
    // TODO: implement createState
    return ChangeLanguageState();
  }

}

class ChangeLanguageState extends State<ChangeLanguageScreen> with NavigationDrawerMixin, BaseViewModel, AutomaticKeepAliveClientMixin {
  final _isOnBoardingComplete = StreamProvider.autoDispose<bool>((ref) {
    return Stream.fromFuture(ref
        .read(di.changeLanguageViewModelProvider.notifier)
        .isOnBoardingComplete());
  });

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (_, ref, __){
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: ref.watch(_isOnBoardingComplete).when(
            data: (onBoardingShown) => onBoardingShown
                ? CustomAppBar(
              showDrawer: true,
              hasbackButton: true,
              // onBackClick: () {
              //   _performBackAction();
              // }
            )
                : null,
            error: (Object error, StackTrace? stackTrace) {},
            loading: () {},
          ),
          // drawer: NavigationDrawer(),
          body: ref.watch(_isOnBoardingComplete).when(
            data: (onBoardingShown) => onBoardingShown
                ? _changeLanguageContent(context, ref)
                : _changeLanguageContent(context, ref),
            error: (Object error, StackTrace? stackTrace) {},
            loading: () {},
          ),
        );
      },
    );
  }

  Widget _changeLanguageContent(BuildContext context, WidgetRef ref) {
    var modelView = ref.watch(di.changeLanguageViewModelProvider);
    var modelViewFunctions = ref.watch(di.changeLanguageViewModelProvider.notifier);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: MediaQuery.of(context).size.width * .18),
                  child: Image.asset("assets/images/bg_image.png"))),
          // BackgroundWidget(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ref.watch(_isOnBoardingComplete).when(
                    data: (onBoardingShown) => !onBoardingShown
                        ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .14),
                      child: Image.asset("assets/images/black_logo.png",
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.width * .2),
                    )
                        : SizedBox(
                      height: 0,
                      width: 0,
                    ),
                    error: (Object error, StackTrace? stackTrace) {
                      return SizedBox(height: 0, width: 0);
                    },
                    loading: () {
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .14),
                        child: Image.asset("assets/images/black_logo.png",
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.width * .2),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .14,
                  ),
                  CustomText(
                    textColor: AppColors.Dark_spring_green,
                    title: "Choose App language",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    textColor: AppColors.Liver,
                    title: "اختر لغه التطبيق",
                    fontSize: 16,
                    fontFamily: "GE_SS_Two",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ChangeLanguageWidget(
                    title: "English",
                    value: "en",
                    groupValue: modelView.data,
                    onChanged: () {
                      modelViewFunctions.changeLanguage("en");
                      modelViewFunctions.confirmLanguageToggle();
                      navigateToScreen(MainBottomAppBar.routeName,
                          removeTop: true);
                      // context.read(di.contentProvider).state =
                      //     DrawerItemType.home.index;
                    },
                    imagePath: "assets/images/gb.png",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ChangeLanguageWidget(
                    title: "العربية",
                    value: "ar",
                    groupValue: modelView.data,
                    onChanged: () {
                      modelViewFunctions.changeLanguage("ar");
                      modelViewFunctions.confirmLanguageToggle();
                      navigateToScreen(MainBottomAppBar.routeName,
                          removeTop: true);
                      // context.read(di.contentProvider).state =
                      //     DrawerItemType.home.index;
                    },
                    imagePath: "assets/images/eg.png",
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: MediaQuery.of(context).size.width * .12),
                  //   width: MediaQuery.of(context).size.width,
                  //   child: CustomElevatedButton(
                  //     title: 'str_save'.tr(),
                  //     textColor: AppColors.white,
                  //     backgroundColor: AppColors.Olive_Drab,
                  //     onPressed: () {
                  //       modelViewFunctions.confirmLanguageToggle();
                  //       //resetDrawerSelection();
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
