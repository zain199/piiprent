import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ActivityWidgetPage extends StatelessWidget {
  const ActivityWidgetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.check),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffEEF6FF),
                border: Border.all(
                  width: 1,
                  color: Color(0xffD3DEEA),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0), //         <--- border radius here
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                child: DropdownButton(
                  underline: SizedBox(),
                  hint: const Text(
                    'Activity',
                    style: TextStyle(
                      color: Colors.black, fontSize: 16),
                  ),
                  value: "Activity1",
                  items: [
                    DropdownMenuItem(
                      child: Text('Activity1'),
                      value: "Activity1",
                    ),
                    DropdownMenuItem(
                      child: Text('Activity2'),
                      value: "Activity2",
                    ),
                    DropdownMenuItem(
                      child: Text('Activity3'),
                      value: "Activity3",
                    )
                  ],
                  onChanged: (value) {
                    print("changed value");
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffEEF6FF),
                border: Border.all(
                  width: 1,
                  color: Color(0xffD3DEEA),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0), //         <--- border radius here
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  translate("Amount"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                child: Text(translate("button.submit")),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
