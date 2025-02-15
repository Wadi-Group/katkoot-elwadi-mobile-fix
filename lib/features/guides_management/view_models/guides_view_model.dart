import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';

class GuidesViewModel extends StateNotifier<BaseState<List<Guide>?>>
    with BaseViewModel, PaginationUtils {
  Repository _repository;

  GuidesViewModel(this._repository) : super(BaseState(data: []));

  Future getGuides(
      {bool refresh = false,
      bool showLoading = true,
      String? searchText}) async {

    if(searchText == null || (searchText.trim().isNotEmpty)) {
      if (checkPerformRequest(refresh: refresh)) return;

      isPerformingRequest = true;
      if (refresh) {
        reset();
      }

      state = BaseState(data: state.data, isLoading: showLoading);

      var result = await _repository.getGuides(
          page: page, limit: limit, searchtext: searchText);

      if (result.data != null) {
        page++;
        checkHasNext(result.data ?? []);

        List<Guide>? guides =
        refresh ? result.data : [...state.data ?? [], ...result.data!];
        state = BaseState(data: guides, hasNoData: guides?.isEmpty ?? true);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
            (state.data?.isEmpty ?? true)) {
          state = BaseState(data: [], hasNoConnection: true);
        } else {
          state = BaseState(data: state.data);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
      isPerformingRequest = false;
    }
  }

  void setState(List<Guide>? guides) {
    state = BaseState(data: guides, isLoading: false);
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
