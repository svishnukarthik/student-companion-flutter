import 'package:flutter/foundation.dart';

/// ChangeNotifier provider model for Experiment 5b
/// Manages student attendance counter state reactively via Provider.
class AttendanceProvider extends ChangeNotifier {
  int _attended = 0;
  int _total = 0;

  int get attended => _attended;
  int get total => _total;
  double get percentage => _total == 0 ? 100.0 : (_attended / _total) * 100.0;

  void logPresent() {
    _attended++;
    _total++;
    notifyListeners();
  }

  void logAbsent() {
    _total++;
    notifyListeners();
  }

  void reset() {
    _attended = 0;
    _total = 0;
    notifyListeners();
  }
}
