import 'dart:io';

void main() {
  // 1. Variables and data types
  String name = "Student";
  int rollNumber = 101;
  double marks = 85.5;
  bool passed = true;

  print("===== Student Details =====");
  print("Name: $name");
  print("Roll Number: $rollNumber");
  print("Marks: $marks");

  // 2. Arithmetic operations
  int a = 20;
  int b = 5;

  print("\n===== Arithmetic Operations =====");
  print("Addition: ${a + b}");
  print("Subtraction: ${a - b}");
  print("Multiplication: ${a * b}");
  print("Division: ${a / b}");

  // 3. If-else condition
  print("\n===== Pass or Fail =====");

  if (passed) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }

  // 4. For loop
  print("\n===== For Loop =====");

  for (int i = 1; i <= 5; i++) {
    print("Experiment $i");
  }

  // 5. User input and age validation
  print("\n===== Age Validation =====");
  stdout.write("Enter your age: ");

  String? input = stdin.readLineSync();
  int? age = int.tryParse(input ?? "");

  if (age == null || age < 0) {
    print("Invalid age. Please enter a valid age.");
  } else {
    print("Your age is: $age");

    if (age >= 18) {
      print("You are an adult.");
    } else {
      print("You are a minor.");
    }
  }

  // 6. Grade calculator
  print("\n===== Grade Calculator =====");

  if (marks >= 90) {
    print("Grade: A");
  } else if (marks >= 80) {
    print("Grade: B");
  } else if (marks >= 70) {
    print("Grade: C");
  } else if (marks >= 50) {
    print("Grade: D");
  } else {
    print("Grade: F");
  }
}