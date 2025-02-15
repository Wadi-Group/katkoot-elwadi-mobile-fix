
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_broiler_state.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_parameters.dart';
import 'package:katkoot_elwady/features/tools_management/models/brolier.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:math_expressions/math_expressions.dart';

class ParentFlockManagementBroilerViewModel extends StateNotifier<BaseState<ParentFlockManagementBroilerState>>
    with BaseViewModel {

  final Tool? tool;
  final Repository? repository;
  ParentFlockManagementBroilerViewModel(this.tool,this.repository) : super(
      BaseState(
          data: ParentFlockManagementBroilerState(
              parameters: repository?.getParentFlockManagementParameters() ?? ParentFlockManagementParameters()
          )
      )
  );

  onSliderValueChange(int? value){
    state.data.broilerPerWeek = value;
    state = BaseState(data: state.data);

    calculateValues();
  }

  calculateValues(){
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Broiler? broilerEquations = tool?.equation?.equations?.broiler;

    Expression broilerPerYearExp = p.parse(broilerEquations?.broilersPerYear ?? '');
    Expression chickenPlacedExp = p.parse(broilerEquations?.chickenPlacedBeforeDeath ?? '');
    Expression placedEggsExp = p.parse(broilerEquations?.placedEggs ?? '');
    Expression placedHensExp = p.parse(broilerEquations?.hen ?? '');
    Expression pulletsExp = p.parse(broilerEquations?.pullets ?? '');

    Variable broilerPerWeekVar = Variable('broiler_per_week'),
        broilerPerYearVar = Variable('broilers_per_year'),
        broilerLivabilityVar = Variable('broiler_livability'),
        chickenPlacedBeforeDeathVar = Variable('chicken_placed_before_death'),
        hatchVar = Variable('hatch'),
        placedEggsVar = Variable('placed_eggs'),
        hatchingHenVar = Variable('hatching_hen'),
        henVar = Variable('hen'),
        pulletLivabilityToCapVar = Variable('pullet_livability_to_cap');

    cm..bindVariable(broilerPerWeekVar, Number(state.data.broilerPerWeek ?? 0));
    double? broilerPerYears = broilerPerYearExp.evaluate(EvaluationType.REAL, cm);
    state.data.broilersPerYear = (broilerPerYears ?? 0).round();

    cm..bindVariable(broilerPerYearVar, Number(broilerPerYears ?? 0))
      ..bindVariable(broilerLivabilityVar, Number(state.data.parameters?.broilerLivability ?? tool?.equation?.defaults?.broilerLivability?.defaultValue ?? 0));
    double? chickenPlaced = chickenPlacedExp.evaluate(EvaluationType.REAL, cm);
    state.data.chickenPlacedBeforeDeath = (chickenPlaced ?? 0).round();

    cm..bindVariable(chickenPlacedBeforeDeathVar, Number(chickenPlaced ?? 0))
      ..bindVariable(hatchVar, Number(state.data.parameters?.hatch ?? tool?.equation?.defaults?.hatch?.defaultValue ?? 0));
    double? placedEggs = placedEggsExp.evaluate(EvaluationType.REAL, cm);
    state.data.placedEggs = (placedEggs ?? 0).round();

    cm..bindVariable(placedEggsVar, Number(placedEggs ?? 0))
      ..bindVariable(hatchingHenVar, Number(state.data.parameters?.hatchingHen ?? tool?.equation?.defaults?.hatchedHen?.value ?? 0));
    double? placedHens = placedHensExp.evaluate(EvaluationType.REAL, cm);
    state.data.hen = (placedHens ?? 0).round();

    cm..bindVariable(henVar, Number(placedHens ?? 0))
      ..bindVariable(pulletLivabilityToCapVar, Number(state.data.parameters?.pulletLivability ?? tool?.equation?.defaults?.pulletLivabilityToCap?.defaultValue ?? 0));
    double? pullets = pulletsExp.evaluate(EvaluationType.REAL, cm);
    state.data.pullets = (pullets ?? 0).round();

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
