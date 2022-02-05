import 'package:flutter/material.dart';

class ScoreBadge extends StatelessWidget {
  final dynamic score;

  ScoreBadge({this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 14.0,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            '$score',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
