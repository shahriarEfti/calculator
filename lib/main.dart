import 'package:calculator/screens/home_screen.dart';
import 'package:calculator/themes/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightmode,
      darkTheme: darkmode,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(onThemeChanged: toggleTheme),
    );
  }
}
