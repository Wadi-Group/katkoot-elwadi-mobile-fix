import 'package:katkoot_elwady/features/tools_management/models/tool.dart';

class ToolDetailsState {
  double? currentValue;
  int? selectedAgeIndex;
  Tool? tool;

  ToolDetailsState({
    this.currentValue,
    this.selectedAgeIndex,
    this.tool,
  });
}