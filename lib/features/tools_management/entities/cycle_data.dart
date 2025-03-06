import 'package:hive/hive.dart';

part 'cycle_data.g.dart';

@HiveType(typeId: 23) // Ensure unique typeId
class CreateCycle extends HiveObject {
  @HiveField(0)
  final String farmName;

  @HiveField(1)
  final String location;

  @HiveField(2)
  final String arrivalDate;

  @HiveField(3)
  final String male;

  @HiveField(4)
  final String female;

  @HiveField(5)
  final String toolId;

  CreateCycle({
    required this.farmName,
    required this.location,
    required this.arrivalDate,
    required this.male,
    required this.female,
    required this.toolId,
  });
}
