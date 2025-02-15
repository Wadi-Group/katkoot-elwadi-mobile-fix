
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';

class FaqsDataModel {
  List<Faq>? faqs;
  bool? hasMore;

  FaqsDataModel(
      {this.faqs,this.hasMore});

  FaqsDataModel.fromJson(Map<String, dynamic> json) {
    Iterable faqsIterable = json['items'] ?? [];

    faqs =
    List<Faq>.from(faqsIterable.map((model) => Faq.fromJson(model)));
    hasMore = json['has_more'];
  }
}
