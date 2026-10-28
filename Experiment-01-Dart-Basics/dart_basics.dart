
import 'dart:io';

void main() {
  String name = "Student";
  int rollNumber = 101;
  double marks = 85.5;
  bool passed = true;

  print("Name: $name");
  print("Roll Number: $rollNumber");
  print("Marks: $marks");

  int a = 20;
  int b = 5;

  print("Addition: ${a + b}");
  print("Subtraction: ${a - b}");
  print("Multiplication: ${a * b}");
  print("Division: ${a / b}");

  if (passed) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }

  for (int i = 1; i <= 5; i++) {
    print("Experiment $i");
  }
  print("Enter your age:");
  String? input = stdin.readLineSync();
  int? age = int.tryParse(input ?? "");

  if (age == null || age < 0) {
    print("Invalid age. Please enter a valid age.");
  } else {
    print("Your age is: $age");
  }
}
