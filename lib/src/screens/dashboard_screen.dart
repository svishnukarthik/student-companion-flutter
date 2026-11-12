import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_companion_controller.dart';
import '../utils/constants.dart';
import '../widgets/stat_card.dart';
import '../widgets/course_card.dart';
import '../widgets/assignment_tile.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const DashboardScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudentCompanionController>();
    final profile = controller.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary,
              child: const Text(
                'AJ',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${profile.rollNumber} • Sem ${profile.semester}',
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All assignment notifications are up to date!')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Banner greeting
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back, Alex! 👋',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Your target CGPA is ${profile.targetCgpa.toStringAsFixed(2)}. You are on track for honors graduation.',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.school, color: AppColors.primary, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Metric Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 550;
              return GridView.count(
                crossAxisCount: isWide ? 4 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: isWide ? 1.5 : 1.15,
                children: [
                  StatCard(
                    label: 'Current CGPA',
                    value: controller.currentCgpa.toStringAsFixed(2),
                    icon: Icons.grade,
                    accentColor: AppColors.primary,
                    subtitle: 'Target: ${profile.targetCgpa}',
                  ),
                  StatCard(
                    label: 'Attendance',
                    value: '${controller.overallAttendancePercentage}%',
                    icon: Icons.how_to_reg,
                    accentColor: controller.overallAttendancePercentage >= 75.0
                        ? AppColors.primaryLight
                        : AppColors.danger,
                    subtitle: 'Req: 75% minimum',
                  ),
                  StatCard(
                    label: 'Pending Tasks',
                    value: '${controller.pendingAssignmentsCount}',
                    icon: Icons.assignment_late,
                    accentColor: AppColors.accent,
                    subtitle: '${controller.completedAssignmentsCount} completed',
                  ),
                  StatCard(
                    label: 'Total Credits',
                    value: '${controller.totalCredits}',
                    icon: Icons.collections_bookmark,
                    accentColor: AppColors.secondary,
                    subtitle: '${controller.courses.length} courses',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Enrolled Courses section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enrolled Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => onNavigateTab?.call(1),
                child: const Text('View All', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...controller.courses.take(3).map((c) => CourseCard(course: c)),

          const SizedBox(height: 16),

          // Assignments section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Deadlines',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => onNavigateTab?.call(3),
                child: const Text('GPA Calc', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...controller.assignments.map(
            (a) => AssignmentTile(
              assignment: a,
              onToggle: (_) => controller.toggleAssignment(a.id),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
