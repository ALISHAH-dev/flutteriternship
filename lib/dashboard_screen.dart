import 'package:flutter/material.dart';
import 'todo_screen.dart';
import 'notes_screen.dart';
import 'counter_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Tasky",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                "What would you like to manage?",
                style: TextStyle(color: Colors.white38, fontSize: 16),
              ),
              const SizedBox(height: 50),
              _buildCategoryCard(
                context,
                title: "Tasks",
                subtitle: "Track your goals & to-dos",
                icon: Icons.check_circle_outline_rounded,
                color: Colors.blueAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodoScreen()),
                ),
              ),
              const SizedBox(height: 24),
              _buildCategoryCard(
                context,
                title: "Notes",
                subtitle: "Capture your thoughts",
                icon: Icons.notes_rounded,
                color: const Color(0xFFF06292),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesScreen()),
                ),
              ),
              const SizedBox(height: 24),
              _buildCategoryCard(
                context,
                title: "Counter",
                subtitle: "Quick tally tracker",
                icon: Icons.add_circle_outline_rounded,
                color: Colors.greenAccent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF0D1B2A), const Color(0xFF1B263B)],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white24,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
