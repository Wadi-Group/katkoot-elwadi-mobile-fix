import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/one_signal.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:katkoot_elwady/features/user_management/models/user.dart'
    as userModel;
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:katkoot_elwady/features/user_management/screens/verify_phone_screen.dart';

import '../../../core/di/injection_container.dart' as di;

class AuthViewModel extends StateNotifier<BaseState<List<UserFormsErrors>>>
    with Validator, BaseViewModel, NavigationDrawerMixin {
  Repository _repository;
  final MaterialPageRoute? nextRoute;

  AuthViewModel(this._repository, {this.nextRoute})
      : super(BaseState(data: <UserFormsErrors>[]));

  bool isRegister = false;
  userModel.User? user;

  updateCurrentUser({
    required UserData updatedUser,
    required String fbToken,
    bool changePhone = false,
    required String countryCode,
  }) async {
    var result = await _repository.putUserProfile(
      fbToken: fbToken,
      name: updatedUser.user!.name!,
      cityId: updatedUser.user!.cityId,
      birthDate: updatedUser.user!.birthDate!,
      phone: changePhone ? updatedUser.user!.phone : null,
      categoryId: updatedUser.user!.categoryId!,
      state: updatedUser.user!.state,
      flockSize: updatedUser.user!.flockSize,
      numberOfBirds: updatedUser.user!.numberOfBirds,
      numberOfFarms: updatedUser.user!.numberOfFarms,
      numberOfHouses: updatedUser.user!.numberOfHouses,
    );
    if (result.data != null) {
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.userViewModelProvider.notifier)
          .setLocalUserData(
              UserData(token: updatedUser.token, user: result.data!.user));

      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .setLocalUnseenNotificationCount(
              result.data?.notificationNotSeenCount ?? 0);

      var deviceState = await _repository.getOnesignalDeviceState();
      if (deviceState != null) {
        _repository.putPushToken(
            token: deviceState.userId ?? "", action: "add");
      }
      if (result.data!.user != null) {
        DateTime dateMod =
            DateTime.parse(result.data!.user?.birthDate.toString() ?? "");
        var formattedDate = DateFormat('MM-dd').format(dateMod);
        _repository.sendOnesignalTags(
            status: OneSignalValue.REGISTERED,
            cityId: result.data!.user!.cityId.toString(),
            birthDate: formattedDate.toString(),
            categoryId: result.data!.user!.categoryId);
      }

      state = BaseState(
        data: [],
        isLoading: false,
      );
      // navigateToScreen(HomeScreen.routeName, removeTop: true);
      showToastMessage(result.data!.messgae ?? "");
      if (changePhone) {
        if (AppConstants.navigatorKey.currentContext != null) {
          // navigateToScreen(EditProfileScreen.routeName);
          // AppConstants.navigatorKey.currentContext!
          //     .read(di.contentProvider)
          //     .state = DrawerItemType.editProfile.index;
          navigateToScreen(MainBottomAppBar.routeName, removeTop: true);
        }
      }
      // resetDrawerSelection();
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state.hasNoConnection = true;
        state = BaseState(data: [], isLoading: false, hasNoConnection: true);
        handleError(
          errorType: result.errorType,
        );
      } else if (result.errorType == ErrorType.UNAUTHORIZED_ERROR) {
        state = BaseState(data: [], isLoading: false);
        debugPrint(result.keyValueErrors.toString());
        showToastMessage(result.errorMessage ??
            result.keyValueErrors!["phone"][0].toString());
      } else {
        state = BaseState(data: [], isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  validateFeilds(
      {required BuildContext context,
      fullName,
      phone,
      String? date,
      required String countryCode,
      int? cityId,
      List<int>? categoryId,
      userState,
      flockSize,
      String? numberOfBirds,
      String? numberOfFarms,
      String? numberOfHouses,
      bool? isEdit}) async {
    List<UserFormsErrors> validationErrors = Validator.validateFields(
        fullName: fullName,
        phone: phone,
        city: cityId,
        category: categoryId,
        birthDate: date,
        state: userState,
        flockSize: flockSize,
        numberOfBirds: numberOfBirds,
        numberOfFarms: numberOfFarms,
        numberOfHouses: numberOfHouses);

    if (validationErrors.isEmpty) {
      if (isEdit != null && isEdit == true) {
        state = BaseState(
          data: [],
          isLoading: true,
        );
        var user = ProviderScope.containerOf(
                AppConstants.navigatorKey.currentContext!,
                listen: false)
            .read(di.userViewModelProvider.notifier)
            .getLocalUserData();
        var fbToken = await _repository.getFirebaseToken();
        if (fbToken != null) {
          if (user!.user != null) {
            UserData updatingUser = UserData(
                token: user.token,
                user: userModel.User(
                    name: fullName,
                    phone: phone,
                    cityId: cityId!,
                    birthDate: date,
                    categoryId: categoryId!,
                    state: userState,
                    flockSize: flockSize));

            if (phone == user.user!.phone) {
              print("new fbtoken $fbToken");
              updateCurrentUser(
                updatedUser: updatingUser,
                fbToken: fbToken,
                countryCode: countryCode,
              );
            } else {
              checkExistingPhone(
                  context: context,
                  countryCode: countryCode,
                  phone: "$phone",
                  isEdit: true,
                  updatedUser: updatingUser);
            }
          }
        }
      } else {
        state = BaseState(data: [], isLoading: false);
        isRegister = true;
        user = userModel.User(
            phone: phone,
            name: fullName,
            cityId: cityId,
            birthDate: date,
            categoryId: categoryId,
            state: userState,
            flockSize: flockSize);
        // sendSmsCode("$phone", countryCode);
        checkExistingPhone(
            context: context, phone: "$phone", countryCode: countryCode);
      }
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
    }
  }

  validatePhoneFeilds({
    required BuildContext context,
    phone,
    required String countryCode,
    bool isFromVerifyScreen = false,
    bool isedit = false,
    bool isFromRegisterScreen = false,
  }) {
    List<UserFormsErrors> validationErrors =
        Validator.validateFields(phone: phone);
    if (validationErrors.isEmpty) {
      state = BaseState(data: [], isLoading: false);
      isRegister = isFromRegisterScreen;
      if (isFromVerifyScreen) {
        sendSmsCode(context, "$phone", countryCode,
            isEdit: isedit, isFromVerifyScreen: isFromVerifyScreen);
      } else {
        // sendSmsCode("$phone", countryCode,
        //     isFromVerifyScreen: isFromVerifyScreen);
        checkExistingPhone(
            context: context,
            phone: "$phone",
            countryCode: countryCode,
            isEdit: isedit,
            isFromVerifyScreen: isFromVerifyScreen);
      }
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
    }
  }

  Future checkExistingPhone(
      {required BuildContext context,
      phone,
      required String countryCode,
      bool isEdit = false,
      UserData? updatedUser,
      bool isFromVerifyScreen = false}) async {
    state = BaseState(data: [], isLoading: true);
    var result = await _repository.checkExistingPhone(phone: "$phone");
    if (result.data != null) {
      //exist isRegister
      //false  false  at login    print error
      //true  false   at login
      //false  true   at register
      //true  true    at register  print error
      state = BaseState(data: [], isLoading: false);
      if (isEdit) {
        if (result.data!.exist!) {
          handleError(
              errorType: result.errorType,
              errorMessage: result.data!.message!,
              keyValueErrors: result.keyValueErrors);
        } else {
          sendSmsCode(context, "$phone", countryCode,
              isFromVerifyScreen: false,
              isEdit: true,
              updatedUser: updatedUser);
        }
      } else if ((result.data!.exist! && isRegister) ||
          (!result.data!.exist! && !isRegister)) {
        handleError(
            errorType: result.errorType,
            errorMessage: result.data!.message!,
            keyValueErrors: result.keyValueErrors);
      } else if ((result.data!.exist! && !isRegister) ||
          (!result.data!.exist! && isRegister)) {
        sendSmsCode(context, "$phone", countryCode,
            isFromVerifyScreen: isFromVerifyScreen);
      }
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        // state.hasNoConnection = true;
        // state = BaseState(data: [], isLoading: false, hasNoConnection: true);
        state = BaseState(data: [], isLoading: false);
        handleError(
          errorType: result.errorType,
        );
      } else {
        state = BaseState(data: [], isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage:
                result.errorMessage ?? result.keyValueErrors!["message"],
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  sendSmsCode(BuildContext context, String phoneNumber, String countryCode,
      {bool isFromVerifyScreen = false,
      bool isEdit = false,
      UserData? updatedUser}) async {
    state = BaseState(data: [], isLoading: true);

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) async {
      print('verified' + verId);
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      print('PhoneVerificationCompleted');
      state = BaseState(data: [], isLoading: false);
    };
    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      state = BaseState(data: [], isLoading: false);
      String errorMessage = "invalid-verification-code".tr();
      try {
        if (exception.code == "invalid-verification-code") {
          errorMessage = "invalid-verification-code".tr();
        }
        if (exception.code == "invalid-phone-number") {
          errorMessage = "invalid_phone".tr();
        } else if (exception.code == "network-request-failed") {
          errorMessage = "str_no_connection".tr();
        } else {
          errorMessage = exception.message!;
        }
      } catch (error) {
        print(error);
      }
      handleError(
        errorMessage: errorMessage,
      );
    };
    //
    print("verifyPhoneNumber ---> ${phoneNumber.toString()}");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$countryCode$phoneNumber",
      codeAutoRetrievalTimeout: autoRetrieve,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
      codeSent: (String? verificationId, int? forceResendingToken) async {
        print("PhoneCodeSent : " + verificationId!);
        state = BaseState(data: [], isLoading: false);
        if (isFromVerifyScreen) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyPhoneScreen(
                verId: verificationId,
                nextRoute: nextRoute,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                isFromRegisterScreen: isRegister,
                currentUser: user,
              ),
            ),
          );
        } else if (isEdit) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyPhoneScreen(
                verId: verificationId,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                isFromRegisterScreen: isRegister,
                isEdit: true,
                updatedUser: updatedUser,
                currentUser: user,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyPhoneScreen(
                verId: verificationId,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                nextRoute: nextRoute,
                isFromRegisterScreen: isRegister,
                currentUser: user,
              ),
            ),
          );
        }
      },
    );
  }

  loginSMS(BuildContext context, smsCode, verId,
      {bool isFromRegisterScreen = false,
      bool isEdit = false,
      UserData? updatedUser,
      String? countryCode,
      userModel.User? registeredUser}) async {
    isRegister = isFromRegisterScreen;
    user = registeredUser;
    if (smsCode == null) {
      handleError(
        errorMessage: "enter code".tr(),
      );
    } else {
      try {
        state = BaseState(data: [], isLoading: true);

        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verId,
          smsCode: smsCode,
        );
        final fireBaseUser =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        state = BaseState(data: [], isLoading: false);

        if (fireBaseUser != null) {
          String? idToken = await fireBaseUser.getIdToken();
          _repository.saveFirebaseToken(idToken!);
          if (isEdit) {
            if (updatedUser != null && countryCode != null) {
              updateCurrentUser(
                  updatedUser: updatedUser,
                  fbToken: idToken,
                  changePhone: true,
                  countryCode: countryCode);
            }
          } else {
            loginByFirebase(context: context, firebaseToken: idToken);
          }
        } else {
          handleError(
            errorMessage: "invalidSMSCode".tr(),
          );
        }
      } catch (e) {
        FirebaseAuthException error;
        String errorMessage = "invalid-verification-code".tr();
        try {
          error = e as FirebaseAuthException;
          if (error.code == "invalid-verification-code") {
            //"network-request-failed"
            errorMessage = "invalid-verification-code".tr();
          } else if (error.code == "network-request-failed") {
            errorMessage = "str_no_connection".tr();
          } else {
            errorMessage = error.message!;
          }
        } catch (error) {
          print(error);
        }
        handleError(
          errorMessage: errorMessage,
        );
      }
    }
    state = BaseState(data: [], isLoading: false);
  }

  Future loginByFirebase({required BuildContext context, firebaseToken}) async {
    state = BaseState(data: [], isLoading: true);

    print("is register $isRegister");

    Map<String, dynamic> authData = {};
    if (isRegister) {
      authData = {
        "token": firebaseToken,
        "name": user!.name,
        "city_id": user!.cityId.toString(),
        "categories": user!.categoryId!,
        "birth_date": user!.birthDate.toString(),
        "village": user!.state!.isNotEmpty ? user!.state.toString() : null,
        "flock_size":
            user!.flockSize!.isNotEmpty ? user!.flockSize.toString() : null,
      };

      String? formattedDate;
      print(user?.birthDate.toString());
      if (DateTime.tryParse(user?.birthDate.toString() ?? "") != null) {
        DateTime dateMod = DateTime.parse(user!.birthDate.toString());
        formattedDate = DateFormat('MM-dd').format(dateMod);
      }

      _repository.sendOnesignalTags(
          status: OneSignalValue.REGISTERED,
          cityId: user!.cityId.toString(),
          birthDate: formattedDate.toString(),
          categoryId: user!.categoryId);
    } else {
      authData = {
        "token": firebaseToken,
      };
      print("fbToken $firebaseToken");

      _repository.sendOnesignalStatusTag(status: OneSignalValue.REGISTERED);
    }

    var result = await _repository.loginByFirebase(authData: authData);
    if (result.data != null) {
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.userViewModelProvider.notifier)
          .setLocalUserData(result.data);

      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .setLocalUnseenNotificationCount(
              result.data?.notificationNotSeenCount ?? 0);

      var deviceState = await _repository.getOnesignalDeviceState();
      if (deviceState != null) {
        _repository.putPushToken(
            token: deviceState.userId ?? "", action: "add");
      }

      if (result.data!.user != null) {
        String? formattedDate;

        print(user?.birthDate.toString());
        if (DateTime.tryParse(result.data!.user?.birthDate.toString() ?? "") !=
            null) {
          DateTime dateMod =
              DateTime.parse(result.data!.user!.birthDate.toString());
          formattedDate = DateFormat('MM-dd').format(dateMod);
        }

        _repository.sendOnesignalTags(
            status: OneSignalValue.REGISTERED,
            cityId: result.data!.user!.cityId.toString(),
            birthDate: formattedDate != null ? formattedDate.toString() : "",
            categoryId: result.data!.user!.categoryId);
      }

      state = BaseState(
        data: [],
        isLoading: false,
      );
      //resetDrawerSelection();
      if (nextRoute != null) {
        int count = 0;
        Navigator.pushReplacement(context, nextRoute!);
        //navigateToScreen(nextRoute!.redirectionRouteName,arguments: redirectionData!.arguments,replace: true);
      } else {
        navigateToScreen(MainBottomAppBar.routeName, removeTop: true);
      }
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state.hasNoConnection = true;
        state = BaseState(data: [], isLoading: false, hasNoConnection: true);
        handleError(
          errorType: result.errorType,
        );
      } else if (result.errorType == ErrorType.UNAUTHORIZED_ERROR) {
        state = BaseState(data: [], isLoading: false);
        debugPrint(result.keyValueErrors.toString());
        showToastMessage(result.errorMessage ??
            result.keyValueErrors!["token"][0].toString());
      } else {
        state = BaseState(data: [], isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
