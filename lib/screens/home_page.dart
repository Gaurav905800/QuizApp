import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/state/quiz_provider.dart';
import 'quiz_page.dart'; // Import the QuizPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<QuizProvider>(context, listen: false);
    apiProvider.fetchQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, quizProvider, child) {
            if (quizProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffD4A373),
                ),
              );
            }

            if (quizProvider.quizzes.isEmpty) {
              return const Center(
                child: Text(
                  'No quizzes available.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/home.json'),
                SizedBox(height: 20),
                const Text(
                  'to the Quiz App!',
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3E2723), // Dark brown color
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: const Text(
                      'Test your knowledge with a fun and interactive quiz. \nAre you ready to start?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color(0xff3E2723)), // Dark brown border
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                            // quiz:
                            //     quizProvider.quizzes.first, // Pass the first quiz
                            ),
                      ),
                    );
                  },
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(
                      color: Color(0xff3E2723), // Dark brown text color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
