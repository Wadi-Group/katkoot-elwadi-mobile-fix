import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/entities/one_signal.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/where_to_find_us_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/messages_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/read_message_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/send_message_success_data.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_data.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_parameters.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/user_management/models/phone_exist.dart';
import 'package:katkoot_elwady/features/user_management/models/unseen_notification_count_data.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../features/tools_management/models/cb_report_generator/cycle.dart';
import 'local/shared_preferences_service.dart';
import 'remote/api_services.dart';

class Repository {
  final ApiService _apiService;
  final SharedPreferencesService _sharedPreferencesService;

  Repository(this._apiService, this._sharedPreferencesService);

  Future<BaseApiResult<List<Category>?>> getCategories(int parent) async {
    return await _apiService.getCategories(parent);
  }

  Future<String?> getFirstTimeDate() async {
    var dateAsString =
        await _sharedPreferencesService.get<String>("first_date");
    return dateAsString as String?;
  }

  Future saveFirebaseToken(String firebaseToken) async {
    await _sharedPreferencesService.save<String>("fb_token", firebaseToken);
  }

  Future<String?> getFirebaseToken() async {
    var fbToken = await _sharedPreferencesService.get<String>("fb_token");
    return fbToken as String?;
  }

  Future<BaseApiResult<List<Video>?>> getCategoryVideos(
      {required int categoryId,
      int? page,
      int? limit,
      String? searchText}) async {
    return await _apiService.getCategoryVideos(
        categoryId, page ?? 1, limit ?? 10, searchText);
  }

  Future<BaseApiResult<List<Category>?>> getCategorizedVideos() async {
    return await _apiService.getCategorizedVideos();
  }

  Future<BaseApiResult<List<City>?>> getSuppliersCities() async {
    return await _apiService.getSuppliersCities();
  }

  Future<BaseApiResult<WhereToFindUsData?>> getSuppliersData(
      {int? cityId,
      int? categoryId,
      double? lat,
      double? long,
      int? page,
      int? limit,
      String? searchText}) async {
    return await _apiService.getSuppliers(
        cityId, categoryId, lat, long, page ?? 1, limit ?? 10, searchText);
  }

  Future<BaseApiResult<List<Topic>?>> getCategoryTopics(
      {required int categoryId, int? page, int? limit}) async {
    return await _apiService.getCategoryTopics(
        categoryId, page ?? 1, limit ?? 10);
  }

  Future<BaseApiResult<List<Guide>?>> getGuides(
      {int? page, int? limit, String? searchtext}) async {
    return await _apiService.getGuides(page ?? 1, limit ?? 10, searchtext);
  }

  Future<BaseApiResult<List<Faq>?>> getCategoryFaqs(
      {required int categoryId,
      int? page,
      int? limit,
      String? searchText}) async {
    return await _apiService.getCategoryFaqs(
        categoryId, page ?? 1, limit ?? 10, searchText);
  }

  Future<BaseApiResult<List<Tool>?>> getCategoryTools(int categoryId,
      {String? searchText}) async {
    return await _apiService.getCategoryTools(categoryId,
        searchText: searchText);
  }

  Future<BaseApiResult<Tool?>> getToolDetails(int toolId) async {
    return await _apiService.getToolDetails(toolId);
  }

  Future<BaseApiResult<UserData?>> getUserProfile() async {
    return await _apiService.getUserProfile();
  }

  Future<void> setOnBoardingComplete() async {
    await _sharedPreferencesService.setOnBoardingComplete();
  }

  Future<bool> isOnBoardingComplete() async =>
      await _sharedPreferencesService.isOnBoardingComplete();

  saveUnseenNotificationCount(int unseenNotificationCount) async =>
      await _sharedPreferencesService
          .saveUnseenNotificationCount(unseenNotificationCount);

  Future<int> unseenNotificationCount() async =>
      await _sharedPreferencesService.unseenNotificationCount();

  Future<BaseApiResult<UnseenNotificationCountData?>>
      remoteUnseenNotificationCount(
              {String? deviceId, String? installedAt}) async =>
          await _apiService.getUnseenNotificationCount(deviceId, installedAt);

  Future<String> installedAtTime() async =>
      await _sharedPreferencesService.installedAtTime();

  Future<BaseApiResult<UserData?>> loginByFirebase({authData}) async {
    return await _apiService.loginByFirebase(authData: authData);
  }

  Future<BaseApiResult<PhoneExistence>> checkExistingPhone({phone}) async {
    return await _apiService.checkExistingPhone(phone: phone);
  }

  Future<BaseApiResult<List<City>?>> getCities() async {
    return await _apiService.getCities();
  }

  saveUserData(UserData? data) {
    _sharedPreferencesService.saveUserData(data);
  }

  UserData? getUserData() {
    return _sharedPreferencesService.getUserData();
  }

  saveParentFlockManagementParameters(ParentFlockManagementParameters? data) {
    _sharedPreferencesService.saveParentFlockManagementParameters(data);
  }

  ParentFlockManagementParameters? getParentFlockManagementParameters() {
    return _sharedPreferencesService.getParentFlockManagementParameters();
  }

  Future<BaseApiResult<SendMessageSuccessData>> postMessage(
      {String? message, int? id}) async {
    return await _apiService.postMessage(message: message, id: id);
  }

  Future<BaseApiResult> putPushToken(
      {required String token, required String action}) async {
    return await _apiService.putPushToken(token: token, action: action);
  }

  Future<BaseApiResult<ReadMessageData?>> putMessageSeen(
      {required int id, String? deviceId, String? installedAt}) async {
    return await _apiService.putMessageSeen(
        id: id, deviceId: deviceId, installedAt: installedAt);
  }

