
import 'package:katkoot_elwady/features/tools_management/entities/cb_parent_flock_management_parameters.dart';

class ParentFlockManagementBroilerState {

  int? broilerPerWeek,
      broilersPerYear,
      chickenPlacedBeforeDeath,
      placedEggs,
      hen,
      pullets;
  ParentFlockManagementParameters? parameters;

  ParentFlockManagementBroilerState({
    this.broilerPerWeek,
    this.broilersPerYear,
    this.chickenPlacedBeforeDeath,
    this.placedEggs,
    this.hen,
    this.pullets,
    this.parameters,
  });
}
