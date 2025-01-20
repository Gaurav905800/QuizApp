import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/model/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> _quizzes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<QuizModel> get quizzes => _quizzes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchQuizzes() async {
    const url = 'https://api.jsonserve.com/Uw5CrX';

    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;

    // Schedule the notifyListeners() after the current frame is done
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _handleQuizData(jsonData);
      } else {
        throw Exception(
            'Failed to load quizzes. Status code: ${response.statusCode}');
      }
    } catch (error) {
      _errorMessage = _handleError(error);

      // Schedule the error state change after the current frame is done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } finally {
      _isLoading = false;
      // Schedule the final state change after the current frame is done
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  /// Handle quiz data based on its format (List or Map)
  void _handleQuizData(dynamic jsonData) {
    if (jsonData is List) {
      if (jsonData.isEmpty) {
        _errorMessage = 'No quizzes available';
      }
      _quizzes = jsonData.map((quiz) => QuizModel.fromJson(quiz)).toList();
    } else if (jsonData is Map<String, dynamic>) {
      _quizzes = [QuizModel.fromJson(jsonData)];
    } else {
      throw Exception('Unexpected data format');
    }
    print("Fetched quizzes successfully");
  }

  /// Handle errors and return a user-friendly message
  String _handleError(error) {
    if (error is http.ClientException) {
      return 'Network error: Please check your internet connection';
    } else if (error is FormatException) {
      return 'Error parsing data from the server';
    } else {
      return 'Error fetching quizzes: $error';
    }
  }

  /// Clear quizzes (useful for resetting state)
  void clearQuizzes() {
    _quizzes = [];
    notifyListeners();
  }
}
