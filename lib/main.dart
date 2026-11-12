import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/controllers/student_companion_controller.dart';
import 'src/screens/main_navigation_scaffold.dart';
import 'src/screens/courses_screen.dart';
import 'src/screens/attendance_screen.dart';
import 'src/screens/gpa_calculator_screen.dart';
import 'src/screens/study_resources_screen.dart';
import 'src/utils/constants.dart';

void main() {
  runApp(const StudentCompanionApp());
}

class StudentCompanionApp extends StatelessWidget {
  const StudentCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentCompanionController(),
      child: MaterialApp(
        title: 'Student Companion',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surface,
          ),
          fontFamily: 'Segoe UI',
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.surface,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        // Home with bottom navigation
        home: const MainNavigationScaffold(),
        // Named routes support
        routes: {
          '/dashboard': (context) => const MainNavigationScaffold(),
          '/courses': (context) => const CoursesScreen(),
          '/attendance': (context) => const AttendanceScreen(),
          '/gpa': (context) => const GpaCalculatorScreen(),
          '/study': (context) => const StudyResourcesScreen(),
        },
      ),
    );
  }
}
