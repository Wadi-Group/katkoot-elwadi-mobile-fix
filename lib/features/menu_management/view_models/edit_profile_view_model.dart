import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/models/edit_profile_data.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

import '../../../core/di/injection_container.dart' as di;

class EditProfileViewModel extends StateNotifier<BaseState<EditProdileData?>>
    with BaseViewModel {
  Repository _repository;

  EditProfileViewModel(this._repository)
      : super(BaseState(data: EditProdileData()));

  Future getCategoriesAndCities(
    BuildContext context,
    TextEditingController phoneControoler,
    TextEditingController nameController,
    TextEditingController dateController,
    TextEditingController stateController,
    TextEditingController flockSizeController,
    idController,
  ) async {
    print("call start");
    BaseState(data: EditProdileData(), isLoading: true);

    await Future.wait([
      _repository.getCategories(AppConstants.ALL_CATEGORIES),
      _repository.getCities()
    ]).then((value) {
      print("call done");
      if (value.length == 2) {
        if (value[0].data != null || value[1].data != null) {
          state = BaseState(
              data: EditProdileData(
                  cities: value[1].data as List<City>?,
                  categories: value[0].data as List<Category>?),
              isLoading: false);

          getCurrentUserData(
              context,
              phoneControoler,
              nameController,
              dateController,
              stateController,
              flockSizeController,
              idController);
        } else if (value[0].errorType == ErrorType.NO_NETWORK_ERROR ||
            value[1].errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: EditProdileData(), hasNoConnection: true);
        } else {
          state = BaseState(data: EditProdileData());
          handleError(
              errorType: value[0].errorType ?? value[1].errorType,
              errorMessage: value[0].errorMessage ?? value[1].errorMessage,
              keyValueErrors:
                  value[0].keyValueErrors ?? value[1].keyValueErrors);
        }
      }
    });
  }

  getCurrentUserData(
    BuildContext context,
    TextEditingController phoneControoler,
    TextEditingController nameController,
    TextEditingController dateController,
    TextEditingController stateController,
    TextEditingController flockSizeController,
    TextEditingController idController,
  ) async {
    var currentUser = ProviderScope.containerOf(context, listen: false)
        .read(di.userViewModelProvider.notifier)
        .getLocalUserData();

    List<Category>? selectedCategory;

    City? selectedCity;
    String? phoneNumber;
    String? userName;
    String? birthDate;
    String? userState;
    String? flockSize;

    if (currentUser!.user != null) {
      if (currentUser.user!.name != null) {
        print(currentUser.user!.name!);
        userName = currentUser.user!.name!;
        nameController.text = currentUser.user!.name!;
      }
      if (currentUser.user!.state != null) {
        print(currentUser.user!.state);

        userState = currentUser.user!.state!;
        stateController.text = currentUser.user!.state!;
      }
      if (currentUser.user!.flockSize != null) {
        print("flock");

        print(currentUser.user!.flockSize);

        flockSize = currentUser.user!.flockSize!;
        flockSizeController.text = currentUser.user!.flockSize!.toString();
      }
      if (currentUser.user!.birthDate != null) {
        birthDate = currentUser.user!.birthDate!;
        dateController.text = currentUser.user!.birthDate!;
      }
      if (currentUser.user!.phone != null) {
        phoneNumber = currentUser.user!.phone!;
        phoneControoler.text = currentUser.user!.phone!;
      }
      if (currentUser.user!.cityId != null && state.data!.cities != null) {
        print(currentUser.user!.cityId);
        var index = state.data!.cities!.indexWhere((element) {
          return currentUser.user!.cityId!.toString() == element.id.toString();
        });
        print("index");
        print(index);
        if (index != -1) {
          selectedCity = state.data!.cities![index];
        }
      }
      if (currentUser.user!.categoryId != null) {
        print("categories id");
        print(currentUser.user!.categoryId);
        // var index = state.data!.categories!.indexWhere((element) =>
        //     currentUser.user!.categoryId!.toString() == element.id.toString());
        // if (index != -1) {
        //   selectedCategory = state.data!.categories![index];
        // }
        if (state.data!.categories != null) {
          selectedCategory = state.data!.categories!
              .where((element) =>
                  currentUser.user!.categoryId!.contains(element.id))
              .toList();
        }
      }
      state = BaseState(
          data: EditProdileData(
        phoneNumber: phoneNumber,
        userName: userName,
        categories: state.data!.categories,
        cities: state.data!.cities,
        selectedCategory: selectedCategory,
        birthDate: state.data!.birthDate,
        selectedCity: selectedCity,
        state: userState,
        flockSize: flockSize,
      ));

      state = BaseState(data: state.data, isLoading: true);

      var result = await _repository.getUserProfile();
      if (result.data != null) {
        var remoteUserData = result.data!;
        if (remoteUserData.user != null) {
          if (remoteUserData.user!.name != null) {
            print(remoteUserData.user!.name!);
            userName = remoteUserData.user!.name!;
            nameController.text = remoteUserData.user!.name!;
          }
          if (remoteUserData.user!.state != null) {
            print(remoteUserData.user!.name!);

            userState = remoteUserData.user!.state!;
            stateController.text = remoteUserData.user!.state!;
          }
          if (remoteUserData.user!.flockSize != null) {
            print("flock");

            print(remoteUserData.user!.name!);

            flockSize = remoteUserData.user!.flockSize!;
            flockSizeController.text =
                remoteUserData.user!.flockSize!.toString();
          }
          if (remoteUserData.user!.birthDate != null) {
            birthDate = remoteUserData.user!.birthDate!;
            dateController.text = remoteUserData.user!.birthDate!;
          }
          if (remoteUserData.user!.phone != null) {
            phoneNumber = remoteUserData.user!.phone!;
            phoneControoler.text = remoteUserData.user!.phone!;
          }
          if (remoteUserData.user!.cityId != null &&
              state.data!.cities != null) {
            print(remoteUserData.user!.cityId);
            var index = state.data!.cities!.indexWhere((element) {
              return remoteUserData.user!.cityId!.toString() ==
                  element.id.toString();
            });
            print("index");
            print(index);
            if (index != -1) {
              selectedCity = state.data!.cities![index];
            }
          }
          if (remoteUserData.user!.categoryId != null) {
            print("categories id");
            print(remoteUserData.user!.categoryId);

            if (state.data!.categories != null) {
              selectedCategory = state.data!.categories!
                  .where((element) =>
                      remoteUserData.user!.categoryId!.contains(element.id))
                  .toList();
            }

            if (remoteUserData.user?.id != null) {
              print(remoteUserData.user!.id!);

              var userId = remoteUserData.user!.id!;
              // stateController.text = remoteUserData.user!.state!;
            }
          }
          state = BaseState(
              data: EditProdileData(
            phoneNumber: phoneNumber,
            userName: userName,
            categories: state.data!.categories,
            cities: state.data!.cities,
            selectedCategory: selectedCategory,
            birthDate: state.data!.birthDate,
            selectedCity: selectedCity,
            state: userState,
            flockSize: flockSize,
            userId: currentUser.user?.id,
          ));
        } else {
          if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
            state = BaseState(data: state.data, hasNoConnection: true);
          } else {
            state = BaseState(data: state.data);
            handleError(
                errorType: result.errorType,
                errorMessage: result.errorMessage,
                keyValueErrors: result.keyValueErrors);
          }
        }
      }
    }
  }

  changeCurrentCategory(List<Category> category) {
    state = BaseState(
        data: EditProdileData(
      phoneNumber: state.data?.phoneNumber,
      userName: state.data?.userName,
      selectedCategory: category,
      categories: state.data!.categories,
      cities: state.data!.cities,
      birthDate: state.data!.birthDate,
      state: state.data!.state,
      flockSize: state.data!.flockSize,
      selectedCity: state.data?.selectedCity,
    ));
  }

  changeCurrentCity(City city) {
    print(city.name);
    state = BaseState(
        data: EditProdileData(
            phoneNumber: state.data?.phoneNumber,
            birthDate: state.data!.birthDate,
            userName: state.data?.userName,
            categories: state.data!.categories,
            cities: state.data!.cities,
            state: state.data!.state,
            flockSize: state.data!.flockSize,
            selectedCategory: state.data?.selectedCategory,
            selectedCity: city));
  }
}
