import 'package:flutter/material.dart';

class TextDisplayWidget extends StatelessWidget {
  final String text;

  const TextDisplayWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
