import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_address.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/lat_lng.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchViewModel extends StateNotifier<BaseState<SearchModel?>>
    with BaseViewModel {
  Repository _repository;

  SearchViewModel(this._repository) : super(BaseState(data: SearchModel()));

  Future getsearchResult(String searchText) async {
    state = BaseState(data: SearchModel());

    if (searchText.trim().isNotEmpty) {
      state = BaseState(data: SearchModel(), isLoading: true);

      var result = await _repository.getSearchResult(searchText);

      SearchModel? modelData;
      if (result.data != null) {
        modelData = result.data;
        state = BaseState(
            data: modelData,
            hasNoData: ((modelData?.faqsData?.faqs == null || (modelData?.faqsData?.faqs ?? []).isEmpty) &&
                (modelData?.videosData?.videos == null || (modelData?.videosData?.videos ?? []).isEmpty) &&
                (modelData?.guidesData?.guides == null || (modelData?.guidesData?.guides ?? []).isEmpty) &&
                (modelData?.suppliersData?.suppliers == null || (modelData?.suppliersData?.suppliers ?? []).isEmpty) &&
                (modelData?.toolsData?.tools == null || (modelData?.toolsData?.tools ?? []).isEmpty)));
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: modelData, hasNoConnection: true);
        } else {
          state = BaseState(data: modelData);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    }
  }
}
