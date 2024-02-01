import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: primaryDark,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: icons
  );

}