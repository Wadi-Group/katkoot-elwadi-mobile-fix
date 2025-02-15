import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cycle.dart';
// import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class ViewProductionWeekDataState {
  // double? currentValue;
  int? selectedWeekNumber;
  List<UserFormsErrors>? errorsList;
  CbCycle? cbcycle;


  ViewProductionWeekDataState({
    // this.currentValue,
    this.selectedWeekNumber,
    this.errorsList,
    this.cbcycle, CbCycle,
  });
}
