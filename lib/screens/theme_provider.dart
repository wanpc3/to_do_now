import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _useCustomTheme = false;
  bool _showAlerts = true;
  Color _appBarColor = Colors.blue;
  Color _backgroundColor = Colors.white;
  Color _cardColor = Colors.white;

  bool get isDarkMode => _isDarkMode;
  bool get useCustomTheme => _useCustomTheme;
  bool get showAlerts => _showAlerts;
  Color get appBarColor => _appBarColor;
  Color get backgroundColor => _backgroundColor;
  Color get cardColor => _cardColor;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    _useCustomTheme = false;
    notifyListeners();
  }

  //Custom Theme
  void toggleCustomTheme(bool value) {
    _useCustomTheme = value;
    if (value) {
      _isDarkMode = false;
    }
    notifyListeners();
  }

  //App Bar's Color
  void setAppBarColor(Color color) {
    _appBarColor = color;
    notifyListeners();
  }

  //Background's Color
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  //Card's Color
  void setCardColor(Color color) {
    _cardColor = color;
    notifyListeners();
  }

  //Enable/Disable Alerts
  void toggleAlerts(bool value) {
    _showAlerts = value;
    notifyListeners();
  }
}