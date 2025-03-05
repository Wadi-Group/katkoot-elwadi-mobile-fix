import 'package:hive/hive.dart';
import 'column.dart';

part 'tool_section.g.dart'; // Auto-generated file

@HiveType(typeId: 20) // Ensure typeId is unique
class ToolSection extends HiveObject {
  @HiveField(0)
  String? sectionName;

  @HiveField(1)
  Column? columns;

  @HiveField(2)
  List<Column>? data;

  @HiveField(3)
  bool? showColumnTitle;

  ToolSection(
      {this.sectionName, this.columns, this.data, this.showColumnTitle});

  ToolSection.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
    showColumnTitle = json['is_view_columns'];
    columns = json['columns'] == null ? null : Column.fromJson(json['columns']);

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Column.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['section_name'] = sectionName;
    jsonData['is_view_columns'] = showColumnTitle;
    jsonData['columns'] = columns?.toJson();
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}
