import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'screens/task_screen.dart';
import 'screens/completed_task_screen.dart';
import 'screens/settings_screen.dart';
import 'models/task.dart';
import 'models/completed_task.dart';
import 'screens/theme_provider.dart';
import 'screens/sort_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CompletedTaskAdapter());

  await Hive.deleteBoxFromDisk('tasks');
  await Hive.deleteBoxFromDisk('completed_tasks');

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<CompletedTask>('completed_tasks');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SortProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16, 
          color: Colors.white
        ),
        titleLarge: TextStyle(
          fontSize: 24, 
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home: ToDoNow(),
    );
  }
}

class ToDoNow extends StatefulWidget {
  @override
  _ToDoNowState createState() => _ToDoNowState();
}

class _ToDoNowState extends State<ToDoNow> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    TaskScreen(),
    CompletedTaskScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do Now',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined), 
            label: 'Tasks'
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline), 
            label: 'Completed Task'
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), 
            label: 'Settings'
          )
        ],
      ),
    );
  }
}