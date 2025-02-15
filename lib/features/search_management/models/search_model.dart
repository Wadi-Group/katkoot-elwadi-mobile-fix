import 'dart:convert' as j;

import 'package:katkoot_elwady/features/guides_management/models/faq.dart';
import 'package:katkoot_elwady/features/guides_management/models/guide.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/search_management/models/suppliers_data_model.dart';
import 'package:katkoot_elwady/features/search_management/models/tools_data_model.dart';
import 'package:katkoot_elwady/features/search_management/models/videos_data_model.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';

import 'faqs_data_model.dart';
import 'guides_data_model.dart';

class SearchModel {
  GuidesDataModel? guidesData;
  VideosDataModel? videosData;
  ToolsDataModel? toolsData;
  SuppliersDataModel? suppliersData;
  FaqsDataModel? faqsData;

  SearchModel(
      {this.faqsData,
      this.guidesData,
      this.suppliersData,
      this.toolsData,
      this.videosData});

  SearchModel.fromJson(Map<String, dynamic> json) {
    guidesData = json['Guides'] == null
        ? null
        : GuidesDataModel.fromJson(json['Guides']);
    videosData =
        json['Video'] == null ? null : VideosDataModel.fromJson(json['Video']);
    toolsData =
        json['Tools'] == null ? null : ToolsDataModel.fromJson(json['Tools']);
    suppliersData = json['Suppliers'] == null
        ? null
        : SuppliersDataModel.fromJson(json['Suppliers']);
    faqsData = json['FAQ'] == null ? null : FaqsDataModel.fromJson(json['FAQ']);
  }

  int get numberOfAvailableSections {
    int count = 0;
    if ((guidesData?.guides?.length ?? 0) != 0) count++;
    if ((videosData?.videos?.length ?? 0) != 0) count++;
    if ((toolsData?.tools?.length ?? 0) != 0) count++;
    if ((suppliersData?.suppliers?.length ?? 0) != 0) count++;
    if ((faqsData?.faqs?.length ?? 0) != 0) count++;

    //1 for see all section
    return count == 0 ? 0 : count + 1;
  }

  int get faqIndex {
    var index = 2;
    if ((guidesData?.guides?.length ?? 0) == 0) {
      index--;
    }
    return index;
  }

  int get videosIndex {
    var index = 3;

    if ((guidesData?.guides?.length ?? 0) == 0) {
      index--;
    }
    if ((faqsData?.faqs?.length ?? 0) == 0) {
      return index--;
    }
    return index;
  }

  int get toolsIndex {
    var index = 4;
    if ((guidesData?.guides?.length ?? 0) == 0) {
      return index--;
    }
    if ((faqsData?.faqs?.length ?? 0) == 0) {
      return index--;
    }
    if ((videosData?.videos?.length ?? 0) == 0) {
      return index--;
    }
    return index;
  }

  int get suppliersIndex {
    var index = 5;
    if ((guidesData?.guides?.length ?? 0) == 0) {
      return index--;
    }
    if ((faqsData?.faqs?.length ?? 0) == 0) {
      return index--;
    }
    if ((videosData?.videos?.length ?? 0) == 0) {
      return index--;
    }
    if ((toolsData?.tools?.length ?? 0) == 0) {
      return index--;
    }
    return index;
  }
}
