import 'package:flutter/material.dart';

// Experiment 5a: Stateful widget with setState()
// Local state attendance counter demonstrating StatefulWidget lifecycle
// and setState() for real-time attendance logging.

void main() {
  runApp(const AttendanceCounterApp());
}

class AttendanceCounterApp extends StatelessWidget {
  const AttendanceCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 5a - setState Counter',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const AttendanceCounterScreen(),
    );
  }
}

class AttendanceCounterScreen extends StatefulWidget {
  const AttendanceCounterScreen({super.key});

  @override
  State<AttendanceCounterScreen> createState() => _AttendanceCounterScreenState();
}

class _AttendanceCounterScreenState extends State<AttendanceCounterScreen> {
  int _attended = 0;
  int _total = 0;

  double get _percentage => _total == 0 ? 100.0 : (_attended / _total) * 100.0;

  void _markPresent() {
    setState(() {
      _attended++;
      _total++;
    });
  }

  void _markAbsent() {
    setState(() {
      _total++;
    });
  }

  void _reset() {
    setState(() {
      _attended = 0;
      _total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Counter (setState)'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.how_to_reg, size: 48, color: Color(0xFF10B981)),
            const SizedBox(height: 16),
            Text(
              '${_percentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text('$_attended / $_total classes', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 16)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _markPresent,
                  icon: const Icon(Icons.check),
                  label: const Text('Present'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.black),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _markAbsent,
                  icon: const Icon(Icons.close),
                  label: const Text('Absent'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), foregroundColor: Colors.white),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh, color: Color(0xFF94A3B8)),
                  label: const Text('Reset', style: TextStyle(color: Color(0xFF94A3B8))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
