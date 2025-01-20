import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/state/quiz_provider.dart';
import 'package:vibration/vibration.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  int remainingTime = 15; // Time in seconds for each question
  Timer? timer;
  int? selectedOptionIndex; // To track the selected option index
  bool isFetchingQuizzes = false; // To track the API call
  List marks = [];

  @override
  void initState() {
    super.initState();
    fetchQuizzes(); // Fetch quizzes on initialization
  }

  void fetchQuizzes() async {
    setState(() {
      isFetchingQuizzes = true;
    });
    try {
      await Provider.of<QuizProvider>(context, listen: false).fetchQuizzes();
    } catch (error) {
      debugPrint('Error fetching quizzes: $error');
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isFetchingQuizzes = false;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    // Cancel any existing timer before starting a new one
    timer?.cancel();
    setState(() {
      remainingTime = 15; // Reset timer
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        t.cancel();
        moveToNextQuestion();
      }
    });
  }

  void stopTimer() {
    timer?.cancel(); // Stop the timer when needed
  }

  void moveToNextQuestion() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final currentQuiz =
        quizProvider.quizzes.isNotEmpty ? quizProvider.quizzes.first : null;

    if (currentQuiz != null &&
        currentQuestionIndex < currentQuiz.questions!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        selectedOptionIndex = null; // Reset the selected option
      });
      startTimer(); // Restart timer for the next question
    } else {
      // showCompletionDialog();
      completedQuiz(context);
    }
  }

  void completedQuiz(BuildContext context) {
    final totalPoints = marks.fold<int>(0,
        (previousValue, element) => previousValue + element['points'] as int);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.3, // Set the initial size of the sheet
          minChildSize: 0.1, // Minimum height
          maxChildSize: 0.9, // Maximum height
          builder: (context, scrollController) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffFAF3E0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Quiz Completed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You scored $totalPoints out of 50!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showCompletionDialog();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            Color(0xffFBC02D), // Your desired color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Check answers'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showCompletionDialog() async {
    await Future.delayed(const Duration(seconds: 1));

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: const Color(0xffFAF3E0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Here are your results:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: marks.length,
                  itemBuilder: (context, index) {
                    final result = marks[index];
                    return Card(
                      color: result['points'] > 0
                          ? const Color(0xff388E3C) // Green for correct answers
                          : const Color(
                              0xffC62828), // Red for incorrect answers
                      child: ListTile(
                        title: Text(
                          result['answer'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          '${result['points']} points',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFBC02D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                        color: Color(0xff3E2723), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    // Show loading state
    if (isFetchingQuizzes || quizProvider.isLoading) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Colors.brown,
        )),
      );
    }

    // Handle error state
    if (quizProvider.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(
            quizProvider.errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    // Get the first quiz (assuming only one quiz is returned)
    final currentQuiz =
        quizProvider.quizzes.isNotEmpty ? quizProvider.quizzes.first : null;

    // No quiz available
    if (currentQuiz == null || currentQuiz.questions == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: const Center(
          child: Text('No quizzes available.'),
        ),
      );
    }

    final currentQuestion = currentQuiz.questions![currentQuestionIndex];

    // Start the timer if it's the first question or if the question has changed
    if (remainingTime == 15 && currentQuestionIndex == 0) {
      startTimer();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Question ${currentQuestionIndex + 1}/${currentQuiz.questions!.length}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer Circular Progress Bar
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: remainingTime / 15, // Progress value (0.0 to 1.0)
                      strokeWidth: 8.0,
                      color: remainingTime > 5
                          ? const Color(0xffD4A373)
                          : const Color(0xffD32F2F),
                    ),
                  ),
                  Text(
                    '$remainingTime s',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Q${currentQuestionIndex + 1}: ${currentQuestion.description ?? "No description"}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...?currentQuestion.options?.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final option = entry.value;

                final optionLabel = String.fromCharCode(65 + index);

                return GestureDetector(
                  onTap: () {
                    if (!isAnswered) {
                      setState(() {
                        isAnswered = true;
                        selectedOptionIndex = index; // Track selected option
                      });

                      stopTimer(); // Stop the timer when an option is selected

                      // Check if the selected option is correct
                      if (option.isCorrect ?? false) {
                        // Add 5 points for a correct answer
                        setState(() {
                          marks.add({
                            'points': 5,
                            'answer': option.description ?? '',
                          });
                        });
                      } else {
                        // Add 0 points for an incorrect answer and trigger vibration
                        setState(() {
                          marks.add({
                            'points': 0,
                            'answer': option.description ?? '',
                          });
                        });
                        Vibration.vibrate(
                          duration: 500,
                        ); // Vibrates for 500 milliseconds
                      }
                    }
                  },
                  child: Card(
                    color: isAnswered
                        ? (option.isCorrect ?? false
                            ? const Color(
                                0xff388E3C) // Green for correct answer
                            : const Color(
                                0xffC62828)) // Red for incorrect answer
                        : Colors.white,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            '$optionLabel. ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              option.description ?? '',
                              style: isAnswered
                                  ? const TextStyle(color: Colors.white)
                                  : const TextStyle(),
                            ),
                          ),
                          if (isAnswered && index == selectedOptionIndex)
                            Icon(
                              option.isCorrect ?? false
                                  ? Icons.check
                                  : Icons.close,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            if (isAnswered)
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: moveToNextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFBC02D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    currentQuestionIndex < currentQuiz.questions!.length - 1
                        ? 'Next Question'
                        : 'Finish Quiz',
                    style: const TextStyle(
                        color: Color(0xff3E2723), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
