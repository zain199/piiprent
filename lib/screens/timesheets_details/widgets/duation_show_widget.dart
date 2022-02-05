import 'package:flutter/material.dart';
import 'package:piiprent/helpers/colors.dart';

class DurationShowWidget extends StatelessWidget {
  const DurationShowWidget(this.hintText, this.duration, {Key key})
      : super(key: key);
  final String hintText;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 5,
          color: Colors.blue,
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          flex: 3,
          child: Text(
            hintText,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Row(
            children: [
              Text(
                '${duration.inHours}h ${duration.inMinutes % 60}m',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
