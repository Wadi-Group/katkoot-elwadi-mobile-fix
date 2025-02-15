import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/models/redirection_data.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/user.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/view_models/auth_view_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/di/injection_container.dart' as di;

class VerifyPhoneScreen extends StatefulWidget with BaseViewModel {
  static const routeName = "./VerifyPhoneScreen";
  String? phoneNumber;
  String? countryCode;
  String? verId;
  MaterialPageRoute? nextRoute;
  bool isFromRegisterScreen;
  User? currentUser;
  bool isEdit;
  UserData? updatedUser;

  VerifyPhoneScreen(
      {Key? key,
      this.phoneNumber,
      this.countryCode,
      this.isEdit = false,
      this.verId,
      this.nextRoute,
      this.updatedUser,
      this.isFromRegisterScreen = false,
      this.currentUser})
      : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen>
    with SingleTickerProviderStateMixin, CodeAutoFill, BaseViewModel {
  String? appSignature;
  String? otpCode;

  @override
  void initState() {
    super.initState();

    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    _durationAnimation =
        Tween(begin: Duration(seconds: countDownTime), end: Duration.zero)
            .animate(_animationController);
    _durationAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          resendVerifyCodeState = true;
        });
      }
    });
    _animationController.forward();
  }

  late final authViewProvider =
      StateNotifierProvider<AuthViewModel, BaseState<List<UserFormsErrors>>>(
          (ref) {
    return AuthViewModel(ref.read(di.repositoryProvider), nextRoute: widget.nextRoute);
  });

  late AnimationController _animationController;
  late Animation _durationAnimation;
  final TextEditingController _controller = TextEditingController(text: '');
  var userModelViewProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showDrawer: false, hasbackButton: false),
      body: GestureDetector(
        child: Stack(
          children: [
            Consumer(builder: (_, ref, __) {
              userModelViewProvider = ref.watch(authViewProvider);
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsetsDirectional.only(top: 2, bottom: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        CustomText(
                          title: 'Verify your phone number'.tr(),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          title:
                              'Please enter the code sent to you via sms'.tr(),
                          fontSize: 17,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: PinCodeTextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                selectedFillColor: AppColors.Tea_green,
                                inactiveFillColor: AppColors.Tea_green,
                                inactiveColor: AppColors.Tea_green,
                                activeColor: AppColors.Tea_green,
                                selectedColor: AppColors.Tea_green,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(9),
                                fieldHeight: 45,
                                fieldWidth: 45,
                                activeFillColor: AppColors.Olive_Drab,
                              ),
                              enableActiveFill: true,
                              length: 6,
                              autoFocus: false,
                              animationType: AnimationType.fade,
                              animationDuration: Duration(milliseconds: 300),
                              onChanged: (value) {
                                if (value.length == 6) {
                                  if (AppConstants
                                          .navigatorKey.currentContext?.locale
                                          .toString() ==
                                      "ar") {
                                    ProviderScope.containerOf(context,
                                        listen: false)
                                        .read(authViewProvider.notifier)
                                        .loginSMS(
                                            context,
                                            Validator.replaceFarsiNumber(value),
                                            widget.verId!,
                                            isFromRegisterScreen:
                                                widget.isFromRegisterScreen,
                                            isEdit: widget.isEdit,
                                            updatedUser: widget.updatedUser,
                                            countryCode: widget.countryCode,
                                            registeredUser: widget.currentUser);
                                  } else {
                                    ProviderScope.containerOf(context,
                                        listen: false)
                                        .read(authViewProvider.notifier)
                                        .loginSMS(context, value, widget.verId!,
                                            isFromRegisterScreen:
                                                widget.isFromRegisterScreen,
                                            isEdit: widget.isEdit,
                                            updatedUser: widget.updatedUser,
                                            countryCode: widget.countryCode,
                                            registeredUser: widget.currentUser);
                                  }
                                }
                              },
                              appContext: context,
                              // cursorColor: Colors.black
                            )),
                        getCountDownTimer(),
                        InkWell(
                          onTap: () {
                            if (resendVerifyCodeState) {
                              resendVerifyCodeState = false;
                              setState(() {});
                              ProviderScope.containerOf(context,
                                  listen: false).read(authViewProvider.notifier)
                                  .validatePhoneFeilds(
                                      context: context,
                                      phone: "${widget.phoneNumber!}",
                                      countryCode: widget.countryCode!,
                                      isFromVerifyScreen: true,
                                      isedit: widget.isEdit,
                                      isFromRegisterScreen:
                                          widget.isFromRegisterScreen);
                            }
                          },
                          child: CustomText(
                            title: 'Resend code'.tr(),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            textColor: resendVerifyCodeState
                                ? AppColors.Olive_Drab
                                : AppColors.Dim_gray,
                            underline: true,
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // buildButtons(),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Consumer(
              builder: (_, watch, __) {
                return ScreenHandler(
                  screenProvider: authViewProvider,
                );
              },
            ),
          ],
        ),
        onTap: () {
          hideKeyboard();
        },
      ),
    );
  }

  TextEditingController phoneController = TextEditingController();

  bool resendVerifyCodeState = false;
  int countDownTime = 60;

  Widget getCountDownTimer() {
    return AnimatedBuilder(
        // duration: Duration(seconds: countDownTime),
        animation: _animationController,
        // tween:         Tween(begin: Duration(seconds: countDownTime), end: Duration.zero),
        // onEnd: () {
        //   setState(() {
        //     resendVerifyCodeState = true;
        //   });
        // },
        builder: (BuildContext context, Widget? child) {
          // Duration value,
          print(
              "_durationAnimation.value.inSeconds ${_durationAnimation.value.inSeconds}");
          final minutes = _durationAnimation.value.inMinutes;
          final seconds = _durationAnimation.value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "( $minutes:$seconds )",
                textAlign: TextAlign.center,
              ));
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    _animationController.clearListeners();
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
    cancel();
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
    setState(() {
      otpCode = code!;
      _controller.text = otpCode!;
    });
  }
}
