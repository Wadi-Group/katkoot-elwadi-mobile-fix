import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:riverpod/riverpod.dart';

class CityViewModel extends StateNotifier<BaseState<List<City>?>>
    with BaseViewModel {
  Repository _repository;

  CityViewModel(this._repository) : super(BaseState(data: []));

  Future getListOfCities() async {
    state = BaseState(data: [], isLoading: true);

    var result = await _repository.getCities();
    List<City>? Cities;
    if (result.data != null) {
      Cities = result.data!;
      state = BaseState(
          data: Cities, isLoading: false, hasNoData: Cities.isEmpty);
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


  selectCity(City city){

  }
}
