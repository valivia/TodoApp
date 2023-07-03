import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/daily_tasks.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({Key? key}) : super(key: key);
  final iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final dailytasks = Provider.of<DailyTasks>(context);
    DateTime today = DailyTasks.convertDate(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => dailytasks.date =
                dailytasks.date.subtract(const Duration(days: 1)),
            icon: const Icon(Icons.chevron_left),
            iconSize: iconSize,
          ),
          const Spacer(flex: 2),
          Text(
            DateFormat("EEEE, d MMMM").format(dailytasks.date),
            style: TextStyle(
              fontSize: 20,
              decoration:
                  dailytasks.date != today ? TextDecoration.underline : null,
            ),
          ),
          const Spacer(flex: 2),
          IconButton(
            onPressed: () =>
                dailytasks.date = dailytasks.date.add(const Duration(days: 1)),
            icon: const Icon(Icons.chevron_right),
            iconSize: iconSize,
          ),
        ],
      ),
    );
  }
}
