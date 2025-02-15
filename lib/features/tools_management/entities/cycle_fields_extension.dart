enum CycleFields {
  FARM_NAME,
  FLOCK_NUMBER,
  ROOM_NAME,
  ARRIVAL_DATE,
  FEMALE_NUMBER,
  MALE_NUMBER
}

extension CycleFieldsExtension on CycleFields {
  String get field {
    switch (this) {
      case CycleFields.FARM_NAME:
        return 'farm_name';
      case CycleFields.FLOCK_NUMBER:
        return 'flock_number';
      case CycleFields.ROOM_NAME:
        return 'room_name';
      case CycleFields.ARRIVAL_DATE:
        return 'arrival_date';
      case CycleFields.FEMALE_NUMBER:
        return 'female_number';
      case CycleFields.MALE_NUMBER:
        return 'male_number';
      default:
        return '';
    }
  }
}
