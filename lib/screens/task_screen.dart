import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:to_do_now/widgets/task_tile.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskBox = Hive.box<Task>('tasks');
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final task = Task(title: _controller.text);
    _taskBox.add(task);
    _controller.clear();
    setState(() {});
  }

  void _toggleTaskCompletion(int index) {
    final task = _taskBox.getAt(index);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      _taskBox.putAt(index, task);
      setState(() {});
    }
  }

  void _editTask(int index, Task task) {
    final TextEditingController editController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (editController.text.isNotEmpty) {
                final updatedTask = Task(
                  title: editController.text,
                  isCompleted: task.isCompleted,
                );
                _taskBox.putAt(index, updatedTask);
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    _taskBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No tasks yet.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);
              if (task == null) return const SizedBox();

              return TaskTile(
                task: task,
                onToggle: () => _toggleTaskCompletion(index),
                onEdit: () => _editTask(index, task),
                onDelete: () => _deleteTask(index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('New Task'),
            content: TextField(controller: _controller),
            actions: [
              TextButton(
                onPressed: () {
                  _addTask();
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              )
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
