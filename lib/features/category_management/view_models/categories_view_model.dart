import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:riverpod/riverpod.dart';

class CategoriesViewModel extends StateNotifier<BaseState<List<Category>?>>
    with BaseViewModel {
  Repository _repository;

  CategoriesViewModel(this._repository) : super(BaseState(data: []));

  Future getListOfCategories({required bool mainCategories}) async {
    state = BaseState(data: [], isLoading: true);

    var result = await _repository.getCategories(mainCategories
        ? AppConstants.MAIN_CATEGORIES
        : AppConstants.ALL_CATEGORIES);
    List<Category>? categories;
    if (result.data != null) {
      categories = result.data!;
      state = BaseState(
          data: categories, isLoading: false, hasNoData: categories.isEmpty);
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
          state.data!.isEmpty) {
        state.hasNoConnection = state.data!.isEmpty;
        state = BaseState(data: [], isLoading: false, hasNoConnection: true);
      } else {
        state = BaseState(data: [], isLoading: false);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
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
}
