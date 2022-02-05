import 'package:flutter/material.dart';
import 'package:piiprent/widgets/language-select.dart';

Widget getClientAppBar(
  String title,
  BuildContext context, {
  List<Tab> tabs,
  Widget leading,
}) {
  return AppBar(
    actions: [
      LanguageSelect(),
    ],
    title: Text(title),
    bottom: tabs != null ? TabBar(tabs: tabs) : null,
    leading: leading != null ? leading : null,
  );
}
