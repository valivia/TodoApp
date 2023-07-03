import 'package:flutter/material.dart';

class TextDisplayWidget extends StatelessWidget {
  final String text;
  final Function onTap;

  const TextDisplayWidget({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
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
          ),
        ),
      ),
    );
  }
}
