
import 'package:intl/intl.dart';

class NumbersManager {

  static String getThousandFormat(int value){
    NumberFormat numberFormat = NumberFormat('###,###,###');
    return numberFormat.format(value);
  }
}