  Future<BaseApiResult<UserData?>> putUserProfile({
    required String fbToken,
    required String name,
    required int cityId,
    required List<int> categoryId,
    required String birthDate,
    String? state,
    String? flockSize,
    String? phone,
    String? numberOfBirds,
    String? numberOfFarms,
    String? numberOfHouses,
  }) async {
    return await _apiService.putUserProfile(
      fbToken: fbToken,
      name: name,
      cityId: cityId,
      categoryId: categoryId,
      birthDate: birthDate,
      state: state,
      flockSize: flockSize,
      numberOfBirds: numberOfBirds,
      numberOfFarms: numberOfFarms,
      numberOfHouses: numberOfHouses,
    );
  }

  Future<BaseApiResult<MessagesData?>> getMessages(
      {required bool hasToken,
      String? deviceId,
      String? installedAt,
      int? page,
      int? limit}) async {
    return await _apiService.getMessages(page ?? 1, limit ?? 10,
        hasToken: hasToken, deviceId: deviceId, installedAt: installedAt);
  }

  Future<BaseApiResult<ContactUsData?>> getContactUsData() async {
    return await _apiService.getContactUsData();
  }

  Future<BaseApiResult<SearchModel?>> getSearchResult(String searchText) async {
    return await _apiService.getSearchResult(searchText);
  }

  Future<BaseApiResult<WeekData?>> getCycleWeekData(
      String? cycleId, String? weekNumber) async {
    return await _apiService.getCycleWeekData(cycleId, weekNumber);
  }

  Future<OSDeviceState?> getOnesignalDeviceState() async {
    return await OneSignal.shared.getDeviceState();
  }

  Future<Map<String, dynamic>> sendOnesignalTags(
      {required dynamic status,
      required dynamic cityId,
      required dynamic categoryId,
      required dynamic birthDate}) async {
    List<int>? catIds = categoryId.cast<int>();
    Map<String, dynamic> tags = {
      OneSignalTags.STATUS: status,
      OneSignalTags.CITY_ID: cityId,
      OneSignalTags.BIRTH_DATE: birthDate
    };
    Map<String, dynamic> catTags = {};
    catIds!.forEach((element) {
      catTags["cat_$element"] = 1.toString();
    });

    tags.addAll(catTags);
    return await _sendTags(tags);
  }

  Future<Map<String, dynamic>> sendOnesignalStatusTag(
      {required String status}) async {
    return await _sendOnesignalTag(OneSignalTags.STATUS, status);
  }

  Future<Map<String, dynamic>> deleteOnesignalTags(List<String> tags) async {
    return OneSignal.shared.deleteTags(tags);
  }

  Future<Map<String, dynamic>> _sendOnesignalTag(
      String tag, dynamic value) async {
    return OneSignal.shared.sendTag(tag, value);
  }

  Future<Map<String, dynamic>> _sendTags(Map<String, dynamic> tagS) async {
    return OneSignal.shared.sendTags(tagS);
  }

  Future<BaseApiResult> createCycle(CreateCycle cycle) async {
    return _apiService.postCycle(cycle);
  }

  Future<BaseApiResult<List<Cycle>?>> getCycles(int? page, int? limit) async {
    return await _apiService.getCycles(page ?? 1, limit ?? 10);
  }

  Future<BaseApiResult<List<CbCycle>?>> getCbCycles(
      int? page, int? limit) async {
    return await _apiService.getCbCycles(page ?? 1, limit ?? 10);
  }

  Future<BaseApiResult> addRearingWeekData({
    required String? cycleId,
    required String? weekNumber,
    required String? femaleFeed,
    required String? maleFeed,
    required String? femaleWeight,
    required String? maleWeight,
    required String? femaleMort,
    required String? maleMort,
    required String? sexErrors,
    required String? culls,
    required String? lightingProgram,
    required String? totalEggs,
    required String? hatchedEggs,
    required String? eggWeight,
  }) async {
    return await _apiService.addRearingWeekData(
      cycleId: cycleId,
      weekNumber: weekNumber,
      femaleFeed: femaleFeed,
      maleFeed: maleFeed,
      femaleWeight: femaleWeight,
      maleWeight: maleWeight,
      femaleMort: femaleMort,
      maleMort: maleMort,
      sexErrors: sexErrors,
      culls: culls,
      lightingProgram: lightingProgram,
      totalEggs: totalEggs,
      hatchedEggs: hatchedEggs,
      eggWeight: eggWeight,
    );
  }

  Future<BaseApiResult> deleteCycleWeek(int cycleId, int duration) async {
    return _apiService.deleteCycleWeek(cycleId, duration);
  }

  Future<BaseApiResult<Cycle?>> getCycleDetails(String? cycleId) async {
    return _apiService.getCycleDetails(cycleId);
  }

  Future<BaseApiResult<CbCycle?>> getCbCycleDetails(String? cycleId) async {
    return _apiService.getCbCycleDetails(cycleId);
  }

  Future<BaseApiResult> deleteCycle(int cycleId) async {
    return _apiService.deleteCycle(cycleId);
  }

  Future<BaseApiResult> deleteCbCycle(int cycleId) async {
    return _apiService.deleteCbCycle(cycleId);
  }

  Future<BaseApiResult> deleteUser(userId) async {
    return _apiService.deleteUser(userId);
  }

  // get home data
  Future<Map<String, dynamic>?> getHomeData() async {
    return await _apiService.getHomeData();
  }
}
