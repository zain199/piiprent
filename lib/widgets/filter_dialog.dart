import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jiffy/jiffy.dart';
import 'package:piiprent/widgets/form_field.dart';

class FilterDialog extends StatefulWidget {
  final DateTime from;
  final DateTime to;
  final Function onChange;

  FilterDialog({this.from, this.to, this.onChange});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  StreamController _dataStreamController = StreamController.broadcast();
  StreamController _fromStreamController = StreamController();
  StreamController _toStreamController = StreamController();

  get stream {
    return _dataStreamController.stream;
  }

  _emit(DateTime from, DateTime to) {
    Map<String, DateTime> data = {"from": from, "to": to};

    _dataStreamController.add(data);
  }

  @override
  initState() {
    super.initState();
    _dataStreamController.stream.listen((event) {
      if (widget.onChange != null) {
        widget.onChange(event);
      }
    });

    if (widget.from != null || widget.to != null) {
      _emit(widget.from, widget.to);
    }
  }

  _setToday() {
    DateTime now = DateTime.now();
    _emit(now, now);
  }

  _setYesterday() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    _emit(yesterday, yesterday);
  }

  _setThisWeek() {
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime sunday = now.add(Duration(days: 7 - now.weekday));
    _emit(monday, sunday);
  }

  _setLastWeek() {
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime sunday = now.add(Duration(days: 7 - now.weekday));
    _emit(
      monday.subtract(Duration(days: 7)),
      sunday.subtract(Duration(days: 7)),
    );
  }

  _setThisMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime.utc(now.year, now.month, 1);
    DateTime lastDayofMonth = Jiffy().endOf(Units.MONTH).dateTime;
    _emit(firstDayOfMonth, lastDayofMonth);
  }

  _setLastMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime.utc(now.year, now.month, 1);
    DateTime firstDayOfLastMonth =
        Jiffy(firstDayOfMonth.subtract(Duration(days: 1)))
            .startOf(Units.MONTH)
            .dateTime;
    DateTime lastDayOfLastMonth =
        Jiffy(firstDayOfMonth.subtract(Duration(days: 1)))
            .endOf(Units.MONTH)
            .dateTime;
    _emit(firstDayOfLastMonth, lastDayOfLastMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          // alignment: WrapAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                // backgroundColor: Colors.blue,
                onPressed: _setToday,
                child: Text(translate('dialog.today'),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 8.0,
            // ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                // backgroundColor: Colors.blue,
                onPressed: _setYesterday,
                child: Text(translate('dialog.yesterday'),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 8.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                // backgroundColor: Colors.blue,
                onPressed: _setThisWeek,
                child: Text(translate('dialog.this_week'),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 8.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                // backgroundColor: Colors.blue,
                onPressed: _setLastWeek,
                child: Text(translate('dialog.last_week'),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 8.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                // backgroundColor: Colors.blue,
                onPressed: _setThisMonth,
                child: Text(translate('dialog.this_month'),
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 8.0,
            // ),
            ElevatedButton(
              // backgroundColor: Colors.blue,
              onPressed: _setLastMonth,
              child: Text(translate('dialog.last_month'),
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            DateTime from;
            DateTime to;

            if (snapshot.hasData) {
              from = snapshot.data["from"];
              to = snapshot.data["to"];

              if (from != null) {
                _fromStreamController.add(from);
              }

              if (to != null) {
                _toStreamController.add(to);
              }
            }

            return Row(
              children: [
                Expanded(
                  child: Field(
                    label: translate('dialog.from'),
                    datepicker: true,
                    initialValue: widget.from,
                    setStream: _fromStreamController.stream,
                    onChanged: (data) {
                      _emit(data, to);
                    },
                  ),
                ),
                Expanded(
                  child: Field(
                    label: translate('dialog.to'),
                    datepicker: true,
                    initialValue: widget.to,
                    setStream: _toStreamController.stream,
                    onChanged: (data) {
                      _emit(from, data);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
