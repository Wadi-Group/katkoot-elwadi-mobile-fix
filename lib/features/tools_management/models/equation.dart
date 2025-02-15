import 'dart:convert';

import 'package:katkoot_elwady/features/tools_management/models/defaults.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations_results_title.dart';

class Equation {
  List<String>? parameters;
  Equations? equations;
  Defaults? defaults;
  EquationsResultTitle? resultTitle;

  Equation({this.parameters, this.equations, this.defaults, this.resultTitle});

  Equation.fromJson(Map<String, dynamic> json) {
    if (json['parameters'] != null) {
      parameters = [];
      json['parameters'].forEach((v) {
        parameters!.add(v);
      });
    }
    equations = json['equations'] == null
        ? null
        : Equations.fromJson(Map<String, dynamic>.from(json['equations']));
    defaults =
        json['defaults'] == null ? null : Defaults.fromJson(Map<String, dynamic>.from(json["defaults"]));
    resultTitle = json['results_title'] == null
        ? null
        : EquationsResultTitle.fromJson(Map<String, dynamic>.from(json["results_title"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parameters'] = jsonEncode(this.parameters!);
    data['equations'] = this.equations!.toJson();
    data['defaults'] = this.defaults!.toJson();
    return data;
  }
}
