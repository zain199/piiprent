import 'package:flutter/cupertino.dart';

class QuestionContneir extends StatelessWidget {
  String text;

  double fontsize;

  QuestionContneir({
    this.text,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontsize,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              color: Color(0XFF2F363D)),
        ),
      ),
    );
  }
}
