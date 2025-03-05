import 'package:hive/hive.dart';
import 'tool_section.dart';

part 'tool_data.g.dart'; // This file will be generated

@HiveType(typeId: 19) // Ensure the typeId is unique
class ToolData extends HiveObject {
  @HiveField(0)
  int? durationFrom;

  @HiveField(1)
  int? durationTo;

  @HiveField(2)
  List<ToolSection>? sections;

  ToolData({this.durationFrom, this.durationTo, this.sections});

  ToolData.fromJson(Map<String, dynamic> json) {
    durationFrom = json['duration_from'];
    durationTo = json['duration_to'];

    if (json['data'] != null) {
      sections = [];
      json['data'].forEach((v) {
        sections!.add(ToolSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['duration_from'] = durationFrom;
    data['duration_to'] = durationTo;
    if (sections != null) {
      data['data'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
