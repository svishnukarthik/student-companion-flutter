import 'package:flutter/material.dart';

// Experiment 3: Responsive UI using MediaQuery
// Uses MediaQuery and adaptive breakpoints (600px tablet, 900px desktop) to
// dynamically transform the student companion layout from a single-column mobile
// view into an expanded desktop view with a side-by-side course detail panel.

void main() {
  runApp(const ResponsiveStudentApp());
}

class ResponsiveStudentApp extends StatelessWidget {
  const ResponsiveStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 3 - Responsive UI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const ResponsiveStudentScreen(),
    );
  }
}

class ResponsiveStudentScreen extends StatelessWidget {
  const ResponsiveStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Student Dashboard (${isDesktop ? "Desktop" : isTablet ? "Tablet" : "Mobile"})'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isDesktop ? 24 : 16),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildMainPanel()),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: _buildSidePanel()),
                ],
              )
            : _buildMainPanel(),
      ),
    );
  }

  Widget _buildMainPanel() {
    return ListView(
      children: [
        const Text(
          'Quick Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _statCard('CGPA', '3.75', Icons.grade, const Color(0xFF10B981)),
            _statCard('Attendance', '88.8%', Icons.how_to_reg, const Color(0xFF6366F1)),
            _statCard('Pending', '3 Tasks', Icons.assignment_late, const Color(0xFFF59E0B)),
            _statCard('Credits', '17 Cr', Icons.collections_bookmark, const Color(0xFF8B5CF6)),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Enrolled Courses',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        _courseTile('CS301', 'Data Structures & Algorithms', 'Dr. Alan Turing', 90.0),
        _courseTile('CS302', 'Mobile Application Development', 'Prof. Ada Lovelace', 89.5),
        _courseTile('CS303', 'Database Management Systems', 'Dr. Edgar Codd', 90.0),
        _courseTile('CS304', 'Computer Networks', 'Prof. Vint Cerf', 87.5),
        _courseTile('CS305', 'Software Engineering', 'Dr. Margaret Hamilton', 86.7),
      ],
    );
  }

  Widget _buildSidePanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: ListView(
        children: const [
          Text(
            'Upcoming Deadlines',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
          ),
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.assignment, color: Color(0xFFEF4444)),
            title: Text('Flutter UI Lab', style: TextStyle(color: Colors.white)),
            subtitle: Text('CS302 • Due in 2 days', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Color(0xFFF59E0B)),
            title: Text('B-Tree Implementation', style: TextStyle(color: Colors.white)),
            subtitle: Text('CS301 • Due in 5 days', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Color(0xFF10B981)),
            title: Text('TCP Socket Programming', style: TextStyle(color: Colors.white)),
            subtitle: Text('CS304 • Due in 9 days', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          Divider(color: Color(0xFF334155)),
          SizedBox(height: 10),
          Text(
            'Study Tips',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6366F1)),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.access_time_filled, color: Color(0xFF10B981)),
            title: Text('Spaced Repetition', style: TextStyle(color: Colors.white)),
            subtitle: Text('Review at 1-day, 3-day, 7-day intervals', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF243248),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _courseTile(String code, String name, String instructor, double pct) {
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
          Text('${pct.toStringAsFixed(1)}%',
              style: TextStyle(color: pct >= 75 ? const Color(0xFF10B981) : const Color(0xFFEF4444), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
