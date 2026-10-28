
void main() {
  String name = "Student";
  int rollNumber = 101;
  double marks = 85.5;
  bool passed = true;

  print("Name: $name");
  print("Roll Number: $rollNumber");
  print("Marks: $marks");

  // Arithmetic operations
  int a = 20;
  int b = 5;

  print("Addition: ${a + b}");
  print("Subtraction: ${a - b}");
  print("Multiplication: ${a * b}");
  print("Division: ${a / b}");

  // Conditional statement
  if (passed) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }

  // Loop
  for (int i = 1; i <= 5; i++) {
    print("Experiment $i");
  }
}
