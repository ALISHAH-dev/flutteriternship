import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_form_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('user_tasks');
    if (data != null) {
      setState(() {
        _tasks.clear();
        _tasks.addAll(List<Map<String, dynamic>>.from(json.decode(data)));
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_tasks', json.encode(_tasks));
  }

  Future<void> _openTaskForm({Map<String, dynamic>? task, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task, index: index),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (index != null) {
          _tasks[index] = result;
        } else {
          _tasks.insert(0, result);
        }
      });
      _saveTasks();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _tasks[index]['isFavorite'] = !(_tasks[index]['isFavorite'] ?? false);
    });
    _saveTasks();
  }

  void _toggleComplete(int index) {
    setState(() {
      _tasks[index]['isDone'] = !(_tasks[index]['isDone'] ?? false);
    });
    _saveTasks();
  }

  String _formatDateTime(String? isoDate) {
    if (isoDate == null) return "";
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('dd MMM h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTasks = _tasks.where((task) {
      return task['title']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("My Tasks", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    hintText: "Search tasks...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredTasks.isEmpty
                  ? const Center(child: Text("No tasks yet", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        final actualIndex = _tasks.indexOf(task);
                        final baseColor = task['color'] != null
                            ? Color(task['color'])
                            : Colors.blueAccent;
                        final bool isFavorite = task['isFavorite'] ?? false;
                        final bool isDone = task['isDone'] ?? false;

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            // Made the border much brighter and thicker
                            border: Border.all(color: baseColor, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: baseColor.withAlpha(40),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            leading: Checkbox(
                              value: isDone,
                              activeColor: baseColor,
                              onChanged: (_) => _toggleComplete(actualIndex),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                decoration: isDone ? TextDecoration.lineThrough : null,
                                color: isDone ? Colors.grey : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              _formatDateTime(task['createdAt']),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                                    color: isFavorite ? Colors.orange : Colors.grey,
                                  ),
                                  onPressed: () => _toggleFavorite(actualIndex),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                  onPressed: () => _deleteTask(actualIndex),
                                ),
                              ],
                            ),
                            onTap: () => _openTaskForm(task: task, index: actualIndex),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskForm(),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 35),
      ),
    );
  }
}
