class Pullet {
  String? broilersPerYear;
  String? placedEggs;
  String? hatchingEggs;
  String? hen;
  String? broilersPerWeek;

  Pullet(
      {this.broilersPerYear,
        this.hen,
        this.placedEggs,
        this.broilersPerWeek,
        this.hatchingEggs});

  Pullet.fromJson(Map<String, dynamic> json) {
    broilersPerYear = json["broilers_per_year"];
    placedEggs = json["placed_eggs"];
    hatchingEggs = json["hatching_egg"];
    hen = json["hen"];
    broilersPerWeek = json["broilers_per_week"];
  }
}
