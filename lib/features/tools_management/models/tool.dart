import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/entities/slider_item.dart';
import 'package:katkoot_elwady/features/tools_management/models/equation.dart';
import 'package:katkoot_elwady/features/tools_management/models/slider_data.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool_data.dart';

part 'tool.g.dart'; // Required for Hive code generation

@HiveType(typeId: 0) // Unique type ID for Hive
class Tool extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? duration;

  @HiveField(4)
  String? durationRange;

  @HiveField(5)
  String? parentCategoryTitle;

  @HiveField(6)
  Equation? equation;

  @HiveField(7)
  Category? category;

  @HiveField(8)
  List<ToolData>? toolData;

  @HiveField(9)
  SliderData? sliderData;

  @HiveField(10)
  Tool? relatedTool;

  Tool({
    this.id,
    this.title,
    this.type,
    this.parentCategoryTitle,
    this.category,
    this.duration,
    this.durationRange,
    this.equation,
    this.toolData,
    this.sliderData,
    this.relatedTool,
  });

  Tool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "";
    type = json['type'];
    parentCategoryTitle = json["parent_category_title"];
    category =
        json["category"] != null ? Category.fromJson(json["category"]) : null;
    duration = json['duration'];
    durationRange = json['duration_range'];
    equation = json['equation'] != null
        ? Equation.fromJson(Map<String, dynamic>.from(json["equation"]))
        : null;

    if (json['tool_data'] != null) {
      toolData = [];
      json['tool_data'].forEach((v) {
        toolData!.add(ToolData.fromJson(v));
      });
    }
    sliderData = json['slider_data'] != null
        ? SliderData.fromJson(Map<String, dynamic>.from(json["slider_data"]))
        : null;

    relatedTool = json['related_tool'] != null
        ? Tool.fromJson(Map<String, dynamic>.from(json["related_tool"]))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'duration': duration,
      'duration_range': durationRange,
      'equation': equation?.toJson(),
      'slider_data': sliderData?.toJson(),
      'related_tool': relatedTool?.toJson(),
      'tool_data': toolData?.map((v) => v.toJson()).toList(),
    };
  }

  // -------------------------
  // FUNCTIONS FROM ORIGINAL CLASS
  // -------------------------

  /// Get number of sections
  int get numberOfSections => (toolData != null && toolData!.isNotEmpty)
      ? toolData![0].sections?.length ?? 0
      : 0;

  /// Get the list of slider intervals
  List<SliderInterval> getSliderIntervals() {
    List<SliderInterval> sliderIntervals = [];
    if (toolData != null) {
      for (var i = 0; i < toolData!.length; i++) {
        sliderIntervals.add(SliderInterval(
          start: toolData![i].durationFrom!,
          end: toolData![i].durationTo!,
        ));
      }
    }
    return sliderIntervals;
  }

  /// Get the selected ToolData based on slider position
  ToolData getSelectedToolData(int sliderPosition) {
    if (toolData != null) {
      for (var i = 0; i < toolData!.length; i++) {
        if (toolData![i].durationFrom! <= sliderPosition &&
            sliderPosition <= toolData![i].durationTo!) {
          return toolData![i];
        }
      }
    }
    return ToolData();
  }

  /// Get the minimum value of the slider
  double getSliderMin() {
    return double.parse(durationRange!.split("-").first);
  }

  /// Get the maximum value of the slider
  double getSliderMax() {
    return double.parse(durationRange!.split("-").last);
  }

  /// Get current section index based on slider position
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

  /// Get slider icons for each interval
  List<SliderIcon> getSliderIcons() {
    List<SliderIcon> list = [];
    final intervals = getSliderIntervals();
    for (var i = 0; i < intervals.length; i++) {
      list.add(SliderIcon(
        sliderInterval: intervals[i],
        icon: createSliderIcon("assets/images/5_days_g.png"),
      ));
    }
    return list;
  }

  /// Create a slider icon widget
  Widget createSliderIcon(String iconPath) {
    return ImageIcon(
      AssetImage(iconPath),
      size: 50,
      color: AppColors.RATING_YELLOW,
    );
  }
}
