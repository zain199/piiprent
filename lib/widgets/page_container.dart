import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  PageContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: child,
    );
  }
}
