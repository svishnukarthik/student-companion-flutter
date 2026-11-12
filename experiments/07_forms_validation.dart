import 'package:flutter/material.dart';

// Experiment 7: Forms, Validation and Error Handling
// Designs a GPA formula evaluator utilizing Form, GlobalKey<FormState>,
// TextFormField, dropdown grade selector, and SnackBar alerts to validate
// credit inputs and intercept invalid operations.

void main() {
  runApp(const GpaFormApp());
}

class GpaFormApp extends StatelessWidget {
  const GpaFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 7 - Forms & Validation',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const GpaFormScreen(),
    );
  }
}

class GpaFormScreen extends StatefulWidget {
  const GpaFormScreen({super.key});

  @override
  State<GpaFormScreen> createState() => _GpaFormScreenState();
}

class _GpaFormScreenState extends State<GpaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameCtrl = TextEditingController();
  final _creditsCtrl = TextEditingController();
  String _selectedGrade = 'A';
  String? _result;

  static const gradeScale = {
    'A': 4.0, 'A-': 3.7, 'B+': 3.3, 'B': 3.0,
    'B-': 2.7, 'C+': 2.3, 'C': 2.0, 'F': 0.0,
  };

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      final credits = int.parse(_creditsCtrl.text.trim());
      final gradePoint = gradeScale[_selectedGrade]!;

      if (credits == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Credits cannot be zero for GPA calculation.'),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
        return;
      }

      final qualityPoints = gradePoint * credits;
      setState(() {
        _result = '${_courseNameCtrl.text.trim()} → Grade $_selectedGrade (${gradePoint.toStringAsFixed(1)}) × $credits Cr = ${qualityPoints.toStringAsFixed(1)} quality points';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Calculated: ${qualityPoints.toStringAsFixed(1)} quality points'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }

  @override
  void dispose() {
    _courseNameCtrl.dispose();
    _creditsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Form Validator (Exp 7)'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _courseNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Course name is required';
                  if (val.trim().length < 2) return 'Minimum 2 characters';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _creditsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Credit Hours (1-6)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Credits required';
                  final n = int.tryParse(val.trim());
                  if (n == null) return 'Must be a number';
                  if (n < 1 || n > 6) return 'Credits must be between 1 and 6';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                decoration: const InputDecoration(
                  labelText: 'Grade Earned',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
                dropdownColor: const Color(0xFF1E293B),
                items: gradeScale.keys.map((g) => DropdownMenuItem(value: g, child: Text('$g (${gradeScale[g]})'))).toList(),
                onChanged: (val) => setState(() => _selectedGrade = val ?? 'A'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text('Validate & Calculate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              if (_result != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF243248),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF10B981)),
                  ),
                  child: Text(_result!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
