import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '/models/completed_task.dart';
import '../screens/sort_provider.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskBox = Hive.box<Task>('tasks');
  final _completedTaskBox = Hive.box<CompletedTask>('completed_tasks');

  void _editTask(dynamic key, Task task) {
    final editController = TextEditingController(text: task.title);
    final _formKey = GlobalKey<FormState>();
    final focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Task'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: editController,
            focusNode: focusNode,
            decoration: const InputDecoration(labelText: 'Task Title'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'This field cannot be empty';
              return null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final updatedTask = Task(
                  title: editController.text.trim(),
                  createdAt: task.createdAt,
                  lastUpdated: DateTime.now(),
                  isCompleted: task.isCompleted,
                );
                _taskBox.put(key, updatedTask);
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _markAsCompleteTask(dynamic key, Task task) {
    final completedTask = CompletedTask(
      title: task.title,
      createdAt: task.createdAt,
      lastUpdated: DateTime.now(),
      isCompleted: true,
    );
    _completedTaskBox.add(completedTask);
    _taskBox.delete(key);
    setState(() {});
  }

  void _deleteTask(dynamic key, Task task) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete:\n\n"${task.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmDelete == true) {
      _taskBox.delete(key);
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${task.title}" deleted'),
          backgroundColor: Colors.red[300],
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () {
              _taskBox.put(key, task);
              setState(() {});
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortProvider = Provider.of<SortProvider>(context);

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          final List<MapEntry<dynamic, Task>> taskEntries = box.toMap().entries.toList();

          //Sorting
          switch (sortProvider.sortMode) {
            case 'Title (A-Z)':
              taskEntries.sort((a, b) => a.value.title.toLowerCase().compareTo(b.value.title.toLowerCase()));
              break;
            case 'Last Updated':
              taskEntries.sort((a, b) => b.value.lastUpdated.compareTo(a.value.lastUpdated));
              break;
            default:
              taskEntries.sort((a, b) => b.value.createdAt.compareTo(a.value.createdAt));
          }

          return ListView.builder(
            itemCount: taskEntries.length,
            itemBuilder: (context, index) {
              final entry = taskEntries[index];
              final key = entry.key;
              final task = entry.value;

              return TaskTile(
                task: task,
                onToggle: () {
                  if (!task.isCompleted) {
                    _markAsCompleteTask(key, task);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task marked as completed'),
                        backgroundColor: Colors.green[400],
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                onEdit: () => _editTask(key, task),
                onDelete: () => _deleteTask(key, task),
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

          WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('New Task'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(labelText: 'Task Title'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'This field cannot be empty';
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final task = Task(
                        title: controller.text,
                        createdAt: DateTime.now(),
                        lastUpdated: DateTime.now(),
                      );
                      _taskBox.add(task);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('New task has been added'),
                          backgroundColor: Colors.green[400],
                          duration: Duration(seconds: 2),
                        ),
                      );
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
