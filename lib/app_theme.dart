import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 3.0,
        ),
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle().copyWith(
            color: Colors.white,
          ),
          // for text
          titleSmall: const TextStyle().copyWith(
            color: Colors.white,
          ),
          titleLarge: const TextStyle().copyWith(
            color: Colors.white,
          ),
          titleMedium: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 16.0,
          ),
          // for list tile title
          displayLarge: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          displaySmall: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          displayMedium: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          headlineLarge: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          headlineMedium: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          headlineSmall: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          bodyLarge: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
          bodySmall: const TextStyle().copyWith(
            color: Colors.blueGrey.shade200,
            fontSize: 12.0,
          ), // for list tile subtitle
        ),
      );
}
