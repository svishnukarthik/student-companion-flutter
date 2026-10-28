void main() {
  String name = "Student";
  int rollNumber = 101;
  double marks = 85.5;
  bool passed = true;

  print("Name: $name");
  print("Roll Number: $rollNumber");
  print("Marks: $marks");

  if (passed) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }

  for (int i = 1; i <= 5; i++) {
    print("Experiment $i");
  }
}