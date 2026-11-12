import 'package:flutter/material.dart';

// Experiment 2: Explore Flutter widgets and layout using Row, Column and Stack
// to build a student companion dashboard interface.

void main() {
  runApp(const StudentLayoutApp());
}

class StudentLayoutApp extends StatelessWidget {
  const StudentLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 2 - Widgets & Layouts',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const StudentLayoutScreen(),
    );
  }
}

class StudentLayoutScreen extends StatelessWidget {
  const StudentLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard Layouts (Exp 2)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Column arranges the profile card and metric tiles vertically.
        child: Column(
          children: [
            // Stack overlays a semester badge and student info over the profile card.
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alex Johnson',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'CS-2026-084 • Computer Science & Engineering',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Target CGPA: 3.90 • Current: 3.75',
                        style: TextStyle(color: Color(0xFF10B981), fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'SEM 6',
                      style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Row arranges stat cards horizontally for quick metrics overview.
            Row(
              children: [
                Expanded(
                  child: _buildStatTile('CGPA', '3.75', Icons.grade, const Color(0xFF10B981)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatTile('Attendance', '88.8%', Icons.how_to_reg, const Color(0xFF6366F1)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatTile('Pending', '3', Icons.assignment_late, const Color(0xFFF59E0B)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Column with course listing items
            Expanded(
              child: ListView(
                children: [
                  _buildCourseTile('CS301', 'Data Structures & Algorithms', 'Dr. Alan Turing', '90.0%'),
                  _buildCourseTile('CS302', 'Mobile Application Development', 'Prof. Ada Lovelace', '89.5%'),
                  _buildCourseTile('CS303', 'Database Management Systems', 'Dr. Edgar Codd', '90.0%'),
                  _buildCourseTile('CS304', 'Computer Networks', 'Prof. Vint Cerf', '87.5%'),
                  _buildCourseTile('CS305', 'Software Engineering', 'Dr. Margaret Hamilton', '86.7%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatTile(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF243248),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
        ],
      ),
    );
  }

  static Widget _buildCourseTile(String code, String name, String instructor, String attendance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF243248),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(code, style: const TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                Text(instructor, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
              ],
            ),
          ),
          Text(attendance, style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
