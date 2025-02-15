import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/defaults.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/tools_management/models/equation.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations.dart';
import 'package:katkoot_elwady/features/guides_management/models/faq.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/guides_management/models/url.dart';
import 'package:katkoot_elwady/features/tools_management/models/fcr.dart';
import 'package:katkoot_elwady/features/tools_management/models/slider_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/guides_management/models/topic.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class ItemsResponse<V> {
  List<V>? items;

  ItemsResponse({this.items});

  factory ItemsResponse.fromJson(Map<String, dynamic> json) {
    List<V> itemsList = [];
    if (json['items'] != null) {
      var list = json['items'] as List?;
      if (list != null) {
        itemsList =
            list.map<V?>((i) => _dataFromJson<V>(i)).whereType<V>().toList();
      }
    }

    return ItemsResponse(
      items: json["items"] == null ? null : itemsList,
    );
  }

  factory ItemsResponse.fromDynamic(List<dynamic> items) {
    List<V> itemsList = [];

    var list = items as List?;
    if (list != null) {
      itemsList =
          list.map<V?>((i) => _dataFromJson<V>(i)).whereType<V>().toList();
    }
    return ItemsResponse(items: itemsList);
  }

  static V? _dataFromJson<V>(dynamic json) {
    if (V == Category) {
      return Category.fromJson(json) as V;
    } else if (V == Video) {
      return Video.fromJson(json) as V;
    } else if (V == Url) {
      return Url.fromJson(json) as V;
    } else if (V == Topic) {
      return Topic.fromJson(json) as V;
    } else if (V == Guide) {
      return Guide.fromJson(json) as V;
    } else if (V == Faq) {
      return Faq.fromJson(json) as V;
    } else if (V == Tool) {
      return Tool.fromJson(json) as V;
    } else if (V == Message) {
      return Message.fromJson(json) as V;
    } else if (V == Equation) {
      return Equation.fromJson(json) as V;
    } else if (V == Fcr) {
      return Fcr.fromJson(json) as V;
    } else if (V == Equations) {
      return Equations.fromJson(json) as V;
    } else if (V == Defaults) {
      return Defaults.fromJson(json) as V;
    } else if (V == Supplier) {
      return Supplier.fromJson(json) as V;
    }
    if (V == City) {
      return City.fromJson(json) as V;
    } if (V == SliderData) {
      return SliderData.fromJson(json) as V;
    } if (V == Cycle) {
      return Cycle.fromJson(json) as V;
    } else {
      return null;
    }
  }
}
