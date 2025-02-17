import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/entities/cycle_week_data_fields_extension.dart';
import 'package:katkoot_elwady/features/tools_management/entities/tool_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_fields_extension.dart';
import 'package:katkoot_elwady/features/user_management/entities/user_forms_errors.dart';

class Validator {
  static String? validateMessgae(String message) {
    if (message.trim().isEmpty) {
      return "message_err";
    } else if (message.length > 240) {
      return "message_err_length";
    }
  }

  static List<UserFormsErrors> validateFields({
    String? email,
    String? fullName,
    String? phone,
    String? state,
    String? flockSize,
    var city,
    List<int>? category,
    var liveability,
    var liveWeightPerBird,
    var age,
    var FCRValue,
    var feedWeight,
    var meatWeight,
    var farmName,
    var flockNumber,
    var roomName,
    var arrivalDate,
    var birthDate,
    var femaleNumber,
    var maleNumber,
    var farmcapacity,
    String? femaleFeed,
    String? maleFeed,
    String? femaleWeight,
    String? maleWeight,
    String? femaleMort,
    String? maleMort,
    String? sexErrors,
    String? culls,
    String? lightingProgram,
    String? totalEggs,
    String? hatchedEggs,
    String? eggWeight,
    String? numberOfBirds,
    String? numberOfFarms,
    String? numberOfHouses,
  }) {
    List<UserFormsErrors> errors = [];
    if (meatWeight != null) {
      if (meatWeight.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.MEAT_WEIGHT.field,
            message: 'empty_meatWeight'.tr()));
      } else if (!isNumeric(meatWeight)) {
        errors.add(UserFormsErrors(
            field: ToolFields.MEAT_WEIGHT.field,
            message: 'invalid_value'.tr()));
      } else if (double.parse(meatWeight) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.MEAT_WEIGHT.field,
            message: 'not_accept_negative_numbers'.tr()));
      }
    }
    if (feedWeight != null) {
      if (feedWeight.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.FEED_WEIGHT.field,
            message: 'empty_feedWeight'.tr()));
      } else if (!isNumeric(feedWeight)) {
        errors.add(UserFormsErrors(
            field: ToolFields.FEED_WEIGHT.field,
            message: 'invalid_value'.tr()));
      } else if (double.parse(feedWeight) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.FEED_WEIGHT.field,
            message: 'not_accept_negative_numbers'.tr()));
      }
    }

    if (liveability != null) {
      if (liveability.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVABILITY.field,
            message: 'empty_liveability'.tr()));
      } else if (!isNumeric(liveability)) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVABILITY.field, message: 'invalid_value'.tr()));
      } else if (double.parse(liveability) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVABILITY.field,
            message: 'not_accept_negative_numbers'.tr()));
      } else if (double.parse(liveability) > 100) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVABILITY.field,
            message: 'invalid_percentage'.tr()));
      }
    }
    if (liveWeightPerBird != null) {
      if (liveWeightPerBird.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVE_WEIGHT.field,
            message: 'empty_liveWeightPerBird'.tr()));
      } else if (!isNumeric(liveWeightPerBird)) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVE_WEIGHT.field,
            message: 'invalid_value'.tr()));
      } else if (double.parse(liveWeightPerBird) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.LIVE_WEIGHT.field,
            message: 'not_accept_negative_numbers'.tr()));
      }
    }
    if (age != null) {
      if (age.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.AGE.field, message: 'empty_age'.tr()));
      } else if (!isNumeric(age) || !isInt(age)) {
        errors.add(UserFormsErrors(
            field: ToolFields.AGE.field, message: 'invalid_value'.tr()));
      } else if (double.parse(age) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.AGE.field,
            message: 'not_accept_negative_numbers'.tr()));
      }
    }
    if (FCRValue != null) {
      if (FCRValue.isEmpty) {
        errors.add(UserFormsErrors(
            field: ToolFields.FCR.field, message: 'empty_FCRValue'.tr()));
      } else if (!isNumeric(FCRValue)) {
        errors.add(UserFormsErrors(
            field: ToolFields.FCR.field, message: 'invalid_value'.tr()));
      } else if (double.parse(FCRValue) < 0) {
        errors.add(UserFormsErrors(
            field: ToolFields.FCR.field,
            message: 'not_accept_negative_numbers'.tr()));
      }
    }

    if (email != null) {
      if (email.isEmpty) {
        errors.add(UserFormsErrors(
            field: UserFields.EMAIL.field, message: 'empty_email'.tr()));
      } else if (!_isValidaEmail(email)) {
        errors.add(UserFormsErrors(
            field: UserFields.EMAIL.field,
            message: 'invalid_email_format'.tr()));
      }
    }

    if (fullName != null) {
      if (fullName.isEmpty) {
        errors.add(UserFormsErrors(
            field: UserFields.NAME.field, message: 'empty_full_name'.tr()));
      } else if (fullName.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.NAME.field, message: 'full_name_length'.tr()));
      }
    }

    if (state != null) {
      if (state.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.STATE.field, message: 'state_length'.tr()));
      }
    }
    if (flockSize != null) {
      if (flockSize.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.FLOCK_SIZE.field,
            message: 'flockSize_length'.tr()));
      }
    }

    if (numberOfBirds != null) {
      if (numberOfBirds.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.NUMBER_OF_BIRDS.field,
            message: 'numberOfBirds_length'.tr()));
      }
    }

    if (numberOfFarms != null) {
      if (numberOfFarms.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.NUMBER_OF_FARMS.field,
            message: 'numberOfFarms_length'.tr()));
      }
    }
    if (numberOfHouses != null) {
      if (numberOfHouses.length > 50) {
        errors.add(UserFormsErrors(
            field: UserFields.NUMBER_OF_HOUSES.field,
            message: 'numberOfHouses_length'.tr()));
      }
    }

    if (phone != null) {
      if (phone.isEmpty) {
        errors.add(UserFormsErrors(
            field: UserFields.PHONE.field, message: 'empty_phone'.tr()));
      } else if (phone.length > 15 || phone.length < 11) {
        errors.add(UserFormsErrors(
            field: UserFields.PHONE.field, message: 'phone_name_length'.tr()));
      }
      if (!_isValidaPhoneNumber(phone)) {
        errors.add(UserFormsErrors(
            field: UserFields.PHONE.field, message: 'invalid_phone'.tr()));
      }
    }

    if (city == 0) {
      errors.add(UserFormsErrors(
          field: UserFields.CITY.field, message: 'empty_city'.tr()));
    }
    if (category != null && category.isEmpty) {
      print("categories is empty");
      errors.add(UserFormsErrors(
          field: UserFields.CATEGORY.field, message: 'empty_category'.tr()));
    }
    // var farmName,
    // var roomName,
    // var location,
    // var arrivalDate,
    // var femaleNumber,
    // var maleNumber
    if (farmName != null) {
      if (farmName.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.FARM_NAME.field,
            message: 'empty_farm_name'.tr()));
      } else if (farmName.toString().length > 50) {
        errors.add(UserFormsErrors(
            field: CycleFields.FARM_NAME.field,
            message: 'farm_name_length_error'.tr()));
      }
    }
    if (flockNumber != null) {
      if (flockNumber.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.FLOCK_NUMBER.field,
            message: 'empty_flock_number'.tr()));
      } else if (flockNumber.toString().length > 50) {
        errors.add(UserFormsErrors(
            field: CycleFields.FLOCK_NUMBER.field,
            message: 'flock_number_length_error'.tr()));
      }
    }
    if (roomName != null) {
      if (roomName.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.ROOM_NAME.field,
            message: 'empty_room_name'.tr()));
      } else if (farmName.toString().length > 50) {
        errors.add(UserFormsErrors(
            field: CycleFields.ROOM_NAME.field,
            message: 'room_name_length_error'.tr()));
      }
    }
    if (arrivalDate != null) {
      if (arrivalDate.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.ARRIVAL_DATE.field,
            message: 'empty_arrival_date'.tr()));
      }
    }
    if (birthDate != null) {
      if (birthDate.isEmpty) {
        errors.add(UserFormsErrors(
            field: UserFields.DATE.field, message: 'empty_birth_date'.tr()));
      }
    }
    if (femaleNumber != null) {
      if (femaleNumber.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.FEMALE_NUMBER.field,
            message: 'empty_female_number'.tr()));
      } else {
        try {
          if (femaleNumber.toString().length > 9) {
            errors.add(UserFormsErrors(
                field: CycleFields.FEMALE_NUMBER.field,
                message: 'invalid_female_number_length'.tr()));
          } else if (int.tryParse(femaleNumber)! <= 0) {
            errors.add(UserFormsErrors(
                field: CycleFields.FEMALE_NUMBER.field,
                message: 'invalid_female_number'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleFields.FEMALE_NUMBER.field,
              message: 'invalid_female_number'.tr()));
        }
      }
    }
    if (maleNumber != null) {
      if (maleNumber.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleFields.MALE_NUMBER.field,
            message: 'empty_male_number'.tr()));
      } else {
        try {
          if (maleNumber.toString().length > 9) {
            errors.add(UserFormsErrors(
                field: CycleFields.MALE_NUMBER.field,
                message: 'invalid_male_number_length'.tr()));
          } else if (int.tryParse(maleNumber)! <= 0) {
            errors.add(UserFormsErrors(
                field: CycleFields.MALE_NUMBER.field,
                message: 'invalid_male_number'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleFields.MALE_NUMBER.field,
              message: 'invalid_male_number'.tr()));
        }
      }
    }

    if (femaleFeed != null) {
      if (femaleFeed.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.FEMALE_FEED.id,
            message: 'empty_female_feed'.tr()));
      } else {
        try {
          if (femaleFeed.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_FEED.id,
                message: 'invalid_female_feed_length'.tr()));
          } else if (double.tryParse(femaleFeed)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_FEED.id,
                message: 'invalid_female_feed'.tr()));
          } else if (!isNumeric(femaleFeed.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_FEED.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.FEMALE_FEED.id,
              message: 'invalid_female_feed'.tr()));
        }
      }
    }

    if (maleFeed != null) {
      if (maleFeed.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.MALE_FEED.id,
            message: 'empty_male_feed'.tr()));
      } else {
        try {
          if (maleFeed.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_FEED.id,
                message: 'invalid_male_feed_length'.tr()));
          } else if (double.tryParse(maleFeed)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_FEED.id,
                message: 'invalid_male_feed'.tr()));
          } else if (!isNumeric(maleFeed.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_FEED.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.MALE_FEED.id,
              message: 'invalid_male_feed'.tr()));
        }
      }
    }

    if (femaleWeight != null) {
      if (femaleWeight.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.FEMALE_WEIGHT.id,
            message: 'empty_female_weight'.tr()));
      } else {
        try {
          if (femaleWeight.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_WEIGHT.id,
                message: 'invalid_female_weight_length'.tr()));
          } else if (double.tryParse(femaleWeight)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_WEIGHT.id,
                message: 'invalid_female_weight'.tr()));
          } else if (!isNumeric(femaleWeight.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_WEIGHT.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.FEMALE_WEIGHT.id,
              message: 'invalid_female_weight'.tr()));
        }
      }
    }

    if (maleWeight != null) {
      if (maleWeight.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.MALE_WEIGHT.id,
            message: 'empty_male_weight'.tr()));
      } else {
        try {
          if (maleWeight.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_WEIGHT.id,
                message: 'invalid_male_weight_length'.tr()));
          } else if (double.tryParse(maleWeight)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_WEIGHT.id,
                message: 'invalid_male_weight'.tr()));
          } else if (!isNumeric(maleWeight.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_WEIGHT.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.MALE_WEIGHT.id,
              message: 'invalid_male_weight'.tr()));
        }
      }
    }

    if (femaleMort != null) {
      if (femaleMort.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.FEMALE_MORT.id,
            message: 'empty_female_mort'.tr()));
      } else {
        try {
          if (femaleMort.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_MORT.id,
                message: 'invalid_female_mort_length'.tr()));
          } else if (int.tryParse(femaleMort)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_MORT.id,
                message: 'invalid_female_mort'.tr()));
          } else if (!isNumeric(femaleMort.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.FEMALE_MORT.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.FEMALE_MORT.id,
              message: 'invalid_female_mort'.tr()));
        }
      }
    }

    if (maleMort != null) {
      if (maleMort.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.MALE_MORT.id,
            message: 'empty_male_mort'.tr()));
      } else {
        try {
          if (maleMort.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_MORT.id,
                message: 'invalid_male_mort_length'.tr()));
          } else if (int.tryParse(maleMort)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_MORT.id,
                message: 'invalid_male_mort'.tr()));
          } else if (!isNumeric(maleMort.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.MALE_MORT.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.MALE_MORT.id,
              message: 'invalid_male_mort'.tr()));
        }
      }
    }

    if (sexErrors != null) {
      if (sexErrors.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.SEX_ERRORS.id,
            message: 'empty_sex_errors'.tr()));
      } else {
        try {
          if (sexErrors.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.SEX_ERRORS.id,
                message: 'invalid_sex_errors_length'.tr()));
          } else if (int.tryParse(sexErrors)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.SEX_ERRORS.id,
                message: 'invalid_sex_errors'.tr()));
          } else if (!isNumeric(sexErrors.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.SEX_ERRORS.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.SEX_ERRORS.id,
              message: 'invalid_sex_errors'.tr()));
        }
      }
    }

    if (culls != null) {
      if (culls.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.CULLS.id, message: 'empty_culls'.tr()));
      } else {
        try {
          if (culls.toString().length > 6) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.CULLS.id,
                message: 'invalid_culls_length'.tr()));
          } else if (int.tryParse(culls)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.CULLS.id,
                message: 'invalid_culls'.tr()));
          } else if (!isNumeric(culls.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.CULLS.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.CULLS.id,
              message: 'invalid_culls'.tr()));
        }
      }
    }

    if (lightingProgram != null) {
      if (lightingProgram.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
            message: 'empty_lighting_program'.tr()));
      } else {
        try {
          if (lightingProgram.toString().length > 4) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
                message: 'invalid_lighting_program_length'.tr()));
          } else if (int.tryParse(lightingProgram)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
                message: 'invalid_lighting_program'.tr()));
          } else if (int.tryParse(lightingProgram)! > 16) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
                message: 'invalid_lighting_program_15'.tr()));
          } else if (!isNumeric(lightingProgram.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.LIGHTING_PROGRAM.id,
              message: 'invalid_lighting_program'.tr()));
        }
      }
    }

    if (totalEggs != null) {
      if (totalEggs.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.TOTAL_EGGS.id,
            message: 'empty_total_eggs'.tr()));
      } else {
        try {
          if (totalEggs.toString().length > 9) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.TOTAL_EGGS.id,
                message: 'invalid_total_eggs_length'.tr()));
          } else if (int.tryParse(totalEggs)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.TOTAL_EGGS.id,
                message: 'invalid_total_eggs'.tr()));
          } else if (!isNumeric(totalEggs.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.TOTAL_EGGS.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.TOTAL_EGGS.id,
              message: 'invalid_total_eggs'.tr()));
        }
      }
    }

    if (hatchedEggs != null) {
      if (hatchedEggs.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.HATCHED_EGGS.id,
            message: 'empty_hatched_eggs'.tr()));
      } else {
        try {
          if (hatchedEggs.toString().length > 9) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.HATCHED_EGGS.id,
                message: 'invalid_hatched_eggs_length'.tr()));
          } else if ((totalEggs != null &&
              (int.tryParse(hatchedEggs.toString())!) >
                  (int.tryParse(totalEggs.toString())!))) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.HATCHED_EGGS.id,
                message: 'invalid_hatched_eggs_value'.tr()));
          } else if (int.tryParse(hatchedEggs)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.HATCHED_EGGS.id,
                message: 'invalid_hatched_eggs'.tr()));
          } else if (!isNumeric(hatchedEggs.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.HATCHED_EGGS.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.HATCHED_EGGS.id,
              message: 'invalid_hatched_eggs'.tr()));
        }
      }
    }

    if (eggWeight != null) {
      if (eggWeight.isEmpty) {
        errors.add(UserFormsErrors(
            field: CycleWeekDataFields.EGG_WEIGHT.id,
            message: 'empty_egg_weight'.tr()));
      } else {
        try {
          if (eggWeight.contains(".")
              ? eggWeight.split(".")[0].length > 3
              : eggWeight.toString().length > 3) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.EGG_WEIGHT.id,
                message: 'invalid_egg_weight_length'.tr()));
          } else if (double.tryParse(eggWeight)! < 0) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.EGG_WEIGHT.id,
                message: 'invalid_egg_weight'.tr()));
          } else if (!isNumeric(eggWeight.toString())) {
            errors.add(UserFormsErrors(
                field: CycleWeekDataFields.EGG_WEIGHT.id,
                message: 'invalid_value'.tr()));
          }
        } catch (error) {
          errors.add(UserFormsErrors(
              field: CycleWeekDataFields.EGG_WEIGHT.id,
              message: 'invalid_egg_weight'.tr()));
        }
      }
    }
    return errors;
  }

  static bool _isValidaPhoneNumber(String value) {
    // String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
    String pattern = r'(^[0-9]{11,15}$)';
    RegExp regExp = new RegExp(pattern);
    print(regExp.hasMatch(value));
    return regExp.hasMatch(value); //&& validStartphoneNum;
  }

  static bool _isValidaName(String value) {
    value = value.replaceAll(" ", "");
    String pattern = r'^[a-zA-Z\-\.]+$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool _isValidaEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', "."];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', "٫"];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    print("input : " + input);
    return input;
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  static bool isInt(String s) {
    return int.tryParse(s) != null;
  }
}
