import 'package:flutter/material.dart';

// Experiment 6: Custom Widgets and Themes
// Constructs modular, reusable custom widgets (StudentProfileHeader,
// MetricDisplayCard, CourseActionButton) styled through global ThemeData
// with an emerald #10B981 dark academia color palette.

void main() {
  runApp(const CustomWidgetsApp());
}

class CustomWidgetsApp extends StatelessWidget {
  const CustomWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 6 - Custom Widgets & Themes',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF10B981),
          secondary: Color(0xFF6366F1),
          surface: Color(0xFF1E293B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
      ),
      home: const CustomWidgetsScreen(),
    );
  }
}

class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Widgets (Exp 6)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const StudentProfileHeader(
            name: 'Alex Johnson',
            rollNumber: 'CS-2026-084',
            department: 'Computer Science & Engineering',
            semester: 6,
          ),
          const SizedBox(height: 16),
          const Row(
            children: const [
              Expanded(child: MetricDisplayCard(label: 'CGPA', value: '3.75', icon: Icons.grade, color: Color(0xFF10B981))),
              SizedBox(width: 12),
              Expanded(child: MetricDisplayCard(label: 'Attendance', value: '88.8%', icon: Icons.how_to_reg, color: Color(0xFF6366F1))),
            ],
          ),
          const SizedBox(height: 16),
          CourseActionButton(label: 'View Courses', icon: Icons.book, onPressed: () {}),
          const SizedBox(height: 10),
          CourseActionButton(label: 'Track Attendance', icon: Icons.how_to_reg, onPressed: () {}),
          const SizedBox(height: 10),
          CourseActionButton(label: 'Calculate GPA', icon: Icons.calculate, onPressed: () {}),
        ],
      ),
    );
  }
}

/// Custom reusable profile header widget
class StudentProfileHeader extends StatelessWidget {
  final String name;
  final String rollNumber;
  final String department;
  final int semester;

  const StudentProfileHeader({
    super.key,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.colorScheme.primary,
            child: Text(name.split(' ').map((w) => w[0]).join(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('$rollNumber • $department', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                Text('Semester $semester', style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom metric card
class MetricDisplayCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const MetricDisplayCard({super.key, required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF243248),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
        ],
      ),
    );
  }
}

/// Custom action button
class CourseActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CourseActionButton({super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
