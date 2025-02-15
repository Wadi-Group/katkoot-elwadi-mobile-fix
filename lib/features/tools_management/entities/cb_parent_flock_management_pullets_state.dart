
import 'package:katkoot_elwady/features/tools_management/entities/cb_parent_flock_management_parameters.dart';

class ParentFlockManagementPulletsState {

  int? pulletsPerWeek,
      placedHens,
      hatchingEggs,
      eggsPlaced,
      broilersPerYear,
      broilersPerWeek;

  ParentFlockManagementParameters? parameters;

  ParentFlockManagementPulletsState({
    this.pulletsPerWeek,
    this.broilersPerYear,
    this.eggsPlaced,
    this.hatchingEggs,
    this.placedHens,
    this.broilersPerWeek,
    this.parameters,
  });
}
