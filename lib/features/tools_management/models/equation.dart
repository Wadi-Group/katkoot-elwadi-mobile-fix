import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:katkoot_elwady/features/tools_management/models/defaults.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations_result_title.dart';

part 'equation.g.dart'; // Required for the generated Hive adapter

@HiveType(typeId: 1) // Unique ID for this model
class Equation extends HiveObject {
  @HiveField(0)
  List<String>? parameters;

  @HiveField(1)
  Equations? equations;

  @HiveField(2)
  Defaults? defaults;

  @HiveField(3)
  EquationsResultTitle? resultTitle;

  Equation({this.parameters, this.equations, this.defaults, this.resultTitle});

  factory Equation.fromJson(Map<String, dynamic> json) {
    return Equation(
      parameters: json['parameters'] != null
          ? List<String>.from(json['parameters'])
          : null,
      equations: json['equations'] != null
          ? Equations.fromJson(Map<String, dynamic>.from(json['equations']))
          : null,
      defaults: json['defaults'] != null
          ? Defaults.fromJson(Map<String, dynamic>.from(json['defaults']))
          : null,
      resultTitle: json['results_title'] != null
          ? EquationsResultTitle.fromJson(
              Map<String, dynamic>.from(json['results_title']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameters': parameters,
      'equations': equations?.toJson(),
      'defaults': defaults?.toJson(),
      'results_title': resultTitle?.toJson(),
    };
  }
}
