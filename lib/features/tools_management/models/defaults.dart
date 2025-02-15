import 'package:katkoot_elwady/features/tools_management/models/broiler_per_week.dart';
import 'package:katkoot_elwady/features/tools_management/models/brolier_livabilty.dart';
import 'package:katkoot_elwady/features/tools_management/models/hatch.dart';
import 'package:katkoot_elwady/features/tools_management/models/hatching_hen.dart';
import 'package:katkoot_elwady/features/tools_management/models/pullet_livibality_to_cap.dart';
import 'package:katkoot_elwady/features/tools_management/models/pullets.dart';

class Defaults {
  double? feedWeight;
  PulletLivabilityToCap? pulletLivabilityToCap;
  BroilerPerWeek? broilerPerWeek;
  Pullets? pullets;
  HatchingHen? hatchedHen;
  Hatch? hatch;
  BroilerLivability? broilerLivability;
  Defaults(
      {this.feedWeight,
      this.broilerLivability,
      this.broilerPerWeek,
      this.pullets,
      this.hatch,
      this.hatchedHen,
      this.pulletLivabilityToCap});

  Defaults.fromJson(Map<String, dynamic> json) {
    feedWeight = json["feed_weight"];
    pulletLivabilityToCap = json['pullet_livability_to_cap'] == null
        ? null
        : PulletLivabilityToCap.fromJson(Map<String, dynamic>.from(json["pullet_livability_to_cap"]));
    hatchedHen = json['hatching_hen'] == null
        ? null
        : HatchingHen.fromJson(Map<String, dynamic>.from(json['hatching_hen']));
    broilerPerWeek = json['broiler_per_week'] == null
        ? null
        : BroilerPerWeek.fromJson(Map<String, dynamic>.from(json['broiler_per_week']));
    pullets =
        json['pullets'] == null ? null : Pullets.fromJson(Map<String, dynamic>.from(json['pullets']));
    hatch = json['hatch'] == null ? null : Hatch.fromJson(Map<String, dynamic>.from(json["hatch"]));
    broilerLivability = json['broiler_livability'] == null
        ? null
        : BroilerLivability.fromJson(Map<String, dynamic>.from(json["broiler_livability"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pullet_livability_to_cap'] = this.pulletLivabilityToCap;
    data['broiler_per_week'] = this.broilerPerWeek;
    data['pullets'] = this.pullets;
    data['hatching_hen'] = this.hatchedHen;
    data['hatch'] = this.hatch;
    data['broiler_livability'] = this.broilerLivability;
    return data;
  }
}
