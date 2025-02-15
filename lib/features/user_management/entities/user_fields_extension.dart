enum UserFields {
  NAME,
  FIRST_NAME,
  LAST_NAME,
  EMAIL,
  PASSWORD,
  PHONE,
  CITY,
  CATEGORY,
  BIRTH_DATE,
  GENDER,
  IMAGE_FILE,
  OLD_PASSWORD,
  NEW_PASSWORD,
  CONFIRM_PASSWORD,
  DATE,
  STATE,
  FLOCK_SIZE
}

extension UserFieldsExtension on UserFields {
  String get field {
    switch (this) {
      case UserFields.NAME:
        return 'name';
      case UserFields.FIRST_NAME:
        return 'first_name';
      case UserFields.LAST_NAME:
        return 'last_name';
      case UserFields.EMAIL:
        return 'email';
      case UserFields.PASSWORD:
        return 'password';
      case UserFields.PHONE:
        return 'phone';
      case UserFields.CITY:
        return 'city';
      case UserFields.CATEGORY:
        return 'category';
      case UserFields.BIRTH_DATE:
        return 'birthdate';
      case UserFields.GENDER:
        return 'gender';
      case UserFields.IMAGE_FILE:
        return 'imageFile';
      case UserFields.OLD_PASSWORD:
        return 'currentPassword';
      case UserFields.NEW_PASSWORD:
        return 'plainPassword';
      case UserFields.CONFIRM_PASSWORD:
        return 'confirm_password';

      case UserFields.DATE:
        return 'birth_date';

      case UserFields.STATE:
        return 'state';

      case UserFields.FLOCK_SIZE:
        return 'flock_size';

      default:
        return '';
    }
  }
}
