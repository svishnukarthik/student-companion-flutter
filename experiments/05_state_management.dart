import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Experiment 5b: Reactive state management using Provider
// Contrasts local state (setState) against decoupled reactive state
// management (Provider with ChangeNotifier) for GPA and attendance tracking.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentStateProvider(),
      child: const StudentProviderApp(),
    ),
  );
}

class StudentProviderApp extends StatelessWidget {
  const StudentProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 5b - Provider State Management',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const StudentProviderScreen(),
    );
  }
}

class StudentStateProvider extends ChangeNotifier {
  int _attended = 30;
  int _total = 35;
  double _cgpa = 3.75;

  int get attended => _attended;
  int get total => _total;
  double get percentage => _total == 0 ? 100.0 : (_attended / _total) * 100.0;
  double get cgpa => _cgpa;

  void logPresent() {
    _attended++;
    _total++;
    notifyListeners();
  }

  void logAbsent() {
    _total++;
    notifyListeners();
  }

  void updateCgpa(double newCgpa) {
    _cgpa = newCgpa;
    notifyListeners();
  }
}

class StudentProviderScreen extends StatelessWidget {
  const StudentProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentStateProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider State (Exp 5b)'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Attendance (Provider)', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
            const SizedBox(height: 6),
            Text('${state.percentage.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
            Text('${state.attended}/${state.total} classes',
                style: const TextStyle(color: Color(0xFF94A3B8))),
            const SizedBox(height: 20),
            const Text('CGPA (Provider)', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
            Text(state.cgpa.toStringAsFixed(2),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => state.logPresent(),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                  child: const Text('Present', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => state.logAbsent(),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
                  child: const Text('Absent', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
