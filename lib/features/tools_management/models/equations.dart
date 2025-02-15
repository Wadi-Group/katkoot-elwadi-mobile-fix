import 'package:katkoot_elwady/features/tools_management/models/brolier.dart';
import 'package:katkoot_elwady/features/tools_management/models/pef.dart';

import 'fcr.dart';
import 'pullet.dart';

class Equations {
  Broiler? broiler;
  Pullet? pullet;
  Fcr? fcr;
  Pef? pef;

  Equations({this.broiler, this.pullet, this.fcr, this.pef});

  Equations.fromJson(Map<String, dynamic> json) {
    broiler =
        json['broiler'] == null ? null : Broiler.fromJson(Map<String, dynamic>.from(json["broiler"]));
    pullet = json['pullet'] == null ? null : Pullet.fromJson(Map<String, dynamic>.from(json["pullet"]));
    fcr = json['fcr'] == null ? null : Fcr.fromJson(Map<String, dynamic>.from(json["fcr"]));
    pef = json['pef'] == null ? null : Pef.fromJson(Map<String, dynamic>.from(json["pef"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broiler'] = this.broiler;
    data['pullet'] = this.pullet;
    data['fcr'] = this.fcr;
    data['pef'] = this.pef;
    return data;
  }
}
