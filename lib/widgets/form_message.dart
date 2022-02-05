import 'package:flutter/material.dart';
import 'package:piiprent/helpers/enums.dart';

class FormMessage extends StatelessWidget {
  final MessageType type;
  final String message;

  FormMessage({
    this.type,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    Color color = type == MessageType.Error ? Colors.red : Colors.green;

    if (message != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            this.message,
            style: TextStyle(color: color),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
