import 'package:flutter/material.dart';

class NeewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("newpage"),
      ),
      body: Center(
        child: Text(
          "Welcome to new Page",
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}
