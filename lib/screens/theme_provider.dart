import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _useCustomTheme = false;
  bool _showAlerts = true;
  Color _appBarColor = Colors.amber;
  Color _bottomNavigationColor = Colors.white;
  Color _backgroundColor = Colors.white;
  Color _cardColor = Colors.white;

  bool get isDarkMode => _isDarkMode;
  bool get useCustomTheme => _useCustomTheme;
  bool get showAlerts => _showAlerts;
  Color get appBarColor => _appBarColor;
  Color get bottomNavigationColor => _bottomNavigationColor;
  Color get backgroundColor => _backgroundColor;
  Color get cardColor => _cardColor;

  final SharedPreferences prefs;

  static final List<Color> appBarColors = [
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.white,
  ];

  static final List<Color> componentColors = [
    Colors.red[400]!,
    Colors.amber[400]!,
    Colors.blue[400]!,
    Colors.green[400]!,
    Colors.purple[400]!,
    Colors.white,
  ];

  static final List<Color> backgroundColors = [
    Colors.red[100]!,
    Colors.yellow[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.purple[100]!,
    Colors.white,
  ];

  Color _matchDropdownColor(Color color, List<Color> options) {
    return options.firstWhere(
      (c) => c.value == color.value,
      orElse: () => options.first,
    );
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _useCustomTheme = prefs.getBool('useCustomTheme') ?? false;
    _showAlerts = prefs.getBool('showAlerts') ?? true;

    _appBarColor = _matchDropdownColor(
      Color(prefs.getInt('appBarColor') ?? Colors.amber.value),
      appBarColors,
    );
    
    _bottomNavigationColor = _matchDropdownColor(
      Color(prefs.getInt('bottomNavigationColor') ?? Colors.white.value),
      componentColors,
    );
    
    _backgroundColor = _matchDropdownColor(
      Color(prefs.getInt('backgroundColor') ?? Colors.white.value),
      backgroundColors,
    );
    
    _cardColor = _matchDropdownColor(
      Color(prefs.getInt('cardColor') ?? Colors.white.value),
      backgroundColors,
    );

    notifyListeners();
  }

  ThemeProvider(this.prefs) {
    _loadSettings();
  }
  
  void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    _useCustomTheme = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void toggleCustomTheme(bool value) async {
    _useCustomTheme = value;
    if (value) _isDarkMode = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('useCustomTheme', _useCustomTheme);
    notifyListeners();
  }

  void toggleAlerts(bool value) async {
    _showAlerts = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showAlerts', _showAlerts);
    notifyListeners();
  }

  void setAppBarColor(Color color) async {
    _appBarColor = color;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('appBarColor', color.value);
    notifyListeners();
  }

  void setBottomNavigationColor(Color color) async {
    _bottomNavigationColor = color;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('bottomNavigationColor', color.value);
    notifyListeners();
  }

  bool isColorDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  void setBackgroundColor(Color color) async {
    _backgroundColor = color;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('backgroundColor', color.value);
    notifyListeners();
  }

  void setCardColor(Color color) async {
    _cardColor = color;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cardColor', color.value);
    notifyListeners();
  }
}