import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/helpers/colors.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/screens/timesheets_details/widgets/date_picker_box_widget.dart';
import 'package:piiprent/screens/timesheets_details/widgets/time_hint_widget.dart';

import '../../constants.dart';
import 'widgets/break_duration_box_widget.dart';
import 'widgets/time_picker_box_widget.dart';

class TimeSheetWidgetPage extends StatelessWidget {
  TimeSheetWidgetPage(this.times, {Key key}) : super(key: key);
  Map<String, DateTime> times;
  String _shiftStart = TimesheetTimeKey[TimesheetTime.Start];
  String _breakStart = TimesheetTimeKey[TimesheetTime.BreakStart];
  String _breakEnd = TimesheetTimeKey[TimesheetTime.BreakEnd];
  String _shiftEnd = TimesheetTimeKey[TimesheetTime.End];
  Duration breakDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('Time')),
        centerTitle: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 36.0,
              ),
              onPressed: () {
                Get.back();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 26.0,
            ),
            onPressed: () {
              validateInputs();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            TimeHintWidget(translate('START_TIME')),
            SizedBox(height: 12),
            Row(
              children: [
                DatePickerBoxWidget(
                  initialDate: times[_shiftStart],
                  onDateSelected: (DateTime startDate) {
                    DateTime _dateTime = DateTime(
                      startDate.year,
                      startDate.month,
                      startDate.day,
                      times[_shiftStart]?.hour ?? 0,
                      times[_shiftStart]?.minute ?? 0,
                    );
                    times[_shiftStart] = _dateTime;
                    print('initStartDate:: ${times[_shiftStart]}');
                  },
                ),
                SizedBox(width: 16),
                TimePickerBoxWidget(
                  initialDateTime: times[_shiftStart],
                  onTimeSelected: (DateTime startTime) {
                    DateTime _dateTime = DateTime(
                      times[_shiftStart]?.year ?? DateTime.now().year,
                      times[_shiftStart]?.month ?? DateTime.now().month,
                      times[_shiftStart]?.day ?? DateTime.now().day,
                      startTime.hour,
                      startTime.minute,
                    );
                    times[_shiftStart] = _dateTime;
                    print('initStartDate:: ${times[_shiftStart]}');
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TimeHintWidget(translate('END_TIME')),
            SizedBox(height: 12),
            Row(
              children: [
                DatePickerBoxWidget(
                  initialDate: times[_shiftEnd],
                  onDateSelected: (DateTime endDate) {
                    DateTime _dateTime = DateTime(
                      endDate.year,
                      endDate.month,
                      endDate.day,
                      times[_shiftEnd]?.hour ?? 0,
                      times[_shiftEnd]?.minute ?? 0,
                    );
                    times[_shiftEnd] = _dateTime;
                    print('_shiftEndDate:: ${times[_shiftEnd]}');
                  },
                ),
                SizedBox(width: 16),
                TimePickerBoxWidget(
                  initialDateTime: times[_shiftEnd],
                  onTimeSelected: (DateTime endTime) {
                    DateTime _dateTime = DateTime(
                      times[_shiftEnd]?.year ?? DateTime.now().year,
                      times[_shiftEnd]?.month ?? DateTime.now().month,
                      times[_shiftEnd]?.day ?? DateTime.now().day,
                      endTime.hour,
                      endTime.minute,
                    );
                    times[_shiftEnd] = _dateTime;
                    print('_shiftEndTime:: ${times[_shiftEnd]}');
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TimeHintWidget(translate('BREAK_TIME')),
            SizedBox(height: 12),
            Row(
              children: [
                BreakDurationBoxWidget(
                  initialTime: calculateBreakDuration(),
                  onTimeSelected: (TimeOfDay breakTime) {
                    breakDuration = Duration(
                      hours: breakTime.hour,
                      minutes: breakTime.minute,
                    );
                  },
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  validateInputs();
                },
                height: 40,
                child: Text(
                  translate("button.submit"),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: AppColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // <-- Radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TimeOfDay calculateBreakDuration() {
    try {
      Duration time = times[_breakEnd].difference(times[_breakStart]);
      if (time != Duration.zero) {
        print('BreakTime:: ${times[_breakEnd]} start ${times[_breakStart]}');
        print('time:: ${time.inHours} ${time.inMinutes % 60}');

        return TimeOfDay(hour: time.inHours, minute: time.inMinutes % 60);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void validateInputs() {
    if (times[_shiftStart] == null) {
      Get.snackbar('Start date required', '');
      return;
    }
    if (times[_shiftEnd] == null) {
      Get.snackbar('End date required', '');
      return;
    }
    times[_breakStart] = times[_shiftStart].add(
      Duration(
        hours: 2,
      ),
    );
    if (breakDuration != null) {
      times[_breakEnd] = times[_breakStart].add(
        Duration(
          hours: breakDuration.inHours,
          minutes: (breakDuration.inMinutes % 60),
        ),
      );
    }
    Get.back(result: times);
  }
}
