import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_address.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/lat_lng.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsViewModel extends StateNotifier<BaseState<ContactUsData?>>
    with BaseViewModel {
  Repository _repository;

  ContactUsViewModel(this._repository)
      : super(BaseState(data: ContactUsData()));

  Future getContactUsData() async {
    state = BaseState(data: ContactUsData(), isLoading: true);

    var result = await _repository.getContactUsData();
    ContactUsData? contactUsData;
    if (result.data != null) {
      contactUsData = result.data;
      state = BaseState(
          data: contactUsData,
          hasNoData: ((contactUsData?.phoneNumbers?.isEmpty ?? true) &&
              (contactUsData?.socialMediaLinks?.isEmpty ?? true)));
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
        state = BaseState(data: contactUsData, hasNoConnection: true);
      } else {
        state = BaseState(data: contactUsData);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  Future handleContactRedirection(
      {required ContactMode mode,
      String? phoneNumber,
      String? url,
      ContactUsAddress? address}) async {
    state = BaseState(data: state.data, isLoading: true);

    print(url);
    print(phoneNumber);
    if (mode == ContactMode.PHONE) {
      print(phoneNumber);

      if (phoneNumber != null) {
        launch("tel:$phoneNumber").then((value) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            state = BaseState(data: state.data);
          });
        });
      }
    }
    if (mode == ContactMode.ADDRESS) {
      print(phoneNumber);

      if (address != null) {
        final String googleMapsUrl =
            "comgooglemaps://?center=${address.latlng!.latitude},${address.latlng!.longitude}";
        final String appleMapsUrl =
            "https://maps.apple.com/?q=${address.latlng!.latitude},${address.latlng!.longitude}";

        if (await canLaunch(googleMapsUrl)) {
          await launch(googleMapsUrl);
        } else if (await canLaunch(appleMapsUrl)) {
          await launch(appleMapsUrl, forceSafariVC: false);
        } else {
          throw "Couldn't launch URL";
        }
        Future.delayed(const Duration(milliseconds: 1500), () {
          state = BaseState(data: state.data);
        });
      }
    } else if (mode == ContactMode.SOCIAL_LINK) {
      print(url);

      if (await canLaunch(url ?? "")) {
        launch(url!).then((value) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            state = BaseState(data: state.data);
          });
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1500), () {
          state = BaseState(data: state.data);
        });
        showToastMessage("Could not launch $url");
        throw "Could not launch $url";
      }
    }
  }
}
