import 'package:flutter/material.dart';

class SortProvider with ChangeNotifier {
  String _sortMode = 'Recently Added';

  String get sortMode => _sortMode;

  void setSortMode(String mode) {
    _sortMode = mode;
    notifyListeners();
  }
}