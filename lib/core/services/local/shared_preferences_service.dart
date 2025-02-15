import 'dart:convert';

import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_parameters.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final sharedPreferencesServiceProvider =
//     Provider<SharedPreferencesService>((ref) => throw UnimplementedError());

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static const onBoardingCompleteKey = 'onboardingComplete';
  static const firstTime = "first_date";
  static const USER = "USER";
  static const PARENT_FLOCK_MANAGEMENT_PARAMETERS =
      "PARENT_FLOCK_MANAGEMENT_PARAMETERS";
  static const UNSEEN_NOTIFICATION_COUNT = "unseen_notification_count";

  Future<void> setOnBoardingComplete() async {
    await save(firstTime, DateTime.now().toString());
    await save(onBoardingCompleteKey, true);
    // await sharedPreferences.setBool(onBoardingCompleteKey, true);
  }

  Future<bool> isOnBoardingComplete() async =>
      await get<bool>(onBoardingCompleteKey) ?? false;

  Future save<T>(String key, T value) async {
    if (T == String) {
      await sharedPreferences.setString(key, value as String);
    } else if (T == int) {
      await sharedPreferences.setInt(key, value as int);
    } else if (T == bool) {
      await sharedPreferences.setBool(key, value as bool);
    }
  }

  Future get<T>(String key) async {
    if (T == String) {
      return sharedPreferences.getString(key);
    } else if (T == int) {
      return sharedPreferences.getInt(key);
    } else if (T == bool) {
      return sharedPreferences.getBool(key);
    }
  }

  saveUserData(UserData? data) {
    _saveData(USER, data);
  }

  saveParentFlockManagementParameters(ParentFlockManagementParameters? data) {
    _saveData(PARENT_FLOCK_MANAGEMENT_PARAMETERS, data);
  }

  saveUnseenNotificationCount(int unseenNotificationCount) {
    save<int>(UNSEEN_NOTIFICATION_COUNT, unseenNotificationCount);
  }

  UserData? getUserData() {
    var data = _getData(USER);
    return data != null
        ? UserData.fromJson(data as Map<String, dynamic>)
        : null;
  }

  ParentFlockManagementParameters? getParentFlockManagementParameters() {
    var data = _getData(PARENT_FLOCK_MANAGEMENT_PARAMETERS);
    return data != null
        ? ParentFlockManagementParameters.fromJson(data as Map<String, dynamic>)
        : null;
  }

  Future<int> unseenNotificationCount() async =>
      await get<int>(UNSEEN_NOTIFICATION_COUNT) ?? 0;

  Future<String> installedAtTime() async => await get<String>(firstTime) ?? '';

  _saveData(String key, dynamic data) {
    String json = jsonEncode(data);
    print("json ");
    print(json);
    sharedPreferences.setString(key, json);
  }

  dynamic _getData<T>(String key) {
    var savedData = sharedPreferences.getString(key);
    if (savedData != null) {
      var data = jsonDecode(savedData);
      return data;
    }
    return null;
  }
}
