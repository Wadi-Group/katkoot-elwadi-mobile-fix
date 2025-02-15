import 'column.dart';

class ToolSection {
  String? sectionName;
  Column? columns;
  List<Column>? data;
  bool? showColumnTitle;

  ToolSection(
      {this.sectionName,
        this.columns,
        this.data,
        this.showColumnTitle,
      });

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_name'] = this.sectionName;
    data['is_view_columns'] = this.showColumnTitle;
    data['columns'] = this.columns!.toJson();
    if (this.data != null) {
      data['data'] = this.data!.toList();
    }

    return data;
  }
}
