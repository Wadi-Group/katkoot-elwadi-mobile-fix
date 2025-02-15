
import 'package:katkoot_elwady/features/tools_management/models/tool_section.dart';

class ToolData {
  int? durationFrom;
  int? durationTo;
  List<ToolSection>? sections;

  ToolData(
      {this.durationFrom,
        this.durationTo,
        this.sections,
      });

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration_from'] = this.durationFrom;
    data['duration_to'] = this.durationTo;
    if (this.sections != null) {
      data['data'] = this.sections!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
