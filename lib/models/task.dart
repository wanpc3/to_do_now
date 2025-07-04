import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)

class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  DateTime lastUpdated;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    this.isCompleted = false
  });
}