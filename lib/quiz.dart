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

  var activeScreen = 'start-screen';

  // L4: Track the score live during the quiz.
  var score = 0;

  // L7: Store high scores during the current app session.
  // Permanent score storage would be part of L9.
  final List<int> highScores = [];

  void switchScreen() {
    setState(() {
      selectedAnswers = [];
      score = 0;
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    final questionIndex = selectedAnswers.length;

    setState(() {
      selectedAnswers.add(answer);

      // L4: Increase the live score when the answer is correct.
      if (answer == questions[questionIndex].answers[0]) {
        score++;
      }

      if (selectedAnswers.length == questions.length) {
        // L7: Save the completed quiz score.
        highScores.add(score);

        // Sort scores from highest to lowest.
        highScores.sort(
          (a, b) => b.compareTo(a),
        );

        // Keep only the top 5 scores.
        if (highScores.length > 5) {
          highScores.removeRange(
            5,
            highScores.length,
          );
        }

        activeScreen = 'results-screen';
      }
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      score = 0;
      activeScreen = 'questions-screen';
    });
  }

  void returnToStartScreen() {
    setState(() {
      selectedAnswers = [];
      score = 0;
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

        // L4: Pass the current score to the question screen.
        score: score,
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

      // L1: Apply the custom color scheme throughout the app.
      theme: ThemeData(
        colorScheme: quizColorScheme,

        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          31,
          10,
          61,
        ),

        // L1: Consistent text styles.
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
            color: Color.fromARGB(
              255,
              222,
              205,
              250,
            ),
            fontSize: 14,
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(
            255,
            45,
            16,
            83,
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                quizColorScheme.primaryContainer,
            foregroundColor:
                quizColorScheme.onPrimaryContainer,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                quizColorScheme.secondary,
          ),
        ),
      ),

      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(
                  255,
                  54,
                  20,
                  105,
                ),
                Color.fromARGB(
                  255,
                  104,
                  55,
                  163,
                ),
                Color.fromARGB(
                  255,
                  35,
                  14,
                  75,
                ),
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