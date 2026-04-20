import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const NotesShareApp());
}

class NotesShareApp extends StatelessWidget {
  const NotesShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotesShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const LoginScreen(), // App now starts at Login!
    );
  }
}