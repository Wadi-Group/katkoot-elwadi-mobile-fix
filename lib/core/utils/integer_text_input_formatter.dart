import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:easy_localization/easy_localization.dart';

class IntegerTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {

    String englishValue = Validator.replaceFarsiNumber(newValue.text);
    if(englishValue.contains('.')){
      englishValue = englishValue.substring(0, englishValue.indexOf('.'));
    }
    if(englishValue.contains(',')){
      englishValue = englishValue.substring(0, englishValue.indexOf(','));
    }

    return TextEditingValue(
        text: englishValue,
        selection: TextSelection(
            baseOffset: englishValue.length,
            extentOffset: englishValue.length
        )
    );

  }
}
