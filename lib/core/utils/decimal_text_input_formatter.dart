import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:easy_localization/easy_localization.dart';

class DecimalTextInputFormatter extends TextInputFormatter {

  int? maxDecimalDigits;

  DecimalTextInputFormatter({this.maxDecimalDigits});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {

    bool localeIsEnglish = AppConstants.navigatorKey.currentContext?.locale.toString() == 'en';

    String englishValue = Validator.replaceFarsiNumber(newValue.text);
    print('english value ${englishValue}');
    final regEx = maxDecimalDigits == null ? RegExp(r'^\d*\.?\d*$') : RegExp(r'^\d*\.?\d'+'{0,$maxDecimalDigits}'+r'$');
    final newStringMatches = regEx.hasMatch(englishValue);
    if(newStringMatches){
      String displayedText = englishValue;
      if(displayedText.startsWith('.')) displayedText = '0${displayedText}';
      if(!localeIsEnglish) displayedText = displayedText.replaceAll(".", "٫");

      return TextEditingValue(
          text: displayedText,
          selection: TextSelection(
              baseOffset: displayedText.length,
              extentOffset: displayedText.length
          )
      );
    }
    return oldValue;
  }
}
