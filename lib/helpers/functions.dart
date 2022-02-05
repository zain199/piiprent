import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piiprent/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> generateTranslations(
  List<dynamic> translations,
  String name,
) {
  Map<String, String> result = Map();

  if (translations.isEmpty) {
    result.addAll({languageMap['EN']: name});
  } else {
    translations.forEach((element) {
      result.addAll({element['language']['id']: element['value']});
    });

    if (result[languageMap['EN']] == null) {
      result.addAll({languageMap['EN']: name});
    }
  }

  return result;
}

String parseAddress(Map<String, dynamic> address) {
  if (address != null) {
    return (address['__str__'] as String).replaceAll('\n', ' ');
  }

  return '';
}

double doubleParse(dynamic target, [defaultValue = 0.00]) {
  if (target.runtimeType == String) {
    return double.parse(target);
  }

  return defaultValue;
}

void showProminentDisclosureDialog(
    BuildContext context, Function action) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('isPermissionAllowed') == true) {
    var status = await Permission.location.status;
    if (status.isGranted) {
      action(true);
      return;
    } else {
      prefs.setBool('isPermissionAllowed', false);
    }
  }
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Text('Prominent disclosure'),
            content: Text(
              'If you have started a job from the App then Piiprent collects your location data to track your job progress even if the app is working in background.\nThe app is not functional without location permission.',
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  action(false);
                },
                child: Text('Deny'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  requestPermission(context, action);
                },
                child: Text('Agree'),
              ),
            ],
          ));
    },
  );
}

void requestPermission(BuildContext context, Function action) async {
  if (await Permission.location.request().isGranted) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPermissionAllowed', true);
    action(true);
  } else {
    var status = await Permission.location.status;
    if (status.isPermanentlyDenied) {
      showErrorDialog(context, 'Permission is required',
          'Location Permission is required in order to access this feature. Please go to App settings from the System settings in order to allow location permission.',
          action: action);
    }
  }
}

void showDenyAlertDialog(BuildContext context, Function action) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              "We track your work location if you are going to work and have an active shift. You are not eligible for this work without confirmation of this permission.",
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  action(false);
                },
                child: Text('Close'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  action(true);
                },
                child: Text('Allow'),
              ),
            ],
          ));
    },
  );
}

void showErrorDialog(BuildContext context, String title, String message,
    {Function action}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: Text(title ?? 'Error occurred'),
          content: Text(
            message ?? 'Unexpected error occurred.',
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                action(null);
              },
              child: Text('Close'),
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
                if (await Permission.location.status.isGranted) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isPermissionAllowed', true);
                  action(true);
                } else {
                  action(null);
                }
              },
              child: Text('Open App settings'),
            ),
          ],
        ),
      );
    },
  );
}

DateTime stringDateToDateTime(String date) {
  try {
    return DateFormat("MMM dd, yyyy").parse(date);
  } catch (e) {
    return null;
  }
}

TimeOfDay stringTimeToTimeOfDay(String time) {
  try {
    return TimeOfDay.fromDateTime(DateFormat.jm().parse(time));
  } catch (e) {
    return null;
  }
}

TimeOfDay stringBreakTimeToTimeOfDay(String breakTime) {
  try {
    return TimeOfDay.fromDateTime(DateFormat.Hm()
        .parse(breakTime.replaceAll('h ', ':').replaceAll('m', '')));
  } catch (e) {
    return null;
  }
}

String formatDateTime(DateTime _dateTime) {
  try {
    return DateFormat("dd/MM/yyyy h:mm a").format(_dateTime);
  } catch (e) {
    return _dateTime.toString();
  }
}