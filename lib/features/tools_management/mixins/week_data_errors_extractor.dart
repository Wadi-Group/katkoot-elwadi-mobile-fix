import 'package:katkoot_elwady/features/tools_management/entities/cycle_week_data_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

mixin WeekDataErrorsExtractor {
  List<UserFormsErrors> getWeekFieldsErrors(Map<String, dynamic> errors){
    List<UserFormsErrors> formErrors = [];

    if(errors.containsKey(CycleWeekDataFields.FEMALE_FEED.id)){
      List messagesList = errors[CycleWeekDataFields.FEMALE_FEED.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.FEMALE_FEED.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.MALE_FEED.id)){
      List messagesList = errors[CycleWeekDataFields.MALE_FEED.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.MALE_FEED.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.FEMALE_WEIGHT.id)){
      List messagesList = errors[CycleWeekDataFields.FEMALE_WEIGHT.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.FEMALE_WEIGHT.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.MALE_WEIGHT.id)){
      List messagesList = errors[CycleWeekDataFields.MALE_WEIGHT.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.MALE_WEIGHT.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.FEMALE_MORT.id)){
      List messagesList = errors[CycleWeekDataFields.FEMALE_MORT.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.FEMALE_MORT.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.MALE_MORT.id)){
      List messagesList = errors[CycleWeekDataFields.MALE_MORT.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.MALE_MORT.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.SEX_ERRORS.id)){
      List messagesList = errors[CycleWeekDataFields.SEX_ERRORS.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.SEX_ERRORS.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.CULLS.id)){
      List messagesList = errors[CycleWeekDataFields.CULLS.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.CULLS.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.LIGHTING_PROGRAM.id)){
      List messagesList = errors[CycleWeekDataFields.LIGHTING_PROGRAM.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.LIGHTING_PROGRAM.id, message: messagesList.first)
        );
      }
    }

    if(errors.containsKey(CycleWeekDataFields.TOTAL_EGGS.id)){
      List messagesList = errors[CycleWeekDataFields.TOTAL_EGGS.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.TOTAL_EGGS.id, message: messagesList.first)
        );
      }
    }


    if(errors.containsKey(CycleWeekDataFields.HATCHED_EGGS.id)){
      List messagesList = errors[CycleWeekDataFields.HATCHED_EGGS.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.HATCHED_EGGS.id, message: messagesList.first)
        );
      }
    }


    if(errors.containsKey(CycleWeekDataFields.EGG_WEIGHT.id)){
      List messagesList = errors[CycleWeekDataFields.EGG_WEIGHT.id] as List;
      if(messagesList.isNotEmpty){
        formErrors.add(
            UserFormsErrors(field: CycleWeekDataFields.EGG_WEIGHT.id, message: messagesList.first)
        );
      }
    }
    return formErrors;
  }
}