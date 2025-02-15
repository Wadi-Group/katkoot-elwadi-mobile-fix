import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FCRViewModel extends StateNotifier<BaseState<List<UserFormsErrors>>>
    with Validator, BaseViewModel {
  FCRViewModel() : super(BaseState(data: <UserFormsErrors>[]));

  double checkCalculateFCR(
      {Tool? tool, feedWeight, meatWeight,}) {
    List<UserFormsErrors> validationErrors = Validator.validateFields(
        feedWeight: feedWeight,
        meatWeight: meatWeight,
    );
    if (validationErrors.isEmpty) {
      state = BaseState(data: [], isLoading: false);
      return calculateFCR(
          feedWeight: feedWeight,
          meatWeight: meatWeight,
          tool: tool);
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
      return 0.0;
    }
  }

  double calculateFCR(
      {Tool? tool, feedWeight, meatWeight, age, FCRValue}) {
    String? equation = tool?.equation?.equations?.fcr?.fcr
        ?.replaceAll(ToolParametersTypes.FEED_WEIGHT, feedWeight)
        .replaceAll(ToolParametersTypes.MEAT_WEIGHT, meatWeight)??""
    ;
    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    print(exp.evaluate(EvaluationType.REAL, cm) as double);
    double result = exp.evaluate(EvaluationType.REAL, cm) as double;
    return result;
  }


  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }
}
