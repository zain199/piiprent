import 'package:flutter/material.dart';

class RadioContainer extends StatelessWidget {
  var colorcondition;
  var groupvalue;
  var value;

  var onchanged;

  String text;

  RadioContainer(
      {this.colorcondition,
      this.value,
      this.groupvalue,
      this.onchanged,
      this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Color(0x215d7cac),
                offset: Offset(0, 4),
                blurRadius: 38,
                spreadRadius: 0)
          ],
          border: colorcondition
              ? Border.all(width: 1, color: Color(0XFF2196F3))
              : null),
      height: 62,
      width: 343,
      child: Row(
        children: [
          Radio(
            splashRadius: 7.0,
            value: value,
            groupValue: groupvalue,
            activeColor: Color(0XFF2196F3),
            onChanged: onchanged,
          ),
          // SizedBox(width:5,),
          Text(
            text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                color: colorcondition ? Color(0XFF2196F3) : Color(0XFFBCC8D6)),
          ),
        ],
      ),
    );
  }
}
