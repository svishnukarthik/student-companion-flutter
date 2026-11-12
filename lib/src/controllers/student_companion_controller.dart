import 'package:flutter/foundation.dart';
import '../models/student_model.dart';
import '../utils/constants.dart';

/// Central state controller managing courses, assignments, attendance, and GPA calculation
class StudentCompanionController extends ChangeNotifier {
  StudentProfile _profile = const StudentProfile(
    name: 'Alex Johnson',
    rollNumber: 'CS-2026-084',
    department: 'Computer Science & Engineering',
    semester: 6,
    targetCgpa: 3.90,
  );

  final List<Course> _courses = [
    const Course(
      id: 'c1',
      code: 'CS301',
      name: 'Data Structures & Algorithms',
      instructor: 'Dr. Alan Turing',
      credits: 4,
      grade: 'A',
      gradePoint: 4.0,
      attendedClasses: 36,
      totalClasses: 40,
    ),
    const Course(
      id: 'c2',
      code: 'CS302',
      name: 'Mobile Application Development',
      instructor: 'Prof. Ada Lovelace',
      credits: 4,
      grade: 'A-',
      gradePoint: 3.7,
      attendedClasses: 34,
      totalClasses: 38,
    ),
    const Course(
      id: 'c3',
      code: 'CS303',
      name: 'Database Management Systems',
      instructor: 'Dr. Edgar Codd',
      credits: 3,
      grade: 'B+',
      gradePoint: 3.3,
      attendedClasses: 27,
      totalClasses: 30,
    ),
    const Course(
      id: 'c4',
      code: 'CS304',
      name: 'Computer Networks',
      instructor: 'Prof. Vint Cerf',
      credits: 3,
      grade: 'A',
      gradePoint: 4.0,
      attendedClasses: 28,
      totalClasses: 32,
    ),
    const Course(
      id: 'c5',
      code: 'CS305',
      name: 'Software Engineering',
      instructor: 'Dr. Margaret Hamilton',
      credits: 3,
      grade: 'A-',
      gradePoint: 3.7,
      attendedClasses: 26,
      totalClasses: 30,
    ),
  ];

  final List<Assignment> _assignments = [
    Assignment(
      id: 'a1',
      title: 'Flutter UI Component Lab (Exp 2 & 3)',
      courseCode: 'CS302',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: TaskPriority.high,
      isCompleted: false,
    ),
    Assignment(
      id: 'a2',
      title: 'B-Tree & Red-Black Tree Implementation',
      courseCode: 'CS301',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priority: TaskPriority.high,
      isCompleted: false,
    ),
    Assignment(
      id: 'a3',
      title: 'Relational Schema Normalization (BCNF)',
      courseCode: 'CS303',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      priority: TaskPriority.medium,
      isCompleted: true,
    ),
    Assignment(
      id: 'a4',
      title: 'TCP vs UDP Socket Programming',
      courseCode: 'CS304',
      dueDate: DateTime.now().add(const Duration(days: 9)),
      priority: TaskPriority.low,
      isCompleted: false,
    ),
  ];

  // Getters
  StudentProfile get profile => _profile;
  List<Course> get courses => List.unmodifiable(_courses);
  List<Assignment> get assignments => List.unmodifiable(_assignments);

  // Computed metrics
  int get totalCredits => _courses.fold(0, (sum, c) => sum + c.credits);

  double get currentCgpa {
    if (_courses.isEmpty || totalCredits == 0) return 0.0;
    double weightedPoints = _courses.fold(0.0, (sum, c) => sum + (c.gradePoint * c.credits));
    return double.parse((weightedPoints / totalCredits).toStringAsFixed(2));
  }

  double get overallAttendancePercentage {
    int totalAttended = _courses.fold(0, (sum, c) => sum + c.attendedClasses);
    int totalConducted = _courses.fold(0, (sum, c) => sum + c.totalClasses);
    if (totalConducted == 0) return 100.0;
    return double.parse(((totalAttended / totalConducted) * 100.0).toStringAsFixed(1));
  }

  int get pendingAssignmentsCount => _assignments.where((a) => !a.isCompleted).length;
  int get completedAssignmentsCount => _assignments.where((a) => a.isCompleted).length;

  // Actions
  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  void removeCourse(String id) {
    _courses.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void logAttendance(String courseId, {required bool attended}) {
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final current = _courses[index];
      _courses[index] = current.copyWith(
        attendedClasses: attended ? current.attendedClasses + 1 : current.attendedClasses,
        totalClasses: current.totalClasses + 1,
      );
      notifyListeners();
    }
  }

  void toggleAssignment(String id) {
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index != -1) {
      final current = _assignments[index];
      _assignments[index] = current.copyWith(isCompleted: !current.isCompleted);
      notifyListeners();
    }
  }

  void addAssignment(Assignment assignment) {
    _assignments.insert(0, assignment);
    notifyListeners();
  }

  void updateProfile(StudentProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  /// Calculates number of additional consecutive classes needed to reach target percentage (e.g. 75%)
  static int classesNeededForThreshold(int attended, int total, double targetPercentage) {
    if (total == 0) return 0;
    final targetFraction = targetPercentage / 100.0;
    final currentPercentage = (attended / total) * 100.0;
    if (currentPercentage >= targetPercentage) return 0;

    // (attended + x) / (total + x) >= targetFraction
    // attended + x >= targetFraction * total + targetFraction * x
    // x * (1 - targetFraction) >= targetFraction * total - attended
    // x >= (targetFraction * total - attended) / (1 - targetFraction)
    final needed = ((targetFraction * total - attended) / (1.0 - targetFraction)).ceil();
    return needed > 0 ? needed : 0;
  }

  /// Calculates how many classes a student can safely miss while staying at or above target percentage
  static int safeMissableClasses(int attended, int total, double targetPercentage) {
    if (total == 0) return 0;
    final targetFraction = targetPercentage / 100.0;
    final currentPercentage = (attended / total) * 100.0;
    if (currentPercentage < targetPercentage) return 0;

    // attended / (total + x) >= targetFraction
    // attended >= targetFraction * (total + x)
    // attended / targetFraction >= total + x
    // x <= (attended / targetFraction) - total
    final missable = ((attended / targetFraction) - total).floor();
    return missable > 0 ? missable : 0;
  }

  /// Calculate GPA for an arbitrary list of grade points and credit hours
  static double calculateGpa(List<double> gradePoints, List<int> credits) {
    if (gradePoints.length != credits.length || credits.isEmpty) return 0.0;
    double totalPoints = 0.0;
    int totalCreditHours = 0;
    for (int i = 0; i < gradePoints.length; i++) {
      totalPoints += gradePoints[i] * credits[i];
      totalCreditHours += credits[i];
    }
    if (totalCreditHours == 0) return 0.0;
    return double.parse((totalPoints / totalCreditHours).toStringAsFixed(2));
  }
}
