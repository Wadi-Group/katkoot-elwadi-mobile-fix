import 'package:intl/intl.dart';

class NumbersManager {
  static String getThousandFormat(int value) {
    NumberFormat numberFormat = NumberFormat('###,###,###');
    return numberFormat.format(value);
  }

  static String convertEnglishNumbersToArabic(String input) {
    final Map<String, String> numberMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return input.split('').map((char) => numberMap[char] ?? char).join('');
  }
}
