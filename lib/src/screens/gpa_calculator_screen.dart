import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../controllers/student_companion_controller.dart';

class GpaCalculatorScreen extends StatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  State<GpaCalculatorScreen> createState() => _GpaCalculatorScreenState();
}

class CourseGpaEntry {
  final TextEditingController nameCtrl;
  final TextEditingController creditsCtrl;
  String grade;

  CourseGpaEntry({
    required String name,
    required String credits,
    this.grade = 'A',
  })  : nameCtrl = TextEditingController(text: name),
        creditsCtrl = TextEditingController(text: credits);

  void dispose() {
    nameCtrl.dispose();
    creditsCtrl.dispose();
  }
}

class _GpaCalculatorScreenState extends State<GpaCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<CourseGpaEntry> _entries = [
    CourseGpaEntry(name: 'Data Structures', credits: '4', grade: 'A'),
    CourseGpaEntry(name: 'Mobile App Dev', credits: '4', grade: 'A-'),
    CourseGpaEntry(name: 'Database Systems', credits: '3', grade: 'B+'),
    CourseGpaEntry(name: 'Computer Networks', credits: '3', grade: 'A'),
  ];

  double? _calculatedGpa;
  int? _calculatedCredits;

  static const Map<String, double> gradeScale = {
    'A': 4.0,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2.0,
    'D': 1.0,
    'F': 0.0,
  };

  @override
  void dispose() {
    for (final e in _entries) {
      e.dispose();
    }
    super.dispose();
  }

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      final gradePoints = <double>[];
      final credits = <int>[];

      for (final e in _entries) {
        final cr = int.tryParse(e.creditsCtrl.text.trim()) ?? 0;
        final gp = gradeScale[e.grade] ?? 0.0;
        gradePoints.add(gp);
        credits.add(cr);
      }

      setState(() {
        _calculatedGpa = StudentCompanionController.calculateGpa(gradePoints, credits);
        _calculatedCredits = credits.fold<int>(0, (prev, elem) => prev + elem);
      });
    }
  }

  void _addEntry() {
    setState(() {
      _entries.add(CourseGpaEntry(name: 'Elective ${_entries.length + 1}', credits: '3', grade: 'A'));
    });
  }

  void _removeEntry(int index) {
    if (_entries.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one course is required for GPA calculation.')),
      );
      return;
    }
    setState(() {
      _entries[index].dispose();
      _entries.removeAt(index);
      _calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('GPA / CGPA Calculator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Result Showcase
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Projected SGPA',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _calculatedGpa != null ? _calculatedGpa!.toStringAsFixed(2) : '--',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 40, width: 1, color: AppColors.border),
                  Column(
                    children: [
                      const Text(
                        'Total Credit Hours',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _calculatedCredits != null ? '$_calculatedCredits Cr' : '--',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Courses & Credit Weights',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addEntry,
                  icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 18),
                  label: const Text('Add Course', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ...List.generate(_entries.length, (index) {
              final entry = _entries[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: entry.nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: entry.creditsCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Credits',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          final n = int.tryParse(v ?? '');
                          if (n == null || n < 1 || n > 12) return '1-12';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: entry.grade,
                        decoration: const InputDecoration(
                          labelText: 'Grade',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        dropdownColor: AppColors.surface,
                        items: gradeScale.keys
                            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => entry.grade = val);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: AppColors.danger, size: 20),
                      onPressed: () => _removeEntry(index),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: const Text(
                  'Calculate Semester GPA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
