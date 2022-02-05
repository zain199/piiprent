import 'package:flutter/material.dart';

class ListCardRecord extends StatelessWidget {
  final Widget content;
  final bool last;

  ListCardRecord({this.content, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: last
          ? BoxDecoration()
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
              ),
            ),
      child: content,
    );
  }
}
