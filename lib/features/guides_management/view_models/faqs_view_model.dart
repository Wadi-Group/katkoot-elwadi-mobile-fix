import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';

class FaqsViewModel extends StateNotifier<BaseState<List<Faq>?>>
    with BaseViewModel, PaginationUtils {
  Repository _repository;

  FaqsViewModel(this._repository) : super(BaseState(data: []));

  Future getFaqs(int categoryId,
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

      var result = await _repository.getCategoryFaqs(
          categoryId: categoryId,
          page: page,
          limit: limit,
          searchText: searchText);

      if (result.data != null) {
        page++;
        checkHasNext(result.data ?? []);

        List<Faq>? faqs =
        refresh ? result.data : [...state.data ?? [], ...result.data!];
        state = BaseState(data: faqs, hasNoData: faqs?.isEmpty ?? true);
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

  void setState(List<Faq>? faqs) {
    state = BaseState(data: faqs, isLoading: false);
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
