import 'package:flutter/material.dart';

class HintName extends StatelessWidget {
  var hedrtxt;

  HintName({
    this.hedrtxt,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 5,
          color: Color(0XFF2196F3),
        ),
        SizedBox(
          width: 5,
        ),
        // Text(hedrtxt,style: TextStyle(
        //     fontFamily: "Roboto",fontWeight: FontWeight.w400,fontSize: 12,color: Color(0XFF919CA7)
        // ),),
        RichText(
            text: TextSpan(
                text: hedrtxt,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0XFF919CA7)),
                children: [
              TextSpan(
                text: " *",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.red),
              )
            ]))
      ],
    );
  }
}
