import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class StudyQuote {
  final String text;
  final String author;

  const StudyQuote({required this.text, required this.author});

  factory StudyQuote.fromJson(Map<String, dynamic> json) {
    return StudyQuote(
      text: json['content'] ?? json['q'] ?? json['quote'] ?? 'Stay dedicated to your education.',
      author: json['author'] ?? json['a'] ?? 'Unknown Scholar',
    );
  }
}

class StudyResourcesScreen extends StatefulWidget {
  const StudyResourcesScreen({super.key});

  @override
  State<StudyResourcesScreen> createState() => _StudyResourcesScreenState();
}

class _StudyResourcesScreenState extends State<StudyResourcesScreen> {
  late Future<StudyQuote> _quoteFuture;

  // Study Pomodoro Timer state
  int _secondsLeft = 25 * 60;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _quoteFuture = fetchMotivationalQuote();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<StudyQuote> fetchMotivationalQuote() async {
    try {
      final response = await http
          .get(Uri.parse('https://zenquotes.io/api/today'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return StudyQuote.fromJson(data[0] as Map<String, dynamic>);
        }
      }
    } catch (_) {
      // Graceful offline fallback
    }
    return const StudyQuote(
      text: 'Success is the sum of small efforts, repeated day in and day out.',
      author: 'Robert Collier',
    );
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (_secondsLeft > 0) {
          setState(() => _secondsLeft--);
        } else {
          t.cancel();
          setState(() {
            _isRunning = false;
            _secondsLeft = 25 * 60;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pomodoro session completed! Time for a short break.')),
          );
        }
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _secondsLeft = 25 * 60;
    });
  }

  String _formatTime(int totalSecs) {
    final m = (totalSecs ~/ 60).toString().padLeft(2, '0');
    final s = (totalSecs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Study Lounge & Motivation'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pomodoro Focus Timer Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Text(
                  'Focus Pomodoro Timer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _formatTime(_secondsLeft),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleTimer,
                      icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                      label: Text(_isRunning ? 'Pause' : 'Start Focus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: _resetTimer,
                      icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
                      label: const Text('Reset', style: TextStyle(color: AppColors.textSecondary)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // REST API Daily Inspiration Card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Academic Motivation (REST API)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.sync, color: AppColors.primary, size: 20),
                onPressed: () {
                  setState(() {
                    _quoteFuture = fetchMotivationalQuote();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder<StudyQuote>(
            future: _quoteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CircularProgressIndicator(color: AppColors.primary),
                );
              }
              final quote = snapshot.data ??
                  const StudyQuote(
                    text: 'Consistency leads to excellence.',
                    author: 'Academic Proverb',
                  );

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF312E81)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.format_quote, color: AppColors.primary, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      '"${quote.text}"',
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '— ${quote.author}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Study Tips Quick Cards
          const Text(
            'High-Yield Study Strategies',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          _buildTipTile(
            Icons.access_time_filled,
            'Spaced Repetition',
            'Review key concepts over 1-day, 3-day, and 7-day intervals to maximize memory retention.',
            AppColors.primary,
          ),
          _buildTipTile(
            Icons.menu_book,
            'Active Recall',
            'Test yourself with flashcards and practice problems rather than passively reading slides.',
            AppColors.secondary,
          ),
          _buildTipTile(
            Icons.flag,
            'Feynman Technique',
            'Explain technical topics in plain terms to identify knowledge gaps rapidly.',
            AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildTipTile(IconData icon, String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
