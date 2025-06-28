import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../screens/theme_provider.dart';
import '../screens/sort_provider.dart';
import '../widgets/completed_task_tile.dart';
import '../models/completed_task.dart';
import '../models/task.dart';

class CompletedTaskScreen extends StatefulWidget {
  @override
  _CompletedTaskScreenState createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final _taskBox = Hive.box<Task>('tasks');
  final _completedTaskBox = Hive.box<CompletedTask>('completed_tasks');

  //Restore task
  void _restoreTask(CompletedTask completedTask) {
    final task = Task(
      title: completedTask.title,
      createdAt: completedTask.createdAt,
      lastUpdated: DateTime.now(),
    );

    if (Provider.of<ThemeProvider>(context, listen: false).showAlerts) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task restored'),
          backgroundColor: Colors.green[400],
          duration: Duration(seconds: 1),
        ),
      );
    }

    _taskBox.add(task);
    _completedTaskBox.deleteAt(
      _completedTaskBox.values.toList().indexOf(completedTask)
    );
    setState(() {});
  }

  //Delete completed task
  void _deleteTask(dynamic key, CompletedTask deletedTask) {
    _completedTaskBox.delete(key);
    setState(() {});

    bool undoClicked = false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task has been deleted'),
        backgroundColor: Colors.red[300],
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            undoClicked = true;
            _completedTaskBox.put(key, deletedTask);
            setState(() {});
          },
        ),
      ),
    ).closed.then((_) {
      if (!undoClicked) {
        // Optional: final confirmation or logging
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortProvider = Provider.of<SortProvider>(context);

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _completedTaskBox.listenable(), 
        builder: (context, Box<CompletedTask> box, _) {
          final List<MapEntry<dynamic, CompletedTask>> completedTaskEntries = box.toMap().entries.toList();

          // Apply sorting
          switch (sortProvider.sortMode) {
            case 'Title (A-Z)':
              completedTaskEntries.sort((a, b) => a.value.title.toLowerCase().compareTo(b.value.title.toLowerCase()));
              break;
            case 'Last Updated':
              completedTaskEntries.sort((a, b) => b.value.lastUpdated.compareTo(a.value.lastUpdated));
              break;
            default:
              completedTaskEntries.sort((a, b) => b.value.createdAt.compareTo(a.value.createdAt));
          }

          if (completedTaskEntries.isEmpty) {
            return const Center(
              child: Text('No completed tasks yet'),
            );
          }

          return ListView.builder(
            itemCount: completedTaskEntries.length,
            itemBuilder: (context, index) {
              final entry = completedTaskEntries[index];
              final key = entry.key;
              final task = entry.value;

              return CompletedTaskTile(
                completedTask: task,
                onRestore: () => _restoreTask(task),
                onDelete: () => _deleteTask(key, task),
              );
            },
          );
        },
      ),
    );
  }
}