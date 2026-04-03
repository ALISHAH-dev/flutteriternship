import 'package:basicproject/dashboard_screen.dart';
import 'package:basicproject/notes_screen.dart';
import 'package:basicproject/task_form_screen.dart';
import 'package:basicproject/todo_screen.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      home: const  DashboardScreen()
    );
  }
}
