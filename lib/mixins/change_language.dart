import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class ChangeLanguage {
  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then(
      (String value) {
        print("Value of lan : $value");
        changeLocale(context, value);
        var locale = Locale(value, '');
        Get.updateLocale(locale);
      },
    );
  }

  void onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language.selection.title')),
        message: Text(translate('language.selection.message')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(translate('language.name.en')),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.et')),
            onPressed: () => Navigator.pop(context, 'et'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.fi')),
            onPressed: () => Navigator.pop(context, 'fi'),
          ),
          CupertinoActionSheetAction(
            child: Text(translate('language.name.ru')),
            onPressed: () => Navigator.pop(context, 'ru'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate('button.cancel')),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }
}
