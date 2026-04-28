import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get tasks => _tasks;
  List<Map<String, dynamic>> get notes => _notes;

  TaskProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final String? taskData = prefs.getString('user_tasks');
    if (taskData != null) {
      _tasks = List<Map<String, dynamic>>.from(json.decode(taskData));
    }

    final String? noteData = prefs.getString('user_notes');
    if (noteData != null) {
      _notes = List<Map<String, dynamic>>.from(json.decode(noteData));
    }
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_tasks', json.encode(_tasks));
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_notes', json.encode(_notes));
  }

  // Task Operations
  void addTask(Map<String, dynamic> task) {
    _tasks.insert(0, task);
    _saveTasks();
    notifyListeners();
  }

  void updateTask(int index, Map<String, dynamic> task) {
    _tasks[index] = task;
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskFavorite(int index) {
    _tasks[index]['isFavorite'] = !(_tasks[index]['isFavorite'] ?? false);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskComplete(int index) {
    _tasks[index]['isDone'] = !(_tasks[index]['isDone'] ?? false);
    _saveTasks();
    notifyListeners();
  }

  // Note Operations
  void addNote(Map<String, dynamic> note) {
    _notes.insert(0, note);
    _saveNotes();
    notifyListeners();
  }

  void updateNote(int index, Map<String, dynamic> note) {
    _notes[index] = note;
    _saveNotes();
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    _saveNotes();
    notifyListeners();
  }

  void toggleNoteFavorite(int index) {
    _notes[index]['isFavorite'] = !(_notes[index]['isFavorite'] ?? false);
    _saveNotes();
    notifyListeners();
  }
}
