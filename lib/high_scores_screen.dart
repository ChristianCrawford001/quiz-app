import 'package:flutter/material.dart';

class HighScoresScreen extends StatelessWidget {
  const HighScoresScreen({
    super.key,
    required this.highScores,
  });

  final List<int> highScores;

  @override
  Widget build(BuildContext context) {
    final sortedScores = List<int>.from(highScores)
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('High Scores'),
      ),
      body: Container(
        width: double.infinity,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: sortedScores.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 80,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No High Scores Yet',
                          style:
                              Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Complete a quiz to add your first score.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Top Scores',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: ListView.separated(
                          itemCount: sortedScores.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final score = sortedScores[index];

                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    '${index + 1}',
                                  ),
                                ),
                                title: Text(
                                  'Score: $score',
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                trailing: Icon(
                                  index == 0
                                      ? Icons.workspace_premium
                                      : Icons.emoji_events_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}