
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';

class ToolsDataModel {
  List<Tool>? tools;
  bool? hasMore;

  ToolsDataModel(
      {this.tools,this.hasMore});

  ToolsDataModel.fromJson(Map<String, dynamic> json) {
    Iterable toolsIterable = json['items'] ?? [];

    tools =
    List<Tool>.from(toolsIterable.map((model) => Tool.fromJson(model)));
    hasMore = json['has_more'];
  }
}
