import '../utils/constants.dart';

/// Represents an enrolled course in the student's curriculum
class Course {
  final String id;
  final String code;
  final String name;
  final String instructor;
  final int credits;
  final String grade;
  final double gradePoint;
  final int attendedClasses;
  final int totalClasses;

  const Course({
    required this.id,
    required this.code,
    required this.name,
    required this.instructor,
    required this.credits,
    required this.grade,
    required this.gradePoint,
    required this.attendedClasses,
    required this.totalClasses,
  });

  double get attendancePercentage {
    if (totalClasses == 0) return 100.0;
    return (attendedClasses / totalClasses) * 100.0;
  }

  AttendanceStatus get status {
    final pct = attendancePercentage;
    if (pct >= 85.0) return AttendanceStatus.safe;
    if (pct >= 75.0) return AttendanceStatus.warning;
    return AttendanceStatus.critical;
  }

  Course copyWith({
    String? id,
    String? code,
    String? name,
    String? instructor,
    int? credits,
    String? grade,
    double? gradePoint,
    int? attendedClasses,
    int? totalClasses,
  }) {
    return Course(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      instructor: instructor ?? this.instructor,
      credits: credits ?? this.credits,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
      attendedClasses: attendedClasses ?? this.attendedClasses,
      totalClasses: totalClasses ?? this.totalClasses,
    );
  }
}

/// Represents an assignment or study task
class Assignment {
  final String id;
  final String title;
  final String courseCode;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;



  Assignment copyWith({
    String? id,
    String? title,
    String? courseCode,
    DateTime? dueDate,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      courseCode: courseCode ?? this.courseCode,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Represents the student's profile information
class StudentProfile {
  final String name;
  final String rollNumber;
  final String department;
  final int semester;
  final double targetCgpa;
  const Assignment({
    required this.id,
    required this.title,
    required this.courseCode,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
  const StudentProfile({
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.semester,
    required this.targetCgpa,
  });
}
