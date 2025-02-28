import 'package:flutter/material.dart';

import '../constants/constant_string.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: ConstantString.fontMontserrat,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontFamily: ConstantString.fontMontserrat,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontFamily: ConstantString.fontLato,
        fontSize: 16,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontFamily: ConstantString.fontLato,
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}
