import 'package:flutter/material.dart';
import 'package:piiprent/mixins/change_language.dart';

class LanguageSelect extends StatelessWidget with ChangeLanguage {
  Color _color;

  LanguageSelect({
    color = Colors.white,
  }) {
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: _color,
      iconSize: 24,
      onPressed: () => onActionSheetPress(context),
      icon: Icon(Icons.language),
    );
  }
}
