import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_companion_controller.dart';
import '../models/student_model.dart';
import '../utils/constants.dart';
import '../widgets/course_card.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  void _showAddCourseDialog(BuildContext context) {
    final codeCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final instructorCtrl = TextEditingController();
    final creditsCtrl = TextEditingController(text: '3');
    String selectedGrade = 'A';
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enroll New Course',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: codeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Course Code (e.g. CS306)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.tag),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter code' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: creditsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Credits (1-6)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (val) {
                        final n = int.tryParse(val ?? '');
                        if (n == null || n < 1 || n > 6) return '1 - 6';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedGrade,
                      decoration: const InputDecoration(
                        labelText: 'Grade',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.grade),
                      ),
                      dropdownColor: AppColors.surface,
                      items: ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'F']
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (val) => selectedGrade = val ?? 'A',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: instructorCtrl,
                decoration: const InputDecoration(
                  labelText: 'Instructor Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter instructor' : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final gradePointsMap = {
                        'A': 4.0,
                        'A-': 3.7,
                        'B+': 3.3,
                        'B': 3.0,
                        'B-': 2.7,
                        'C+': 2.3,
                        'C': 2.0,
                        'F': 0.0,
                      };
                      final newCourse = Course(
                        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
                        code: codeCtrl.text.trim().toUpperCase(),
                        name: nameCtrl.text.trim(),
                        instructor: instructorCtrl.text.trim(),
                        credits: int.parse(creditsCtrl.text.trim()),
                        grade: selectedGrade,
                        gradePoint: gradePointsMap[selectedGrade] ?? 4.0,
                        attendedClasses: 10,
                        totalClasses: 10,
                      );
                      ctx.read<StudentCompanionController>().addCourse(newCourse);
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Course ${newCourse.code} enrolled successfully!')),
                      );
                    }
                  },
                  child: const Text('Add Course', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudentCompanionController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Enrolled Courses'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCourseDialog(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Add Course', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: controller.courses.isEmpty
          ? const Center(
              child: Text(
                'No courses enrolled yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 80),
              itemCount: controller.courses.length,
              itemBuilder: (ctx, index) {
                final course = controller.courses[index];
                return Dismissible(
                  key: Key(course.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: AppColors.danger,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    controller.removeCourse(course.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Removed ${course.name}')),
                    );
                  },
                  child: CourseCard(course: course),
                );
              },
            ),
    );
  }
}
