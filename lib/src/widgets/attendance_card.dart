import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../utils/constants.dart';
import '../controllers/student_companion_controller.dart';

/// Card showing subject attendance progress and quick increment buttons
class AttendanceCard extends StatelessWidget {
  final Course course;
  final VoidCallback onLogAttended;
  final VoidCallback onLogMissed;

  const AttendanceCard({
    super.key,
    required this.course,
    required this.onLogAttended,
    required this.onLogMissed,
  });

  @override
  Widget build(BuildContext context) {
    final pct = course.attendancePercentage;
    final isSafe = pct >= 75.0;
    final statusColor = isSafe ? AppColors.primary : AppColors.danger;

    final neededTo75 = StudentCompanionController.classesNeededForThreshold(
      course.attendedClasses,
      course.totalClasses,
      75.0,
    );
    final safeToMiss = StudentCompanionController.safeMissableClasses(
      course.attendedClasses,
      course.totalClasses,
      75.0,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${course.code} • ${course.instructor}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  '${pct.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: course.totalClasses == 0 ? 1.0 : (course.attendedClasses / course.totalClasses),
              backgroundColor: AppColors.surface,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attended: ${course.attendedClasses} / ${course.totalClasses}',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Text(
                isSafe
                    ? (safeToMiss > 0
                        ? 'Can miss $safeToMiss more class(es)'
                        : 'On the threshold boundary')
                    : 'Must attend $neededTo75 class(es) to hit 75%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSafe ? AppColors.primaryLight : AppColors.danger,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onLogAttended,
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text('Present (+1)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onLogMissed,
                  icon: const Icon(Icons.close, size: 16, color: AppColors.danger),
                  label: const Text('Absent (+1)', style: TextStyle(color: AppColors.danger)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.danger),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
