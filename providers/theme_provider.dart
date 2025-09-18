import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = AppTheme.light();

  ThemeData get theme => _theme;

  void setLight() {
    _theme = AppTheme.light();
    notifyListeners();
  }
}


