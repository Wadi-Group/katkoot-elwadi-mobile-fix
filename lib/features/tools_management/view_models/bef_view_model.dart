import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tool_types.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BEFViewModel extends StateNotifier<BaseState<List<UserFormsErrors>>>
    with Validator, BaseViewModel {
  BEFViewModel() : super(BaseState(data: <UserFormsErrors>[]));

  double checkCalculatePEF(
      {Tool? tool, liveability, liveWeightPerBird, age, FCRValue}) {
    List<UserFormsErrors> validationErrors = Validator.validateFields(
        liveability: liveability,
        liveWeightPerBird: liveWeightPerBird,
        age: age,
        FCRValue: FCRValue);
    if (validationErrors.isEmpty) {
      state = BaseState(data: [], isLoading: false);
      return calculatePEF(
          age: age,
          FCRValue: FCRValue,
          liveability: liveability,
          liveWeightPerBird: liveWeightPerBird,
          tool: tool);
    } else {
      state = BaseState(data: validationErrors, isLoading: false);
      return 0.0;
    }
  }

  double calculatePEF(
      {Tool? tool, liveability, liveWeightPerBird, age, FCRValue}) {
    String? equation = tool?.equation?.equations?.pef?.pef
        ?.replaceAll(ToolParametersTypes.LIVABILITY, liveability)
        .replaceAll(ToolParametersTypes.LIVE_WEIGHT, liveWeightPerBird)
        .replaceAll(ToolParametersTypes.AGE, age)
        .replaceAll(ToolParametersTypes.FCR, FCRValue)??"";
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
