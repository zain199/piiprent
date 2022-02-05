import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/lang_icon.dart';

PreferredSizeWidget RegiAppbar() {
  return AppBar(
    title: Row(
      children: [
        Text(
          translate('title.registration'),
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 22.02,
        ),
        child: LagIcon(
          buttoncolor: Colors.white,
        ),
      ),
    ],
  );
}
