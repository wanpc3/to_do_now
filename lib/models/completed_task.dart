import 'package:hive/hive.dart';

part 'completed_task.g.dart';

@HiveType(typeId: 1)

class CompletedTask {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  DateTime lastUpdated;

  @HiveField(3)
  bool isCompleted;

  CompletedTask({
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    this.isCompleted = true
  });
}