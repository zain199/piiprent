import 'package:flutter/material.dart';

class GroupTitle extends StatelessWidget {
  final String title;

  GroupTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Divider(
              color: Colors.blueAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[700], fontSize: 18.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Divider(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
