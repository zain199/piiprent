import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/models/timesheet_model.dart';
import 'package:piiprent/screens/client_timesheet_details_screen.dart';
import 'package:piiprent/widgets/list_card.dart';
import 'package:piiprent/widgets/list_card_record.dart';

class ClientTimesheetCard extends StatelessWidget {
  final Timesheet timesheet;
  final Function update;

  ClientTimesheetCard({
    this.timesheet,
    this.update,
  });

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return GestureDetector(
      onTap: () async {
        var result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ClientTimesheetDetailsScreen(
              timesheet: timesheet,
            ),
          ),
        );

        if (result) {
          update();
        }
      },
      child: ListCard(
        header: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    image: timesheet.candidateAvatarUrl != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(timesheet.candidateAvatarUrl),
                          )
                        : null,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timesheet.candidateName,
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                Text(
                  "${translate('timesheet.position')} - ${timesheet.position(localizationDelegate.currentLocale)}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14.0,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        timesheet.score,
                        style: TextStyle(color: Colors.amber),
                      )
                    ],
                  ),
                ),
                timesheet.signatureScheme && timesheet.status == 5
                    ? Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "(${translate('timesheet.signature_required')})",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
        body: Column(
          children: [
            ListCardRecord(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('timesheet.shift_started_at'),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  Row(
                    children: [
                      Text(
                        timesheet.shiftStart != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(timesheet.shiftStart)
                            : '-',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        timesheet.shiftStart != null
                            ? DateFormat.jm().format(timesheet.shiftStart)
                            : '-',
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  )
                ],
              ),
            ),
            ListCardRecord(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('timesheet.break'),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  Row(
                    children: [
                      Text(
                        timesheet.breakStart != null
                            ? DateFormat.jm().format(timesheet.breakStart)
                            : '-',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        translate('timesheet.break_to'),
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        timesheet.breakEnd != null
                            ? DateFormat.jm().format(timesheet.breakEnd)
                            : '-',
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  )
                ],
              ),
            ),
            ListCardRecord(
              last: true,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('timesheet.shift_ended_at'),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  Row(
                    children: [
                      Text(
                        timesheet.shiftEnd != null
                            ? DateFormat.jm().format(timesheet.shiftEnd)
                            : '-',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
