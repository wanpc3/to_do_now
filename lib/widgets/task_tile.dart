import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TaskTile({
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final datePart = DateFormat('MMM d, yyyy').format(task.createdAt);
    final timePart = DateFormat('hh:mm a').format(task.lastUpdated);

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
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '$datePart • $timePart',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle()
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
            )
          ],
        ),
      ),
    );
  }
}