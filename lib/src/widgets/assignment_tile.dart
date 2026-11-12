import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../utils/constants.dart';

/// Reusable assignment and task item tile with priority tags and completion checkbox
class AssignmentTile extends StatelessWidget {
  final Assignment assignment;
  final ValueChanged<bool?>? onToggle;

  const AssignmentTile({
    super.key,
    required this.assignment,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    String priorityText;
    switch (assignment.priority) {
      case TaskPriority.high:
        priorityColor = AppColors.danger;
        priorityText = 'High Priority';
        break;
      case TaskPriority.medium:
        priorityColor = AppColors.accent;
        priorityText = 'Medium';
        break;
      case TaskPriority.low:
        priorityColor = AppColors.primary;
        priorityText = 'Low';
        break;
    }

    final daysRemaining = assignment.dueDate.difference(DateTime.now()).inDays;
    final dueText = daysRemaining < 0
        ? 'Overdue'
        : (daysRemaining == 0 ? 'Due Today' : 'Due in $daysRemaining days');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: assignment.isCompleted ? AppColors.border.withOpacity(0.5) : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: assignment.isCompleted,
            onChanged: onToggle,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: assignment.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                    decoration: assignment.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      assignment.courseCode,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•  $dueText',
                      style: TextStyle(
                        fontSize: 11,
                        color: daysRemaining <= 2 ? AppColors.accent : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              priorityText,
              style: TextStyle(
                color: priorityColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
