import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.pinkAccent,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0.4,
  ),
);

ThemeData darkTheme = ThemeData.dark();

ThemeData darkBlueTheme = darkTheme.copyWith(
  primaryColor: Color(0xFF1E1E2C),
  scaffoldBackgroundColor: Color(0xFF2D2D44),
);
