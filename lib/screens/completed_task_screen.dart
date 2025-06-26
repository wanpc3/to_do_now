import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task restored'),
        backgroundColor: Colors.green[400],
        duration: Duration(seconds: 1),
      ),
    );

    _taskBox.add(task);
    _completedTaskBox.deleteAt(
      _completedTaskBox.values.toList().indexOf(completedTask)
    );
    setState(() {});
  }

  //Delete completed task
  void _deleteTask(int index) {
    final deletedTask = _completedTaskBox.getAt(index);
    if (deletedTask == null) return;

    _completedTaskBox.deleteAt(index);
    setState(() {});

    //Undo (If necessary)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task has been deleted'),
        backgroundColor: Colors.red[300],
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            _completedTaskBox.add(deletedTask);
            setState(() {});
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _completedTaskBox.listenable(), 
        builder: (context, Box<CompletedTask> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: const Text('No completed tasks yet'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final completedTask = box.getAt(index);
              if (completedTask == null) return const SizedBox();

              return CompletedTaskTile(
                completedTask: completedTask, 
                onRestore: () => _restoreTask(completedTask), 
                onDelete: () => _deleteTask(index),
              );
            }
          );
        }
      ),
    );
  }
}