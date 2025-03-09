import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/services/remote/social_login_service.dart';
import 'package:katkoot_elwady/core/utils/integer_text_input_formatter.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/screens/register_screen.dart';

import '../../../core/di/injection_container.dart' as di;
import '../../app_base/screens/custom_drawer.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "./LoginScreen";
  final MaterialPageRoute? nextRoute;

  LoginScreen({this.nextRoute});

  @override
  LoginState createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> with BaseViewModel {
  AuthViewModel? userModelViewProvider;

  late final authViewProvider =
      StateNotifierProvider<AuthViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return AuthViewModel(ref.read(di.repositoryProvider),
        nextRoute: widget.nextRoute);
  });

  TextEditingController phoneController = TextEditingController();
  late final _errorsProvider =
      Provider.autoDispose<List<UserFormsErrors>>((ref) {
    return ref.watch(authViewProvider).data;
  });
  String _countryCode = "+20";
  ValueNotifier<String> _countryImageNotifier = ValueNotifier("🇪🇬");

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        userModelViewProvider = ref.watch(authViewProvider.notifier);
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: CustomAppBar(
            showDrawer: false,
            hasbackButton: false,
            showNotificationsButton: true,
          ),
          backgroundColor: AppColors.LIGHT_BACKGROUND,
          body: GestureDetector(
            onTap: () {
              hideKeyboard();
            },
            child: SafeArea(
              child: Stack(
                children: [
                  // Positioned(
                  //     bottom: 0,
                  //     left: 0,
                  //     right: 0,
                  //     child: Image.asset("assets/images/bg_image.png")),

                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsetsDirectional.only(
                        top: 2, bottom: 8, start: 20, end: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            title: 'login'.tr(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.APP_BLUE,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            title: 'login_elite'.tr(),
                            fontSize: 14,
                            textColor: AppColors.APP_BLUE,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          buildForm(),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding:
                                EdgeInsetsDirectional.only(start: 15, end: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildLoginButton(),
                                SizedBox(
                                  width: 20,
                                ),

                                // Facebook Login Button
                                buildSocialButton(
                                  icon: "facebook_social",
                                  iconColor: Color(0xFF3B5998),
                                  onPressed: () async {
                                    print("Facebook Login Clicked");
                                    // Handle Facebook Login
                                    var user = await SocialLoginService()
                                        .signInWithFacebook();
                                    print(user?.email);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                // Google Login Button
                                buildSocialButton(
                                  icon: "google",
                                  onPressed: () async {
                                    print("Google Login Clicked");
                                    // Handle Google Login
                                    var user = await SocialLoginService()
                                        .signInWithGoogle();
                                    print(user?.email);
                                  },
                                ),

                                // Apple Login Button
                                Visibility(
                                  visible: Platform.isIOS,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      buildSocialButton(
                                        icon: "apple-logo",
                                        onPressed: () async {
                                          print("Apple Login Clicked");
                                          // Handle Apple Login
                                          var user = await SocialLoginService()
                                              .signInWithApple();
                                          print(user?.email);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                title: "Don't have an account ?".tr(),
                                fontSize: 12,
                                textColor: AppColors.APP_BLUE,
                              ),
                              InkWell(
                                onTap: () {
                                  userModelViewProvider!.resetState();
                                  // navigateToScreen(RegisterScreen.routeName);
                                  // AppConstants.navigatorKey.currentContext!
                                  //     .read(di.contentProvider)
                                  //     .state =
                                  //     DrawerItemType.registerScreen.index;
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                                child: CustomText(
                                  title: 'Register'.tr(),
                                  fontSize: 14,
                                  textColor: AppColors.Olive_Drab,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (_, watch, __) {
                      return ScreenHandler(
                        screenProvider: authViewProvider,
                        noDataMessage: "str_no_data".tr(),
                        // onDeviceReconnected: getListfCategories,
                        noDataWidget: NoDataWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildForm() {
    return Consumer(builder: (_, ref, __) {
      final errors = ref.watch(_errorsProvider);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomTextField(
            controller: phoneController,
            hintText: "phone_number".tr().toUpperCase(),
            inputType: TextInputType.phone,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            inputFormatter: [IntegerTextInputFormatter()],
            fontSize: 14,
            prefixIcon: buildCountryDialog(),
            errorMessage: errors
                .firstWhere(
                    (element) => element.field == UserFields.PHONE.field,
                    orElse: () => UserFormsErrors())
                .message),
      );
    });
  }

  buildCountryDialog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (country) {
              _countryCode = country.countryCode;
              _countryImageNotifier.value = country.flagEmoji;
            },
            favorite: ['+20', 'EG'],
            countryListTheme: CountryListThemeData(
              flagSize: 30,
              backgroundColor: Colors.white,
              bottomSheetHeight: MediaQuery.of(context).size.height - 100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              inputDecoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          );
        },
        child: ValueListenableBuilder<String>(
            valueListenable: _countryImageNotifier,
            builder: (context, countryImage, child) {
              return Text(
                countryImage,
                style: TextStyle(fontSize: 25),
              );
            }),
      ),
    );
  }

  buildLoginButton() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.APP_CARDS_BLUE.withAlpha(25),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: CustomElevatedButton(
          fontSize: 17,
          title: 'login'.tr(),
          textColor: AppColors.APP_BLUE,
          backgroundColor: AppColors.white,
          onPressed: () {
            hideKeyboard();
            _loginSMS();
          },
        ),
      ),
    );
  }

  buildSkipButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.APP_CARDS_BLUE.withAlpha(25),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(1, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: CustomElevatedButton(
          fontSize: 17,
          title: 'skip'.tr(),
          textColor: AppColors.APP_BLUE,
          backgroundColor: AppColors.white,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              hideKeyboard();
              ProviderScope.containerOf(context, listen: false)
                  .read(di.bottomNavigationViewModelProvider.notifier)
                  .changeIndex(0);
            }
          }),
    );
  }

  Future<void> _loginSMS() async {
    userModelViewProvider!.validatePhoneFeilds(
        context: context,
        phone: "${phoneController.text}",
        countryCode: _countryCode,
        isFromRegisterScreen: false);
  }

  Widget buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 43,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ), // Added padding for better spacing
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Image.asset(
          "assets/images/$icon.png",
          width: 25,
          height: 25,
          color: iconColor,
        ),
      ),
    );
  }
}
