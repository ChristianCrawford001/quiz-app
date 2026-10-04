import 'package:flutter/material.dart';

import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/results_screen.dart';

// L1: Custom color scheme for the quiz app.
final quizColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 116, 79, 198),
  brightness: Brightness.dark,
);

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];

  // L7: High scores are stored for the current app session.
  // L9 would be used later if scores need to persist after closing the app.
  final List<int> highScores = [];

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      var score = 0;

      for (var i = 0; i < selectedAnswers.length; i++) {
        if (selectedAnswers[i] == questions[i].answers[0]) {
          score++;
        }
      }

      highScores.add(score);

      // Put the highest scores first.
      highScores.sort((a, b) => b.compareTo(a));

      // Keep only the top 5 scores.
      if (highScores.length > 5) {
        highScores.removeRange(5, highScores.length);
      }

      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void returnToStartScreen() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(
      switchScreen,
      highScores: highScores,
    );

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
        onReturnHome: returnToStartScreen,
        highScores: highScores,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // L1: Apply the custom app-wide color scheme.
      theme: ThemeData(
        colorScheme: quizColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 10, 61),

        // L1: Consistent text styles used throughout the app.
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 222, 205, 250),
            fontSize: 14,
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 45, 16, 83),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: quizColorScheme.primaryContainer,
            foregroundColor: quizColorScheme.onPrimaryContainer,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: quizColorScheme.secondary,
          ),
        ),
      ),

      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 54, 20, 105),
                Color.fromARGB(255, 104, 55, 163),
                Color.fromARGB(255, 35, 14, 75),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}