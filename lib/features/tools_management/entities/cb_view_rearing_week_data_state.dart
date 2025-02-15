import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cycle.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';


class ViewRearingWeekDataState {
  // double? currentValue;
  int? selectedWeekNumber;
  List<UserFormsErrors>? errorsList;
  CbCycle? cbCycle;


  ViewRearingWeekDataState({
    // this.currentValue,
    this.selectedWeekNumber,
    this.errorsList,
    this.cbCycle,
  });
}
