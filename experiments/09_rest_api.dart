import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Experiment 9: REST API Integration in Flutter
// Fetches motivational/educational quotes from an open REST API,
// parses JSON responses into Dart models, and displays them with FutureBuilder,
// loading spinners, error handling, and manual refresh actions.

void main() {
  runApp(const StudyQuoteApiApp());
}

class StudyQuoteApiApp extends StatelessWidget {
  const StudyQuoteApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 9 - REST API',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const QuoteScreen(),
    );
  }
}

class StudyQuote {
  final String text;
  final String author;

  const StudyQuote({required this.text, required this.author});

  factory StudyQuote.fromJson(Map<String, dynamic> json) {
    return StudyQuote(
      text: json['q'] ?? json['content'] ?? json['quote'] ?? 'Stay dedicated to your education.',
      author: json['a'] ?? json['author'] ?? 'Unknown Scholar',
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<StudyQuote> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = fetchQuote();
  }

  Future<StudyQuote> fetchQuote() async {
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
      throw Exception('Server returned ${response.statusCode}');
    } catch (_) {
      // Offline fallback
      return const StudyQuote(
        text: 'Success is the sum of small efforts, repeated day in and day out.',
        author: 'Robert Collier',
      );
    }
  }

  void _refresh() {
    setState(() {
      _quoteFuture = fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Study Motivation (Exp 9)'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: const Icon(Icons.sync), onPressed: _refresh),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.format_quote, color: Color(0xFF10B981), size: 40),
            const SizedBox(height: 20),
            FutureBuilder<StudyQuote>(
              future: _quoteFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Color(0xFF10B981));
                }

                if (snapshot.hasError) {
                  return Column(
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 40),
                      const SizedBox(height: 10),
                      Text('Error: ${snapshot.error}', style: const TextStyle(color: Color(0xFFEF4444))),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _refresh,
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                }

                final quote = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E293B), Color(0xFF312E81)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '"${quote.text}"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '— ${quote.author}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Powered by ZenQuotes REST API',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
            ),
            const Text(
              'HTTP GET → JSON Deserialization → FutureBuilder',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
