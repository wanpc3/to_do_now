import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/completed_task.dart';

class CompletedTaskTile extends StatelessWidget {
  final CompletedTask completedTask;
  final VoidCallback onRestore;
  final VoidCallback onDelete;

  CompletedTaskTile({
    required this.completedTask,
    required this.onRestore,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final datePart = DateFormat('MMM d, yyyy').format(completedTask.createdAt);
    final timePart = DateFormat('hh:mm a').format(completedTask.lastUpdated);

    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        title: Text(
          completedTask.title,
          style: TextStyle(
            decoration: completedTask.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '$datePart • $timePart',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.restore_outlined, color: Colors.green),
              onPressed: onRestore,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red,),
              onPressed: onDelete,
            )
          ],
        ),
      ),
    );
  }
}