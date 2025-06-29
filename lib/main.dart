import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/task_screen.dart';
import 'screens/completed_task_screen.dart';
import 'screens/settings_screen.dart';
import 'models/task.dart';
import 'models/completed_task.dart';
import 'screens/theme_provider.dart';
import 'screens/sort_provider.dart';
import 'info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CompletedTaskAdapter());

  //await Hive.deleteBoxFromDisk('tasks');
  //await Hive.deleteBoxFromDisk('completed_tasks');

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<CompletedTask>('completed_tasks');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
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
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: themeProvider.useCustomTheme
            ? themeProvider.backgroundColor
            : null,
        appBarTheme: AppBarTheme(
          backgroundColor: themeProvider.useCustomTheme
              ? themeProvider.appBarColor
              : Colors.amber,
        ),
        cardColor: themeProvider.useCustomTheme
            ? themeProvider.cardColor
            : null,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.useCustomTheme
          ? ThemeMode.light
          : themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
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

  static final List<String> _appBarTitle = [
    'To-Do Now',
    'Completed Task',
    'Settings',
  ];

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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _appBarTitle[_selectedIndex],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Info()
                ),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: themeProvider.useCustomTheme
        ? themeProvider.bottomNavigationColor
        : Theme.of(context).bottomNavigationBarTheme.backgroundColor ?? Theme.of(context).canvasColor,
        selectedItemColor: themeProvider.useCustomTheme
        ? (themeProvider.isColorDark(themeProvider.bottomNavigationColor) ? Colors.white : Colors.black)
        : Theme.of(context).colorScheme.primary,
        unselectedItemColor: themeProvider.useCustomTheme
        ? (themeProvider.isColorDark(themeProvider.bottomNavigationColor) ? Colors.white70 : Colors.black54)
        : Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded), 
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