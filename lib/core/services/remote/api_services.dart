import 'package:katkoot_elwady/core/api/api_methods.dart';
import 'package:katkoot_elwady/core/api/api_urls.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
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
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/user_management/models/phone_exist.dart';
import 'package:katkoot_elwady/features/user_management/models/unseen_notification_count_data.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';

import '../../../features/tools_management/entities/cb_cycle_data.dart';
import '../../../features/tools_management/models/cb_report_generator/cycle.dart';
import '../../../features/tools_management/models/cb_report_generator/week_data.dart';

class ApiService {
  Future<BaseApiResult<List<Category>?>> getCategories(int parent) async {
    // return await ApiMethods<Category>().getList(ApiUrls.CATEGORIES+ "$parent");
    return await ApiMethods<Category>()
        .getList(ApiUrls.CATEGORIES, params: {"is_main": parent.toString()});
  }

  Future<BaseApiResult<List<Video>?>> getCategoryVideos(
      int categoryId, int page, int limit, String? searchText) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    searchText != null
        ? params['search_text'] = searchText
        : params['category'] = categoryId.toString();
    return await ApiMethods<Video>()
        .postWithListResponse(ApiUrls.VIDEOS, cache: true, data: params);
  }

  Future<BaseApiResult<List<Category>?>> getCategorizedVideos() async {
    return await ApiMethods<Category>().getList(ApiUrls.CATEGORIZED_VIDEOS);
  }

  Future<BaseApiResult<List<City>?>> getSuppliersCities() async {
    return await ApiMethods<City>().getList(ApiUrls.SUPPLIERS_CITIES);
  }

  Future<BaseApiResult<WhereToFindUsData?>> getSuppliers(
      int? cityId,
      int? categoryId,
      double? lat,
      double? long,
      int page,
      int limit,
      String? searchText) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    if (cityId != null) params["city_id"] = cityId.toString();
    if (categoryId != null && categoryId != 0)
      params["category_id"] = categoryId.toString();
    if (lat != null && cityId == null) params["lat"] = lat.toString();
    if (long != null && cityId == null) params["long"] = long.toString();

    if (searchText != null) {
      return await ApiMethods<WhereToFindUsData>().post(ApiUrls.SUPPLIERS,
          data: {'search_text': searchText, 'force_find_city': '0'});
    }

    return await ApiMethods<WhereToFindUsData>()
        .post(ApiUrls.SUPPLIERS, data: params);
  }

  Future<BaseApiResult<List<Topic>?>> getCategoryTopics(
      int categoryId, int page, int limit) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    return await ApiMethods<Topic>().getList(
        ApiUrls.CATEGORIES_TOPICS + "?parent=$categoryId",
        cache: true,
        params: params);
  }

  Future<BaseApiResult<List<Guide>?>> getGuides(
      int page, int limit, String? searchText) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    if (searchText != null) {
      params['search_text'] = searchText;
    }
    return await ApiMethods<Guide>()
        .postWithListResponse(ApiUrls.GUIDES, cache: true, data: params);
  }

  Future<BaseApiResult<List<Faq>?>> getCategoryFaqs(
      int categoryId, int page, int limit, String? searchText) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    searchText != null
        ? params['search_text'] = searchText
        : params['category'] = categoryId.toString();

    return await ApiMethods<Faq>()
        .postWithListResponse(ApiUrls.FAQS, cache: true, data: params);
  }

  Future<BaseApiResult<List<Tool>?>> getCategoryTools(int categoryId,
      {String? searchText}) async {
    Map<String, String> params = {};
    searchText != null ? params['search_text'] = searchText : null;
    return await ApiMethods<Tool>().postWithListResponse(
        searchText != null
            ? ApiUrls.TOOLS
            : ApiUrls.CATEGORIES_TOOLS + "$categoryId",
        data: params,
        cache: true);
  }

  Future<BaseApiResult<Tool>> getToolDetails(int toolId) async {
    return await ApiMethods<Tool>()
        .get(ApiUrls.TOOLS + "/$toolId", cache: true);
  }

  Future<BaseApiResult<SearchModel?>> getSearchResult(String searchText) async {
    var params = {'search_text': searchText};
    return await ApiMethods<SearchModel>()
        .post(ApiUrls.SEARCH, hasLanguage: true, hasToken: false, data: params);
  }

  Future<BaseApiResult<UserData?>> getUserProfile() async {
    return await ApiMethods<UserData>()
        .get(ApiUrls.EDIT_PROFILE, hasToken: true, hasLanguage: false);
  }

  Future<BaseApiResult> deleteUser(int userId) async {
    return await ApiMethods()
        .delete(ApiUrls.DELETE_USER + "?id=$userId", hasLanguage: false);
  }

  Future<BaseApiResult<ContactUsData?>> getContactUsData() async {
    return await ApiMethods<ContactUsData>().get(ApiUrls.CONTACT_US_DATA);
  }

  Future<BaseApiResult<WeekData?>> getCycleWeekData(
      String? cycleId, String? weekNumber) async {
    return await ApiMethods<WeekData>().get(ApiUrls.CYCLE_DATA, params: {
      "cycle_id": cycleId.toString(),
      "duration": weekNumber.toString()
    });
  }

  Future<BaseApiResult<UnseenNotificationCountData?>>
      getUnseenNotificationCount(String? deviceId, String? installedAt) async {
    var params;
    bool hasToken;
    if (deviceId != null) {
      hasToken = false;
      params = {'device_id': deviceId};
      if (installedAt != null) {
        params['after_date'] = installedAt;
      }
    } else {
      hasToken = true;
    }
    return await ApiMethods<UnseenNotificationCountData>().post(
      ApiUrls.UNSEEN_NOTIFICATION_COUNT,
      hasToken: hasToken,
      data: params,
    );
  }

  Future<BaseApiResult<Cycle?>> getCycleDetails(String? cycleId) async {
    return await ApiMethods<Cycle>().get(ApiUrls.CYCLES + "/$cycleId");
  }

  Future<BaseApiResult<UserData?>> loginByFirebase({authData}) async {
    return await ApiMethods<UserData>().post(ApiUrls.LOGIN_BY_FIREBASE,
        data: authData, hasToken: false, hasLanguage: false);
  }

  Future<BaseApiResult<PhoneExistence>> checkExistingPhone({phone}) async {
    return await ApiMethods<PhoneExistence>().post(ApiUrls.PHONE_CHECK,
        data: {"phone": phone}, hasToken: false, hasLanguage: true);
  }

  Future<BaseApiResult<List<City>?>> getCities() async {
    return await ApiMethods<City>().getList(ApiUrls.CITIES);
  }

  Future<BaseApiResult<SendMessageSuccessData>> postMessage(
      {String? message, int? id}) async {
    return await ApiMethods<SendMessageSuccessData>().post(ApiUrls.POST_MESSAGE,
        data: {"message": message, "category_id": id});
  }

  Future<BaseApiResult> putPushToken(
      {required String token, required String action}) async {
    return await ApiMethods().put(ApiUrls.SEND_PUSH_NOTIFICATION,
        data: {"notification_token": token, "action": action},
        hasLanguage: false);
  }

  Future<BaseApiResult<ReadMessageData?>> putMessageSeen(
      {required int id, String? deviceId, String? installedAt}) async {
    var params;
    bool hasToken;
    if (deviceId != null) {
      hasToken = false;
      params = {'device_id': deviceId};
      if (installedAt != null) {
        params['after_date'] = installedAt;
      }
    } else {
      hasToken = true;
    }
    return await ApiMethods<ReadMessageData>().put(
        ApiUrls.MESSAGE_SEEN + "/$id" + "/seen",
        data: params,
        hasLanguage: true,
        hasToken: hasToken);
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
    return await ApiMethods<UserData>().put(ApiUrls.EDIT_PROFILE,
        data: phone != null
            ? {
                "token": fbToken,
                "name": name,
                "city_id": cityId,
                "categories": categoryId,
                "phone": phone,
                "birth_date": birthDate,
                "village": state!.isNotEmpty ? state.toString() : null,
                "flock_size":
                    flockSize!.isNotEmpty ? flockSize.toString() : null,
                "number_of_birds ":
                    numberOfBirds!.isEmpty ? null : numberOfBirds,
                "number_of_farms ":
                    numberOfFarms!.isEmpty ? null : numberOfFarms,
                "number_of_houses ":
                    numberOfHouses!.isEmpty ? null : numberOfHouses
              }
            : {
                "token": fbToken,
                "name": name,
                "city_id": cityId,
                "birth_date": birthDate,
                "categories": categoryId,
                "village": state!.isNotEmpty ? state.toString() : null,
                "flock_size":
                    flockSize!.isNotEmpty ? flockSize.toString() : null,
                "number_of_birds ":
                    numberOfBirds!.isEmpty ? null : numberOfBirds,
                "number_of_farms ":
                    numberOfFarms!.isEmpty ? null : numberOfFarms,
                "number_of_houses ":
                    numberOfHouses!.isEmpty ? null : numberOfHouses
              },
        hasToken: true,
        hasLanguage: true);
  }

  Future<BaseApiResult<MessagesData?>> getMessages(int page, int limit,
      {required bool hasToken, String? deviceId, String? installedAt}) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    if (deviceId != null) {
      params['device_id'] = deviceId;
    }
    if (installedAt != null) {
      params['after_date'] = installedAt;
    }
    print(params.toString());
    return await ApiMethods<MessagesData>()
        .post(ApiUrls.MESSAGES, hasToken: hasToken, data: params);
  }

  Future<BaseApiResult> postCycle(CreateCycle cycle) async {
    return await ApiMethods().post(ApiUrls.CYCLE, data: {
      "farm_name": cycle.farmName,
      // "flock_number": cycle.location,
      "location": cycle.location,
      "arrival_date": cycle.arrivalDate,
      "male": cycle.male,
      "female": cycle.female,
      "tool_id": cycle.toolId
    });
  }

  Future<BaseApiResult<List<Cycle>?>> getCycles(int page, int limit) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    return await ApiMethods<Cycle>().getList(ApiUrls.CYCLES, params: params);
    return await ApiMethods<Cycle>()
        .getList(ApiUrls.CYCLES + "?tool_id=8", params: params);
  }

  Future<BaseApiResult<List<CbCycle>>> getCbCycles(int page, int limit) async {
    var params = {"page": page.toString(), "limit": limit.toString()};
    return await ApiMethods<CbCycle>().getList(ApiUrls.CYCLES, params: params);
    // return await ApiMethods<CbCycle>().getList(ApiUrls.CYCLES + "?tool_id=9" , params: params);
  }

  Future<BaseApiResult> deleteCycle(int cycleId) async {
    return await ApiMethods().delete(ApiUrls.CYCLE + "?id=$cycleId");
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
    var params = {
      "cycle_id": cycleId,
      "duration": weekNumber,
      "female_feed": femaleFeed,
      "male_feed": maleFeed,
      "female_weight": femaleWeight,
      "male_weight": maleWeight,
      "female_mort": femaleMort,
      "male_mort": maleMort,
    };

    if (sexErrors != null) params["sex_errors"] = sexErrors;
    if (culls != null) params["culls"] = culls;
    if (lightingProgram != null) params["lighting_prog"] = lightingProgram;
    if (totalEggs != null) params["total_egg"] = totalEggs;
    if (hatchedEggs != null) params["hatched_egg"] = hatchedEggs;
    if (eggWeight != null) params["egg_weight"] = eggWeight;

    return await ApiMethods().post(ApiUrls.CYCLE_DATA, data: params);
  }

  Future<BaseApiResult> deleteCycleWeek(int cycleId, int weekNumber) async {
    return await ApiMethods().delete(
        ApiUrls.CYCLE_DATA + "?cycle_id=$cycleId" + "&duration=$weekNumber");
  }

  ///////////////////////////////CBCycle///////////////

  Future<BaseApiResult<CbWeekData?>> getCbCycleWeekData(
      String? cycleId, String? weekNumber) async {
    return await ApiMethods<CbWeekData>().get(ApiUrls.CYCLE_DATA, params: {
      "cycle_id": cycleId.toString(),
      "duration": weekNumber.toString()
    });
  }

  Future<BaseApiResult<CbCycle?>> getCbCycleDetails(String? cycleId) async {
    return await ApiMethods<CbCycle>().get(ApiUrls.CYCLES + "/$cycleId");
  }

  Future<BaseApiResult> postCbCycle(CreateCbCycle cycle) async {
    return await ApiMethods().post(ApiUrls.CYCLE, data: {
      "farm_name": cycle.farmName,
      // "flock_number": cycle.location,
      "location": cycle.location,
      "arrival_date": cycle.arrivalDate,
      "male": cycle.male,
      "female": cycle.female,
      "tool_id": cycle.toolId
    });
  }

  Future<BaseApiResult> deleteCbCycle(int cycleId) async {
    return await ApiMethods().delete(ApiUrls.CYCLE + "?id=$cycleId");
  }

  Future<BaseApiResult> addCbRearingWeekData({
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
    var params = {
      "cycle_id": cycleId,
      "duration": weekNumber,
      "female_feed": femaleFeed,
      "male_feed": maleFeed,
      "female_weight": femaleWeight,
      "male_weight": maleWeight,
      "female_mort": femaleMort,
      "male_mort": maleMort,
    };

    if (sexErrors != null) params["sex_errors"] = sexErrors;
    if (culls != null) params["culls"] = culls;
    if (lightingProgram != null) params["lighting_prog"] = lightingProgram;
    if (totalEggs != null) params["total_egg"] = totalEggs;
    if (hatchedEggs != null) params["hatched_egg"] = hatchedEggs;
    if (eggWeight != null) params["egg_weight"] = eggWeight;

    return await ApiMethods().post(ApiUrls.CYCLE_DATA, data: params);
  }

  Future<BaseApiResult> deleteCbCycleWeek(int cycleId, int weekNumber) async {
    return await ApiMethods().delete(
        ApiUrls.CYCLE_DATA + "?cycle_id=$cycleId" + "&duration=$weekNumber");
  }

  // get home data
  Future<Map<String, dynamic>?> getHomeData() async {
    return await ApiMethods<Map<String, dynamic>>()
        .getRaw(ApiUrls.HOME, hasToken: false);
  }

// get in app message data
  Future<Map<String, dynamic>?> getInAppMessageData() async {
    return await ApiMethods<Map<String, dynamic>?>().getRaw(
      ApiUrls.IN_APP_MESSAGE,
      hasToken: false,
    );
  }
}
