import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class CycleEditWeekDataState {
  List<UserFormsErrors>? errorsList;
  WeekData? weekData;


  CycleEditWeekDataState({
    this.errorsList,
    this.weekData,
  });
}