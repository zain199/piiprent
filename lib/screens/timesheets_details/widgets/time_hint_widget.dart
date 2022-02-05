import 'package:flutter/material.dart';
import 'package:piiprent/helpers/colors.dart';

class TimeHintWidget extends StatelessWidget {
  const TimeHintWidget(this.hintText, {Key key}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 5,
          color: Colors.blue,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          hintText,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
