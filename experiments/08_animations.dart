import 'package:flutter/material.dart';

// Experiment 8: Animations
// Leverages Flutter's animation framework using AnimationController,
// CurvedAnimation, FadeTransition, ScaleTransition, and SlideTransition
// to smoothly reveal student metric cards and attendance results.

void main() {
  runApp(const StudentAnimationsApp());
}

class StudentAnimationsApp extends StatelessWidget {
  const StudentAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 8 - Animations',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const StudentAnimationScreen(),
    );
  }
}

class StudentAnimationScreen extends StatefulWidget {
  const StudentAnimationScreen({super.key});

  @override
  State<StudentAnimationScreen> createState() => _StudentAnimationScreenState();
}

class _StudentAnimationScreenState extends State<StudentAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnim = CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut);

    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    // Stagger the animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () => _scaleController.forward());
    Future.delayed(const Duration(milliseconds: 600), () => _slideController.forward());
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _replay() {
    _fadeController.reset();
    _scaleController.reset();
    _slideController.reset();
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () => _scaleController.forward());
    Future.delayed(const Duration(milliseconds: 600), () => _slideController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Animations (Exp 8)'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.replay), onPressed: _replay),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade In - Title
            FadeTransition(
              opacity: _fadeAnim,
              child: const Text(
                'Student Companion',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Scale Bounce - CGPA Card
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF243248),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.grade, color: Color(0xFF10B981), size: 32),
                    SizedBox(height: 8),
                    Text('Current CGPA', style: TextStyle(color: Color(0xFF94A3B8))),
                    Text('3.75', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Slide In - Attendance Result
            SlideTransition(
              position: _slideAnim,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF243248),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF6366F1)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.how_to_reg, color: Color(0xFF6366F1), size: 32),
                    SizedBox(height: 8),
                    Text('Overall Attendance', style: TextStyle(color: Color(0xFF94A3B8))),
                    Text('88.8%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                    Text('Above 75% threshold ✓', style: TextStyle(color: Color(0xFF10B981), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
