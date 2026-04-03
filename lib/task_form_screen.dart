import 'package:flutter/material.dart';

class TaskFormScreen extends StatefulWidget {
  final Map<String, dynamic>? task;
  final int? index;

  const TaskFormScreen({super.key, this.task, this.index});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Color _selectedColor;

  final List<Color> _colors = [
    const Color(0xFFF06292),
    const Color(0xFF9575CD),
    const Color(0xFF5C6BC0),
    const Color(0xFF3949AB),
    const Color(0xFF263238),
    const Color(0xFF4FC3F7),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?['title'] ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?['description'] ?? '',
    );
    _selectedColor = widget.task?['color'] != null
        ? Color(widget.task!['color'])
        : _colors[0];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty) return;

    Navigator.pop(context, {
      'title': title,
      'description': description,
      'isDone': widget.task?['isDone'] ?? false,
      'color': _selectedColor.value,
      'createdAt':
          widget.task?['createdAt'] ?? DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? "Edit Note" : "New Note",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "TITLE",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              style: TextStyle(
                color: _selectedColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Meeting...",
                hintStyle: TextStyle(color: Colors.black12),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "DESCRIPTION",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Details about your note...",
                hintStyle: TextStyle(color: Colors.black12),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "CARD COLOR",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _colors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final color = _colors[index];
                  final isSelected = _selectedColor.value == color.value;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.black87, width: 2)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: _selectedColor.withOpacity(0.5),
                ),
                child: Text(
                  isEditing ? "SAVE CHANGES" : "SAVE NOTE",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
