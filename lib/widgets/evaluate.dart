import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Evaluate extends StatefulWidget {
  final int score;
  final bool active;
  final Function onChange;

  Evaluate({
    this.score,
    this.active,
    this.onChange,
  });

  @override
  _EvaluateState createState() => _EvaluateState();
}

class _EvaluateState extends State<Evaluate> {
  List<bool> _scoreMap = [];
  int _score;

  Widget _buildStar(bool active, int index) {
    return GestureDetector(
      onTap: widget.active
          ? () {
              widget.onChange(index + 1);
              setState(() {
                _score = index + 1;
                _scoreMap = _fillStars();
              });
            }
          : () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Icon(
          Icons.star,
          size: 22,
          color: active ? Colors.amber : Colors.grey,
        ),
      ),
    );
  }

  @override
  void initState() {
    _score = widget.score;
    _scoreMap = _fillStars();
    super.initState();
  }

  List<bool> _fillStars() {
    List<bool> scoreMap = [];
    for (var i = 0; i < 5; i++) {
      scoreMap.add(i < _score);
    }

    return scoreMap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 5.0,
      ),
      decoration: widget.active
          ? BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            )
          : null,
      child: Row(
        children: [
          widget.active
              ? Expanded(
                  flex: 1,
                  child: Text(
                    translate('timesheet.evaluate'),
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : SizedBox(),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _scoreMap
                  .asMap()
                  .map(
                    (key, active) => MapEntry(
                      key,
                      _buildStar(active, key),
                    ),
                  )
                  .values
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
