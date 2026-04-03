import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_form_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> _notes = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('user_notes');
    if (data != null) {
      setState(() {
        _notes.clear();
        _notes.addAll(List<Map<String, dynamic>>.from(json.decode(data)));
      });
    }
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_notes', json.encode(_notes));
  }

  Future<void> _openNoteForm({Map<String, dynamic>? note, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: note, index: index),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (index != null) {
          _notes[index] = result;
        } else {
          _notes.insert(0, result);
        }
      });
      _saveNotes();
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _saveNotes();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _notes[index]['isFavorite'] = !(_notes[index]['isFavorite'] ?? false);
    });
    _saveNotes();
  }

  String _formatDateTime(String? isoDate) {
    if (isoDate == null) return "";
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('dd MMM h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotes = _notes.where((note) {
      return note['title']
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
        title: const Text("My Notes", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    hintText: "Search notes...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredNotes.isEmpty
                  ? const Center(child: Text("No notes yet", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        final actualIndex = _notes.indexOf(note);
                        final baseColor = note['color'] != null
                            ? Color(note['color'])
                            : const Color(0xFFF06292);
                        final bool isFavorite = note['isFavorite'] ?? false;

                        return GestureDetector(
                          onTap: () => _openNoteForm(note: note, index: actualIndex),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: baseColor.withAlpha(76),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDateTime(note['createdAt']),
                                        style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 13),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => _toggleFavorite(actualIndex),
                                            child: Icon(
                                              isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                                              color: Colors.white,
                                              size: 26,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          GestureDetector(
                                            onTap: () => _deleteNote(actualIndex),
                                            child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    note['title'],
                                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    note['description'] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteForm(),
        backgroundColor: const Color(0xFFF06292),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 35),
      ),
    );
  }
}
