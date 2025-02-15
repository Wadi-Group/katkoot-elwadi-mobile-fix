import 'package:katkoot_elwady/features/menu_management/models/contact_us_address.dart';
import 'package:katkoot_elwady/features/menu_management/models/phone_contact.dart';
import 'package:katkoot_elwady/features/menu_management/models/social_media_link.dart';

class ContactUsData {
  List<PhoneContact?>? phoneNumbers;
  List<SocialMediaLink?>? socialMediaLinks;
  ContactUsAddress? address;

  ContactUsData({this.phoneNumbers, this.socialMediaLinks, this.address});

  ContactUsData.fromJson(Map<String, dynamic> json) {
    if (json["phones"] != null) {
      phoneNumbers = List<PhoneContact>.from(
          json["phones"].map((model) => PhoneContact.fromJson(model)));
    }

    if (json["social_media_links"] != null) {
      socialMediaLinks = List<SocialMediaLink>.from(json["social_media_links"]
          .map((model) => SocialMediaLink.fromJson(model)));
    }
    if (json["address"] != null) {
      address = ContactUsAddress.fromJson(json["address"]);
    }
  }
}

enum ContactMode { PHONE, SOCIAL_LINK, ADDRESS }
