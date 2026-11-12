import 'package:flutter/material.dart';

/// App color palette and theme constants for Student Companion
class AppColors {
  static const Color background = Color(0xFF0F172A); // Deep Slate
  static const Color surface = Color(0xFF1E293B);    // Slate Dark
  static const Color card = Color(0xFF243248);       // Card Surface
  static const Color primary = Color(0xFF10B981);    // Emerald Accent
  static const Color primaryLight = Color(0xFF34D399);
  static const Color secondary = Color(0xFF6366F1);  // Indigo
  static const Color accent = Color(0xFFF59E0B);     // Amber Warning
  static const Color danger = Color(0xFFEF4444);     // Coral Danger
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color border = Color(0xFF334155);
}

/// Priority levels for tasks and assignments
enum TaskPriority { high, medium, low }

/// Attendance status evaluation
enum AttendanceStatus { safe, warning, critical }
