import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';

class Cycle {
  int? id;
  String? name;
  String? farmName;
  String? arrivalDate;
  String? location;
  int? male;
  int? female;
  List<int>? durations;
  List<WeekData>? weeksList;

  Cycle({
    this.id,
    this.name,
    this.farmName,
    this.arrivalDate,
    this.location,
    this.male,
    this.female,
    this.weeksList,
  });

  Cycle.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    farmName = json["farm_name"];
    arrivalDate = json["arrival_date"];
    location = json["location"];
    male = json["male"];
    female = json["female"];
    if (json['durations'] != null) {
      durations = [];
      json['durations'].forEach((v) {
        durations!.add(v);
      });
    }
    if (json['data'] != null) {
      weeksList = [];
      json['data'].forEach((v) {
        weeksList!.add(WeekData.fromJson(v));
      });
    }
  }

  String getDateFormatted() {
    // return arrivalDate != null
    //     ? DateFormat('MMMM yyyy').format(DateTime.parse(arrivalDate!))
    //     : "";

    if (arrivalDate != null) {
      String? schedule;
      var context = AppConstants.navigatorKey.currentContext;
      if (context != null) {
        context.locale.languageCode == "en"
            ? schedule =
                DateFormat("MMMM yyyy").format(DateTime.parse(arrivalDate!))
            : schedule =
                DateFormat.yMMM('ar').format(DateTime.parse(arrivalDate!));
        return schedule;
      }
    }
    return "";
  }

  int getMaxWeek() {
    if (durations != null && durations!.isNotEmpty) {
      return durations!.reduce((curr, next) => curr > next ? curr : next);
    }
    return 1;
  }

  int? getMaxProductionWeek() {
    if (durations != null && durations!.isNotEmpty) {
      var value = durations!.reduce((curr, next) => curr > next ? curr : next);

      if (value > 24) {
        return value;
      }
    }
  }

  int? getMaxRearingWeek() {
    if (durations != null && durations!.isNotEmpty) {
      durations!.removeWhere((element) => element > 24);
      var value = durations!.reduce((curr, next) => curr > next ? curr : next);
      if (value <= 24) {
        return value;
      }
    }
  }

  bool weekIsExists(int week) {
    return durations!.contains(week);
  }

  String getLevel(int week) {
    return (week > AppConstants.REARING_MAX_VALUE)
        ? "str_production".tr()
        : "str_rear".tr();
  }

  int getCurrentSectionData(int sliderPosition) {
    if (weeksList != null) {
      for (var i = 0; i < weeksList!.length; i++) {
        if (weeksList![i].duration! == sliderPosition) {
          return i;
        }
      }
    }
    return 0;
  }

  WeekData getWeekData(int index) {
    if (weeksList != null) {
      for (var i = 0; i < weeksList!.length; i++) {
        if (weeksList![i].duration! == index) {
          return weeksList![i];
        }
      }
    }
    return WeekData();
  }
}
