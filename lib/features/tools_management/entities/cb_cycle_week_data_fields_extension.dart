enum CycleWeekDataFields {
  FEMALE_FEED,
  MALE_FEED,
  FEMALE_WEIGHT,
  MALE_WEIGHT,
  FEMALE_MORT,
  MALE_MORT,
  SEX_ERRORS,
  CULLS,
  LIGHTING_PROGRAM,
  TOTAL_EGGS,
  HATCHED_EGGS,
  EGG_WEIGHT,
}

extension CycleWeekDataFieldsExtension on CycleWeekDataFields {
  String get id {
    switch (this) {
      case CycleWeekDataFields.FEMALE_FEED:
        return 'female_feed';
      case CycleWeekDataFields.MALE_FEED:
        return 'male_feed';
      case CycleWeekDataFields.FEMALE_WEIGHT:
        return 'female_weight';
      case CycleWeekDataFields.MALE_WEIGHT:
        return 'male_weight';
      case CycleWeekDataFields.FEMALE_MORT:
        return 'female_mort';
      case CycleWeekDataFields.MALE_MORT:
        return 'male_mort';
      case CycleWeekDataFields.SEX_ERRORS:
        return 'sex_errors';
      case CycleWeekDataFields.CULLS:
        return 'culls';
      case CycleWeekDataFields.LIGHTING_PROGRAM:
        return 'lighting_prog';
      case CycleWeekDataFields.TOTAL_EGGS:
        return 'total_egg';
      case CycleWeekDataFields.HATCHED_EGGS:
        return 'hatched_egg';
      case CycleWeekDataFields.EGG_WEIGHT:
        return 'egg_weight';
      default:
        return '';
    }
  }
}
