import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_companion_controller.dart';
import '../utils/constants.dart';
import '../widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StudentCompanionController>();
    final overallPct = controller.overallAttendancePercentage;
    final isOverallSafe = overallPct >= 75.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall Attendance Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isOverallSafe
                    ? [const Color(0xFF064E3B), const Color(0xFF1E293B)]
                    : [const Color(0xFF7F1D1D), const Color(0xFF1E293B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isOverallSafe ? AppColors.primary : AppColors.danger,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cumulative Attendance',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$overallPct%',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isOverallSafe
                            ? 'Great job! You satisfy the mandatory 75% attendance rule.'
                            : 'Warning! Attendance is below the mandatory 75% threshold.',
                        style: TextStyle(
                          fontSize: 12,
                          color: isOverallSafe ? AppColors.primaryLight : AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (isOverallSafe ? AppColors.primary : AppColors.danger).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isOverallSafe ? Icons.check_circle : Icons.warning_amber,
                    color: isOverallSafe ? AppColors.primary : AppColors.danger,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Subject Breakdown & Loggers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...controller.courses.map(
            (c) => AttendanceCard(
              course: c,
              onLogAttended: () => controller.logAttendance(c.id, attended: true),
              onLogMissed: () => controller.logAttendance(c.id, attended: false),
            ),
          ),
        ],
      ),
    );
  }
}
