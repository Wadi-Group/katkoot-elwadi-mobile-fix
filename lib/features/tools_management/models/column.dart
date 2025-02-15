import 'dart:convert';

import 'package:katkoot_elwady/features/tools_management/models/defaults.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations.dart';
import 'package:katkoot_elwady/features/tools_management/models/paramter.dart';

class Column {
  String? requirement;
  String? value;
  String? unit;
  String? male;
  String? female;

  Column({this.requirement, this.value, this.male, this.female});

  Column.fromJson(Map<String, dynamic> json) {
    requirement = json['requirement'];
    value = json['value'];
    unit = json['unit'];
    male = json['male'];
    female = json['female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requirement'] = this.requirement;
    data['value'] = this.value;
    data['unit'] = this.unit;
    data['male'] = this.male;
    data['female'] = this.female;
    return data;
  }
}
