import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:to_do_now/models/completed_task.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskBox = Hive.box<Task>('tasks');
  final _completedTaskBox = Hive.box<CompletedTask>('completed_tasks');

  void _editTask(int index, Task task) {
    final editController = TextEditingController(text: task.title);
    final _formKey = GlobalKey<FormState>();
    final focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: editController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field cannot be emptied';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final updatedTask = Task(
                  title: editController.text.trim(),
                  createdAt: task.createdAt,
                  lastUpdated: DateTime.now(),
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

  //Mark task as complete
  void _markAsCompleteTask(int index) {
    final task = _taskBox.getAt(index);
    if (task != null) {
      final completedTask = CompletedTask(
        title: task.title,
        createdAt: task.createdAt,
        lastUpdated: DateTime.now(),
        isCompleted: true,
      );
      _completedTaskBox.add(completedTask);
      _taskBox.deleteAt(index);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: const Text('No tasks yet.')
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);
              if (task == null) return const SizedBox();

              return TaskTile(
                task: task,
                onToggle: () {
                  final task = _taskBox.getAt(index);
                  if (task != null && !task.isCompleted) {
                    
                    _markAsCompleteTask(index);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task marked as completed'),
                        backgroundColor: Colors.green[400],
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                onEdit: () => _editTask(index, task),
                onDelete: () => _markAsCompleteTask(index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final _formKey = GlobalKey<FormState>();
          final focusNode = FocusNode();
          final controller = TextEditingController();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            focusNode.requestFocus();
          });

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('New Task'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field cannot be emptied';
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final task = Task(
                        title: controller.text,
                        createdAt: DateTime.now(),
                        lastUpdated: DateTime.now(),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('New task has been added'),
                          backgroundColor: Colors.green[400],
                          duration: Duration(seconds: 2),
                        ),
                      );

                      _taskBox.add(task);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
