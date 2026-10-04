import 'package:flutter/material.dart';

import 'package:adv_basics/high_scores_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(
    this.startQuiz, {
    super.key,
    required this.highScores,
  });

  final void Function() startQuiz;
  final List<int> highScores;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.75),
          ),
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(height: 80),
          Text(
            'Learn Flutter the fun way!',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: startQuiz,
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
          const SizedBox(height: 15),

          // L7: Navigate to the High Scores screen.
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HighScoresScreen(
                    highScores: highScores,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.emoji_events),
            label: const Text('High Scores'),
          ),
        ],
      ),
    );
  }
}