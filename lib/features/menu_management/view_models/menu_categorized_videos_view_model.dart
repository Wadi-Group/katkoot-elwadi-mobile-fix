import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class MenuCategorizedVideosViewModel
    extends StateNotifier<BaseState<List<Category>?>> with BaseViewModel {
  Repository _repository;

  MenuCategorizedVideosViewModel(this._repository) : super(BaseState(data: []));

  Future getVideos({String? searchText}) async {
    state = BaseState(data: [], isLoading: true);

    var result = await _repository.getCategorizedVideos();
    List<Category>? categories;
    if (result.data != null) {
      categories = result.data;
      state =
          BaseState(data: categories, hasNoData: categories?.isEmpty ?? true);
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state = BaseState(data: [], hasNoConnection: true);
      } else {
        state = BaseState(data: []);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }
}
