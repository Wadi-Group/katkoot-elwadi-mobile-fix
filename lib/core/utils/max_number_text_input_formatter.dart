import 'package:flutter/services.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';

class MaxNumberTextInputFormatter extends TextInputFormatter {

  double max;

  MaxNumberTextInputFormatter({required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) {
    if(newValue.text == ''){
      return newValue;
    }
    String englishValue = Validator.replaceFarsiNumber(newValue.text);

    print('${oldValue.text} ${newValue.text}');
    return double.tryParse(englishValue) != null && double.parse(englishValue) > max ? oldValue : TextEditingValue(
        text: englishValue,
        selection: TextSelection(
            baseOffset: englishValue.length,
            extentOffset: englishValue.length
        )
    );
  }
}