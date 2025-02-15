import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/tools_management/models/equation.dart';
import 'package:katkoot_elwady/features/tools_management/models/slider_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool_data.dart';

class Tool {
  //TODO: remove this static icon.
  List<String> icons = [
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
    "assets/images/5_days_g.png",
  ];
  int? id;
  String? title;
  String? type;
  String? duration;
  String? durationRange;
  String? parentCategoryTitle;
  Equation? equation;
  Category? category;
  List<ToolData>? toolData;
  SliderData? sliderData;
  int? get numberOfSections => (toolData != null && toolData!.isNotEmpty)
      ? toolData![0].sections?.length
      : 0;
  Tool? relatedTool;

  Tool(
      {this.id,
      this.title,
      this.type,
      this.parentCategoryTitle,
      this.category,
      this.duration,
      this.durationRange,
      this.equation,
      this.toolData,
      this.sliderData,
      this.relatedTool});

  Tool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "";
    type = json['type'];
    parentCategoryTitle = json["parent_category_title"];
    category = json["category"]!= null ? Category.fromJson(json["category"]) : null;
    duration = json['duration'];
    durationRange = json['duration_range'];
    equation = json['equation'] == null
        ? null
        : Equation.fromJson(Map<String, dynamic>.from(json["equation"]));

    if (json['tool_data'] != null) {
      toolData = [];
      json['tool_data'].forEach((v) {
        toolData!.add(ToolData.fromJson(v));
      });
    }
    sliderData = json['slider_data'] == null
        ? null
        : SliderData.fromJson(Map<String, dynamic>.from(json["slider_data"]));
    relatedTool = json['related_tool'] == null
        ? null
        : Tool.fromJson(Map<String, dynamic>.from(json["related_tool"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['duration_range'] = this.durationRange;
    data['equation'] = this.equation!.toJson();
    data['slider_data'] = this.sliderData!.toJson();
    data['related_tool'] = this.relatedTool!.toJson();
    if (this.toolData != null) {
      data['tool_data'] = this.toolData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<SliderInterval> getSliderIntervals() {
    List<SliderInterval> sliderIntervals = [];
    if (toolData != null) {
      for (var i = 0; i < toolData!.length; i++) {
        sliderIntervals.add(SliderInterval(
            start: toolData![i].durationFrom!, end: toolData![i].durationTo!));
      }
    }
    return sliderIntervals;
  }

  ToolData getSelectedToolData(int sliderPosition) {
    ToolData data = ToolData();
    if (toolData != null) {
      for (var i = 0; i < toolData!.length; i++) {
        if (toolData![i].durationFrom! <= sliderPosition &&
            sliderPosition <= toolData![i].durationTo!) {
          return toolData![i];
        }
      }
    }
    return data;
  }

  double getSliderMin() {
    return double.parse(durationRange!.split("-").first);
  }

  double getSliderMax() {
    return double.parse(durationRange!.split("-").last);
  }

  int getCurrentSectionData(int sliderPosition) {
    if (toolData != null) {
      for (var i = 0; i < toolData!.length; i++) {
        if (toolData![i].durationFrom! <= sliderPosition &&
            sliderPosition <= toolData![i].durationTo!) {
          return i;
        }
      }
    }
    return 0;
  }

  List<SliderIcon> getSliderIcons() {
    List<SliderIcon> list = [];
    final intervals = getSliderIntervals();
    for (var i = 0; i < intervals.length; i++) {
      list.add(SliderIcon(
          sliderInterval: intervals[i],
          icon: createSliderIcon((intervals.length > icons.length)
              ? "assets/images/5_days_g.png"
              : icons[i])));
    }
    return list;
  }

  Widget createSliderIcon(String iconPath) {
    return ImageIcon(
      AssetImage(iconPath),
      size: 50,
      color: AppColors.RATING_YELLOW,
    );
  }
}
