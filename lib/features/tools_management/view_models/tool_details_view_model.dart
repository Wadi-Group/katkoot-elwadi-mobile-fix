import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/tool_details_state.dart';

class ToolDetailsViewModel extends StateNotifier<BaseState<ToolDetailsState?>>
    with BaseViewModel {
  Repository _repository;
  int? selectedAgeIndex;

  ToolDetailsViewModel(this._repository)
      : super(BaseState(data: ToolDetailsState()));

  Future getDetails(int? toolId, int defaultSectionIndex) async {
    if (toolId != null) {
      ToolDetailsState? toolState;
      state = BaseState(data: toolState, isLoading: true);

      var result = await _repository.getToolDetails(toolId);
      print(result.data);

      if (result.data != null) {
        toolState = ToolDetailsState(
            tool: result.data!,
            selectedAgeIndex: result.data!.getCurrentSectionData(
                result.data?.sliderData?.defaultValue ?? defaultSectionIndex),
            currentValue: defaultSectionIndex.toDouble());
        state = BaseState(data: toolState);
      } else {
        if (result.errorType == ErrorType.NO_NETWORK_ERROR) {
          state = BaseState(data: toolState, hasNoConnection: true);
        } else {
          state = BaseState(data: toolState, isLoading: false);
          handleError(
              errorType: result.errorType,
              errorMessage: result.errorMessage,
              keyValueErrors: result.keyValueErrors);
        }
      }
    }
  }

  getSelectedAgeDataIndex(double age) {
    var toolData = state.data?.tool?.toolData ?? [];
    for (int i = 0; i < toolData.length; i++) {
      if (age <= (toolData[i].durationTo ?? 0) &&
          age >= (toolData[i].durationFrom ?? 0)) {
        state.data?.selectedAgeIndex = i;
        state = BaseState(
            data: ToolDetailsState(
                tool: state.data?.tool,
                selectedAgeIndex: i,
                currentValue: age));
        break;
      }
    }
  }
}
