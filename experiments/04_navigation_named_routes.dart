import 'package:flutter/material.dart';

// Experiment 4: Navigation and Named Routes
// Implements Flutter navigation using Navigator.pushNamed(), named route
// constants, and stack popping across Dashboard (/), Courses (/courses),
// Attendance Tracker (/attendance), and GPA Calculator (/gpa) screens.

void main() {
  runApp(const StudentNavigationApp());
}

class StudentNavigationApp extends StatelessWidget {
  const StudentNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 4 - Navigation & Routes',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardNav(),
        '/courses': (context) => const CoursesNav(),
        '/attendance': (context) => const AttendanceNav(),
        '/gpa': (context) => const GpaNav(),
      },
    );
  }
}

class DashboardNav extends StatelessWidget {
  const DashboardNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard (Exp 4)'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 60, color: Color(0xFF10B981)),
            const SizedBox(height: 20),
            const Text('Student Companion', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            const Text('Navigate to different modules', style: TextStyle(color: Color(0xFF94A3B8))),
            const SizedBox(height: 30),
            _navButton(context, Icons.book, 'View Enrolled Courses', '/courses', const Color(0xFF6366F1)),
            const SizedBox(height: 12),
            _navButton(context, Icons.how_to_reg, 'Attendance Tracker', '/attendance', const Color(0xFF10B981)),
            const SizedBox(height: 12),
            _navButton(context, Icons.calculate, 'GPA / CGPA Calculator', '/gpa', const Color(0xFFF59E0B)),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, IconData icon, String label, String route, Color color) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class CoursesNav extends StatelessWidget {
  const CoursesNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enrolled Courses'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.book, color: Color(0xFF6366F1)), title: Text('CS301 - Data Structures'), subtitle: Text('Dr. Alan Turing • 4 Credits')),
          ListTile(leading: Icon(Icons.book, color: Color(0xFF6366F1)), title: Text('CS302 - Mobile App Dev'), subtitle: Text('Prof. Ada Lovelace • 4 Credits')),
          ListTile(leading: Icon(Icons.book, color: Color(0xFF6366F1)), title: Text('CS303 - Database Systems'), subtitle: Text('Dr. Edgar Codd • 3 Credits')),
          ListTile(leading: Icon(Icons.book, color: Color(0xFF6366F1)), title: Text('CS304 - Computer Networks'), subtitle: Text('Prof. Vint Cerf • 3 Credits')),
        ],
      ),
    );
  }
}

class AttendanceNav extends StatelessWidget {
  const AttendanceNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Tracker'), backgroundColor: Colors.transparent),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.how_to_reg, size: 48, color: Color(0xFF10B981)),
            SizedBox(height: 12),
            Text('Overall Attendance: 88.8%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Text('Status: Above 75% threshold ✓', style: TextStyle(color: Color(0xFF10B981))),
          ],
        ),
      ),
    );
  }
}

class GpaNav extends StatelessWidget {
  const GpaNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPA Calculator'), backgroundColor: Colors.transparent),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate, size: 48, color: Color(0xFFF59E0B)),
            SizedBox(height: 12),
            Text('Projected SGPA: 3.75', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Text('Total Credits: 17 Cr', style: TextStyle(color: Color(0xFF94A3B8))),
          ],
        ),
      ),
    );
  }
}
