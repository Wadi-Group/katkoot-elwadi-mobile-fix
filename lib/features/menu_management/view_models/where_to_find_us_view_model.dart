import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/location_manager.dart';
import 'package:katkoot_elwady/core/utils/map_utilities.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/entities/where_to_find_us_state.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class WhereToFindUsViewModel
    extends StateNotifier<BaseState<WhereToFindUsState?>>
    with BaseViewModel, PaginationUtils {
  Repository _repository;

  WhereToFindUsViewModel(this._repository)
      : super(BaseState(data: WhereToFindUsState()));

  Future getScreenData() async {
    state = BaseState(data: WhereToFindUsState(), isLoading: true);

    await Future.wait([
      _repository.getSuppliersCities(),
      _repository.getCategories(AppConstants.MAIN_CATEGORIES),
      //_repository.getCities()
    ]).then((value) {
      print("call done");

      int indexWithError = value.indexWhere((element) => element.data == null);
      if (indexWithError == -1) {
        List<City>? suppliersCities = value[0].data as List<City>?;
        List<Category>? categories = [Category(title: "all".tr(), id: 0)];
        categories = [
          ...categories,
          ...(value[1].data as List<Category>? ?? [])
        ];
        //List<City>? cities = value[2].data as List<City>?;
        state = BaseState(
            data: WhereToFindUsState(
                suppliersCities: suppliersCities,
                categories: categories,
                cities: suppliersCities
            ));
        getSuppliers();
      } else {
        BaseApiResult result = value[indexWithError];
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: WhereToFindUsState(), hasNoConnection: true);
        } else {
          state = BaseState(data: WhereToFindUsState());
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    });
  }

  Future<void> getSuppliers(
      {City? city,
      int? categoryId,
      bool? fromPagination,
      bool showLoading = true,
      String? serachText}) async {

    if(serachText == null || (serachText.trim().isNotEmpty)) {
      bool isSameCityId =
      (city != null && city.id == state.data?.selectedCity?.id);

      if ((checkPerformRequest() && (fromPagination ?? false)) ||
          (isSameCityId && !(fromPagination ?? false))) {
        print("stop befor ");
        return;
      }

      if (!(fromPagination ?? false) &&
          city == null &&
          state.data?.selectedCity?.id == null &&
          serachText == null) {
        var location = await LocationManager.getCurrentLocation();
        state.data?.lat = location?.latitude;
        state.data?.long = location?.longitude;
      }
      isPerformingRequest = true;
      state = BaseState(
          data: state.data?.copyWith(hasNoData: false), isLoading: showLoading);

      if (!isSameCityId && !(fromPagination ?? false)) {
        reset();
      }

      print("into get suppliers");

      var result = await _repository.getSuppliersData(
          cityId: city?.id ?? state.data?.selectedCity?.id,
          categoryId: categoryId ?? state.data?.selectedCategoryId,
          lat: state.data?.lat,
          long: state.data?.long,
          page: page,
          searchText: serachText,
          limit: limit);

      if (result.data?.suppliers != null) {
        page++;
        checkHasNext(result.data?.suppliers ?? []);
        state.data?.selectedCity = city ?? result.data?.city;
        if (categoryId != null) state.data?.selectedCategoryId = categoryId;
        if (!isSameCityId && !(fromPagination ?? false)) {
          state.data?.suppliers?.clear();
        }
        List<Supplier>? currList = [
          ...state.data?.suppliers ?? [],
          ...result.data!.suppliers!
        ];
        if (!isSameCityId && !(fromPagination ?? false) &&
            currList.isNotEmpty) {
          _getMapSuppliersMarkers();
        }
        state = BaseState(
          data: state.data
              ?.copyWith(suppliers: currList, hasNoData: currList.isEmpty),
        );
      } else {
        state = BaseState(
          data: state.data,
        );
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
      isPerformingRequest = false;
    }
  }

  _getMapSuppliersMarkers() async {
    Set<Marker> markers = Set();
    final Uint8List selectedCityIcon = await MapUtilities.getBytesFromAsset(
        'assets/images/map_pin.png', Platform.isAndroid ? 150 : 160);
    state.data?.suppliersCities?.forEach((element) {
      markers.add(element.id == state.data?.selectedCity?.id
          ? Marker(
              markerId: MarkerId((element.id ?? 0).toString()),
              position: LatLng(double.parse(element.lat ?? ''),
                  double.parse(element.long ?? '')),
              onTap: () => getSuppliers(city: element),
              icon: BitmapDescriptor.fromBytes(selectedCityIcon))
          : Marker(
              markerId: MarkerId((element.id ?? 0).toString()),
              position: LatLng(double.parse(element.lat ?? ''),
                  double.parse(element.long ?? '')),
              onTap: () => getSuppliers(city: element),
            ));
    });
    state = BaseState(data: state.data?.copyWith(markers: markers));
  }

  resetSelectedCity() {
    state.data?.selectedCity = null;
  }

  Set<Marker> getSelectedCityMarkers() {
    Set<Marker> markers = Set();
    City? selectedCity = state.data?.selectedCity;
    markers.add(Marker(
      markerId: MarkerId((selectedCity?.id ?? 0).toString()),
      position: LatLng(double.parse(selectedCity?.lat ?? ''),
          double.parse(selectedCity?.long ?? '')),
    ));

    return markers;
  }
}
