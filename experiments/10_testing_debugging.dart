import 'package:flutter/material.dart';

/// Experiment 10: Testing and Debugging in Flutter
///
/// Demonstrates unit testing, widget testing, and Flutter debugging tools
/// for the Student Companion application. Automated tests are located in:
///   - test/student_companion_controller_test.dart
///   - test/widget_test.dart
///   - test/exp10_testing_debugging_test.dart

void main() => runApp(const Experiment10App());

class Experiment10App extends StatelessWidget {
  const Experiment10App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Experiment 10 - Testing & Debugging',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
        ),
        home: const Experiment10Screen(),
      );
}

class Experiment10Screen extends StatelessWidget {
  const Experiment10Screen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Testing & Debugging (Exp 10)'),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Text(
              'A. Student Companion Testing Suites',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Unit Tests (Controller Logic)'),
              subtitle: Text('Validates GPA calculation, attendance percentage, threshold computation, course CRUD, and assignment toggling in student_companion_controller_test.dart.'),
            ),
            ListTile(
              leading: Icon(Icons.touch_app, color: Colors.green),
              title: Text('Widget Tests (UI Interaction)'),
              subtitle: Text('Simulates navigation taps, checkbox toggles, and verifies dashboard metrics display in widget_test.dart.'),
            ),
            ListTile(
              leading: Icon(Icons.rule, color: Colors.green),
              title: Text('Boundary & Exception Tests'),
              subtitle: Text('Tests attendance edge cases (0%, 100%), safe-miss calculations, and status threshold boundaries.'),
            ),
            Divider(color: Color(0xFF334155)),
            SizedBox(height: 8),
            Text(
              'B. Debugging Tools & DevTools',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.bug_report, color: Color(0xFFF59E0B)),
              title: Text('Flutter Inspector'),
              subtitle: Text('Widget hierarchy, box constraints, and layout overflow analysis.'),
            ),
            ListTile(
              leading: Icon(Icons.memory, color: Color(0xFFF59E0B)),
              title: Text('DevTools Memory & CPU Profiler'),
              subtitle: Text('Frame render times, memory allocation monitoring, and leak prevention.'),
            ),
            ListTile(
              leading: Icon(Icons.terminal, color: Color(0xFFF59E0B)),
              title: Text('Console Logs & Breakpoints'),
              subtitle: Text('debugPrint() for state inspection, IDE breakpoints for step-through debugging.'),
            ),
            Divider(color: Color(0xFF334155)),
            SizedBox(height: 8),
            Text(
              'C. Verification Results',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.verified, color: Color(0xFF10B981)),
              title: Text('flutter test: 100% Passed (20 tests)'),
              subtitle: Text('All unit tests and widget tests pass successfully.'),
            ),
            ListTile(
              leading: Icon(Icons.verified, color: Color(0xFF10B981)),
              title: Text('flutter analyze: No issues found!'),
              subtitle: Text('Static analysis clean with zero errors and zero warnings.'),
            ),
          ],
        ),
      );
}
