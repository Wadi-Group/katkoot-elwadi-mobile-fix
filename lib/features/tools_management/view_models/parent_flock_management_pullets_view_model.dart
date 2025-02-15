
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/local/shared_preferences_service.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_parameters.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_pullets_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/pullet.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:math_expressions/math_expressions.dart';

class ParentFlockManagementPulletsViewModel extends StateNotifier<BaseState<ParentFlockManagementPulletsState>>
    with BaseViewModel {

  final Tool? tool;
  final Repository? repository;

  ParentFlockManagementPulletsViewModel(this.tool,this.repository) : super(
      BaseState(
          data: ParentFlockManagementPulletsState(
              parameters: repository?.getParentFlockManagementParameters() ?? ParentFlockManagementParameters()
          )
      )
  );

  onSliderValueChange(int? value){
    state.data.pulletsPerWeek = value;
    state = BaseState(data: state.data);

    calculateValues();
  }

  calculateValues(){
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Pullet? pulletsEquations = tool?.equation?.equations?.pullet;

    Expression placedHensExp = p.parse(pulletsEquations?.hen ?? '');
    Expression placedEggsExp = p.parse(pulletsEquations?.placedEggs ?? '');
    Expression hatchingEggExp = p.parse(pulletsEquations?.hatchingEggs ?? '');
    Expression broilerPerYearExp = p.parse(pulletsEquations?.broilersPerYear ?? '');
    Expression broilersPerWeekExp = p.parse(pulletsEquations?.broilersPerWeek ?? '');

    Variable pulletsVar = Variable('pullets'),
        pulletLivabilityToCapVar = Variable('pullet_livability_to_cap'),
        henVar = Variable('hen'),
        hatchingHenVar = Variable('hatching_hen'),
        placedEggsVar = Variable('placed_eggs'),
        hatchVar = Variable('hatch'),
        hatchingEggVar = Variable('hatching_egg'),
        broilerLivabilityVar = Variable('broiler_livability'),
        broilerPerYearVar = Variable('broilers_per_year');

    cm..bindVariable(pulletsVar, Number(state.data.pulletsPerWeek ?? 0))
      ..bindVariable(pulletLivabilityToCapVar, Number(state.data.parameters?.pulletLivability ?? tool?.equation?.defaults?.pulletLivabilityToCap?.defaultValue ?? 0));
    double? placedHens = placedHensExp.evaluate(EvaluationType.REAL, cm);
    state.data.placedHens = (placedHens ?? 0).round();

    cm..bindVariable(henVar, Number(placedHens ?? 0))
      ..bindVariable(hatchingHenVar, Number(state.data.parameters?.hatchingHen ?? tool?.equation?.defaults?.hatchedHen?.value ?? 0));
    double? eggsPlaced = placedEggsExp.evaluate(EvaluationType.REAL, cm);
    state.data.eggsPlaced = (eggsPlaced ?? 0).round();

    cm..bindVariable(placedEggsVar, Number(eggsPlaced ?? 0))
      ..bindVariable(hatchVar, Number(state.data.parameters?.hatch ?? tool?.equation?.defaults?.hatch?.defaultValue ?? 0));
    double? eggHatching = hatchingEggExp.evaluate(EvaluationType.REAL, cm);
    state.data.hatchingEggs = (eggHatching ?? 0).round();

    cm..bindVariable(hatchingEggVar, Number(eggHatching ?? 0))
      ..bindVariable(broilerLivabilityVar, Number(state.data.parameters?.broilerLivability ?? tool?.equation?.defaults?.broilerLivability?.defaultValue ?? 0));
    double? broilerPerYear = broilerPerYearExp.evaluate(EvaluationType.REAL, cm);
    state.data.broilersPerYear = (broilerPerYear ?? 0).round();

    cm..bindVariable(broilerPerYearVar, Number(broilerPerYear ?? 0));
    double? broilersPerWeek = broilersPerWeekExp.evaluate(EvaluationType.REAL, cm);
    state.data.broilersPerWeek = (broilersPerWeek ?? 0).round();

    state = BaseState(data: state.data);
  }

  onBroilerLivabilitySliderChange(int? value){
    state.data.parameters?.broilerLivability = value;
    state = BaseState(data: state.data);
    calculateValues();
  }

  onHatchSliderChange(int? value){
    state.data.parameters?.hatch = value;
    state = BaseState(data: state.data);
    calculateValues();
  }

  onHatchingHenSliderChange(int? value){
    state.data.parameters?.hatchingHen = value;
    state = BaseState(data: state.data);
    calculateValues();
  }

  onPulletLivabilitySliderChange(int? value){
    state.data.parameters?.pulletLivability = value;
    state = BaseState(data: state.data);
    calculateValues();
  }

  resetAllParametersSliders(){
    state.data.parameters = ParentFlockManagementParameters();
    state = BaseState(data: state.data);
    calculateValues();
  }

  saveParametersToLocal(){
    repository?.saveParentFlockManagementParameters(state.data.parameters);
  }
}
