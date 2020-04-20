import 'package:hive/hive.dart';
part 'custom_types.g.dart';

@HiveType(typeId: 2)
enum TaskType {
  @HiveField(0)
  homework,
  @HiveField(1)
  project,
  @HiveField(2)
  quiz,
  @HiveField(3)
  test,
}
