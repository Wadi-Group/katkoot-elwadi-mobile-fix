
class ParentFlockManagementParameters {

  int? broilerLivability,
      hatch,
      hatchingHen,
      pulletLivability;

  ParentFlockManagementParameters({
    this.broilerLivability,
    this.hatch,
    this.hatchingHen,
    this.pulletLivability,
  });

  ParentFlockManagementParameters.fromJson(Map<String, dynamic> json) {
    broilerLivability = json["broiler_livability"];
    hatch = json["hatch"];
    hatchingHen = json["hatching_hen"];
    pulletLivability = json["pullet_livability_to_cap"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hatch'] = this.hatch;
    data['broiler_livability'] = this.broilerLivability;
    data['hatching_hen'] = this.hatchingHen;
    data['pullet_livability_to_cap'] = this.pulletLivability;
    return data;
  }
}