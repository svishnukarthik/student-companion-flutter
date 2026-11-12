// Experiment 1: Simple Dart program to understand language basics.
// Covers variables, primitive data types, arithmetic operations,
// string interpolation, and conditional statements in a student companion context.

void main() {
  // Dart variable declarations and primitive data types
  String appName = 'Student Companion Engine';
  int totalCredits = 17;
  int earnedCredits = 17;
  double cgpa = 3.75;
  double targetCgpa = 3.90;
  bool isOnTrack = true;

  print('=== $appName ===');
  print('Total Credits: $totalCredits');
  print('Earned Credits: $earnedCredits');
  print('Current CGPA: $cgpa');
  print('Target CGPA: $targetCgpa');
  print('On Track for Honors: $isOnTrack');

  // Basic arithmetic operations for GPA calculation
  double gradePointA = 4.0;
  int creditsSubject1 = 4;
  int creditsSubject2 = 3;
  double gradePointB = 3.3;

  double weightedSum = (gradePointA * creditsSubject1) + (gradePointB * creditsSubject2);
  int totalCr = creditsSubject1 + creditsSubject2;
  double semesterGpa = weightedSum / totalCr;

  print('\n--- GPA Arithmetic Operations ---');
  print('Subject 1: Grade A (4.0) × $creditsSubject1 credits = ${gradePointA * creditsSubject1}');
  print('Subject 2: Grade B+ (3.3) × $creditsSubject2 credits = ${gradePointB * creditsSubject2}');
  print('Weighted Sum: $weightedSum');
  print('Total Credits: $totalCr');
  print('Semester GPA: ${semesterGpa.toStringAsFixed(2)}');

  // Attendance percentage calculation
  int attendedClasses = 36;
  int totalClasses = 40;
  double attendancePercentage = (attendedClasses / totalClasses) * 100;
  print('\n--- Attendance Calculation ---');
  print('Attended: $attendedClasses / $totalClasses = ${attendancePercentage.toStringAsFixed(1)}%');

  // Conditional statements for academic validation
  print('\n--- Conditional Validation ---');
  if (totalClasses == 0) {
    print('Error: No classes conducted yet');
  } else if (attendancePercentage >= 75.0) {
    print('Status: Attendance requirement satisfied ✓');
  } else {
    print('Warning: Below 75% mandatory attendance threshold');
  }

  // Range check on CGPA
  if (cgpa >= 3.7) {
    print('Evaluation: Honors candidate (CGPA $cgpa ≥ 3.7)');
  } else {
    print('Evaluation: Standard standing (CGPA $cgpa)');
  }
}
