import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/utils/check_internet_connection.dart';

class CategoriesViewModel extends StateNotifier<BaseState<List<Category>?>>
    with BaseViewModel {
  Repository _repository;

  CategoriesViewModel(this._repository) : super(BaseState(data: []));

  Future getListOfCategories({required bool mainCategories}) async {
    state = BaseState(data: [], isLoading: true);

    bool isOnline = await checkInternetConnection();
    var box = await Hive.openBox<Category>('categoriesBox'); // Open Hive box

    if (isOnline) {
      // Fetch categories from API
      var result = await _repository.getCategories(mainCategories
          ? AppConstants.MAIN_CATEGORIES
          : AppConstants.ALL_CATEGORIES);

      if (result.data != null) {
        List<Category> categories = result.data!;

        // Clear old data & Save list items individually in Hive
        await box.clear();
        await box.addAll(categories);

        state = BaseState(
            data: categories, isLoading: false, hasNoData: categories.isEmpty);
      } else {
        _handleError(result);
      }
    } else {
      // Load all categories stored in Hive when offline
      List<Category> cachedData = box.values.toList();

      if (cachedData.isNotEmpty) {
        state = BaseState(
          data: cachedData,
          isLoading: false,
          hasNoData: cachedData.isEmpty,
        );
      } else {
        state = BaseState(data: [], isLoading: false, hasNoConnection: true);
      }
    }
  }

  void _handleError(result) {
    if (result.errorType == ErrorType.NO_NETWORK_ERROR && state.data!.isEmpty) {
      state = BaseState(data: [], isLoading: false, hasNoConnection: true);
    } else {
      state = BaseState(data: [], isLoading: false);
      handleError(
          errorType: result.errorType,
          errorMessage: result.errorMessage,
          keyValueErrors: result.keyValueErrors);
    }
  }

  void setState(List<Category>? categories) {
    state = BaseState(data: categories, isLoading: false);
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }

  // get home data
  Future<Map<String, dynamic>> getHomeData() async {
    // Set loading state before API call
    state = BaseState(data: state.data, isLoading: true);

    try {
      var result = await _repository.getHomeData();

      // After fetching data, update state with new data and stop loading
      state = BaseState(data: state.data, isLoading: false);

      return result ?? {};
    } catch (error) {
      // If an error occurs, stop loading and handle the error
      state = BaseState(data: state.data, isLoading: false);
      handleError(
          errorType: ErrorType.GENERAL_ERROR, errorMessage: error.toString());

      return {};
    }
  }

  // get in app message data
  Future<Map<String, dynamic>> getInAppMessageData() async {
    // Set loading state before API call
    state = BaseState(data: state.data, isLoading: true);

    try {
      var result = await _repository.getInAppMessageData();

      // After fetching data, update state with new data and stop loading
      state = BaseState(data: state.data, isLoading: false);

      return result ?? {};
    } catch (error) {
      // If an error occurs, stop loading and handle the error
      state = BaseState(data: state.data, isLoading: false);
      handleError(
          errorType: ErrorType.GENERAL_ERROR, errorMessage: error.toString());

      return {};
    }
  }
}
