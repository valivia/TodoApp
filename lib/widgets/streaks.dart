import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/streak.dart';
import '../state/task.dart';

class StreakBar extends StatelessWidget {
  final Streak streak;
  final int maxDuration;

  const StreakBar({
    Key? key,
    required this.streak,
    required this.maxDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double barHeight = 18.0;
    const double maxWidth = 250.0;
    final double width = (streak.duration / maxDuration) * maxWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('MMM d').format(streak.start!),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          height: barHeight,
          width: width,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(streak.duration.toString(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          DateFormat('MMM d').format(streak.end!),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

class StreakDisplayWidget extends StatelessWidget {
  final Task task;
  const StreakDisplayWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Streak> streaks = task.getStreaks();
    final int maxDuration = streaks.isNotEmpty
        ? streaks
            .map((streak) => streak.duration)
            .reduce((a, b) => a > b ? a : b)
        : 1;

    return Column(
        children: streaks
            .map((streak) => StreakBar(
                  streak: streak,
                  maxDuration: maxDuration,
                ))
            .toList());
  }
}
