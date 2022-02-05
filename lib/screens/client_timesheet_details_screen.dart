import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/constants.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/models/timesheet_model.dart';
import 'package:piiprent/models/tracking_model.dart';
import 'package:piiprent/services/skill_activity_service.dart';
import 'package:piiprent/services/timesheet_service.dart';
import 'package:piiprent/widgets/client_app_bar.dart';
import 'package:piiprent/widgets/details_record.dart';
import 'package:piiprent/widgets/evaluate.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/group_title.dart';
import 'package:piiprent/widgets/skill_activity_table_old.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class ClientTimesheetDetailsScreen extends StatefulWidget {
  final Timesheet timesheet;

  ClientTimesheetDetailsScreen({
    this.timesheet,
  });

  @override
  _ClientTimesheetDetailsScreenState createState() =>
      _ClientTimesheetDetailsScreenState();
}

class _ClientTimesheetDetailsScreenState
    extends State<ClientTimesheetDetailsScreen> {
  String _shiftStart = TimesheetTimeKey[TimesheetTime.Start];
  String _breakStart = TimesheetTimeKey[TimesheetTime.BreakStart];
  String _breakEnd = TimesheetTimeKey[TimesheetTime.BreakEnd];
  String _shiftEnd = TimesheetTimeKey[TimesheetTime.End];
  bool _updated = false;
  bool _fetching = false;
  bool _changed = false;
  bool _evaluated = true;
  int _evaluationScore = 1;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final StreamController _signatureStream = StreamController();

  Map<String, DateTime> _times = Map();

  @override
  void initState() {
    _times = {
      _shiftStart: widget.timesheet.shiftStart,
      _breakStart: widget.timesheet.breakStart,
      _breakEnd: widget.timesheet.breakEnd,
      _shiftEnd: widget.timesheet.shiftEnd
    };
    _controller.addListener(() {
      _signatureStream.add(_controller.isEmpty);
    });
    _evaluated = widget.timesheet.evaluated;
    _evaluationScore = widget.timesheet.evaluation;
    super.initState();
  }

  _changeTime(DateTime time, String key) {
    setState(() {
      _changed = true;
      _times[key] = time;
    });
  }

  _submitForm(TimesheetService timesheetService,
      SignatureController signatureContoller) async {
    try {
      setState(() => _fetching = true);
      Map<String, String> body = _times.map((key, value) =>
          MapEntry(key, value != null ? value.toUtc().toString() : null));
      final data = await signatureContoller.toPngBytes();
      String img64 = base64.encode(data);

      if (widget.timesheet.signatureScheme) {
        body.addAll({'supervisor_signature': img64});
      }

      bool result = await timesheetService.approveTimesheet(
        widget.timesheet.id,
        body,
        _changed,
      );

      setState(() => _updated = result);
    } catch (e) {
      print(e);
    } finally {
      setState(() => _fetching = false);
    }
  }

  _evaluate(TimesheetService timesheetService, int score) async {
    try {
      bool result = await timesheetService.evaluate(
        widget.timesheet.id,
        score,
      );

      setState(() {
        _evaluated = result;
        _evaluationScore = score;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _fetching = false);
    }
  }

  Widget _buildChangeButton(DateTime date, String key) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.edit,
            size: 18.0,
            color: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              translate('button.change'),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(date),
        ).then((time) {
          int hours = time.hour - date.hour;
          int minutes = time.minute - date.minute;

          if (hours > 0) {
            date = date.add(Duration(hours: hours.abs()));
          }

          if (hours < 0) {
            date = date.subtract(Duration(hours: hours.abs()));
          }

          if (minutes > 0) {
            date = date.add(Duration(minutes: minutes.abs()));
          }

          if (minutes < 0) {
            date = date.subtract(Duration(minutes: minutes.abs()));
          }

          _changeTime(
            date,
            key,
          );
        });
      },
    );
  }

  Widget _buildSignatureBlock() {
    if (_updated) {
      return Container();
    }

    if (widget.timesheet.signatureScheme && widget.timesheet.status == 5) {
      return Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            GroupTitle(title: translate('group.title.signature')),
            Signature(
              controller: _controller,
              width: 309,
              height: 149,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _controller.clear(),
              child: Text(translate('button.clear')),
            )
          ],
        ),
      );
    }

    if (widget.timesheet.signatureScheme && widget.timesheet.status != 5) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 309,
        height: 149,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            style: BorderStyle.solid,
          ),
          image: widget.timesheet.signatureUrl != null
              ? DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    widget.timesheet.signatureUrl,
                  ),
                )
              : null,
        ),
      );
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    TimesheetService timesheetService = Provider.of<TimesheetService>(context);
    SkillActivityService skillActivityService =
        Provider.of<SkillActivityService>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar: getClientAppBar(
        translate('page.title.timesheet'),
        context,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 36.0,
              ),
              onPressed: () {
                Navigator.pop(context,
                    _updated || (_evaluated != widget.timesheet.evaluated));
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: widget.timesheet.candidateAvatarUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.timesheet.candidateAvatarUrl,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.timesheet.candidateName,
                style: TextStyle(fontSize: 22.0, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.timesheet.position(localizationDelegate.currentLocale),
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              GroupTitle(title: translate('group.title.times')),
              DetailsRecord(
                label: translate('field.shift_date'),
                value: _times[_shiftStart] != null
                    ? DateFormat('dd/MM/yyyy').format(_times[_shiftStart])
                    : '-',
              ),
              DetailsRecord(
                label: translate('field.shift_start_time'),
                value: _times[_shiftStart] != null
                    ? DateFormat.jm().format(_times[_shiftStart])
                    : '-',
                button: widget.timesheet.status == 5 && !_updated
                    ? _buildChangeButton(
                        _times[_shiftStart],
                        _shiftStart,
                      )
                    : null,
              ),
              DetailsRecord(
                label: translate('field.break_start_time'),
                value: _times[_breakStart] != null
                    ? DateFormat.jm().format(_times[_breakStart])
                    : '-',
                button: widget.timesheet.status == 5 && !_updated
                    ? _buildChangeButton(
                        _times[_breakStart],
                        _breakStart,
                      )
                    : null,
              ),
              DetailsRecord(
                label: translate('field.break_end_time'),
                value: _times[_breakEnd] != null
                    ? DateFormat.jm().format(_times[_breakEnd])
                    : '-',
                button: widget.timesheet.status == 5 && !_updated
                    ? _buildChangeButton(
                        _times[_breakEnd],
                        _breakEnd,
                      )
                    : null,
              ),
              DetailsRecord(
                label: translate('field.shift_end_time'),
                value: _times[_shiftEnd] != null
                    ? DateFormat.jm().format(_times[_shiftEnd])
                    : '-',
                button: widget.timesheet.status == 5 && !_updated
                    ? _buildChangeButton(
                        _times[_shiftEnd],
                        _shiftEnd,
                      )
                    : null,
              ),
              DetailsRecord(
                label: translate('field.jobsite'),
                value: widget.timesheet.jobsite,
              ),
              Evaluate(
                active: !_evaluated,
                score: _evaluationScore,
                onChange: (score) {
                  _evaluate(timesheetService, score);
                },
              ),
              SkillActivityTableOld(
                hasActions: widget.timesheet.status == 5 && !_updated,
                service: skillActivityService,
                skill: widget.timesheet.positionId,
                timesheet: widget.timesheet.id,
                companyId: widget.timesheet.clientId,
              ),
              GroupTitle(title: translate('group.title.tracking')),
              FutureBuilder(
                future: timesheetService.getTrackingData(
                  widget.timesheet.candidateId,
                  widget.timesheet.id,
                ),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Tracking>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(child: Text(translate('message.no_data')));
                    }

                    double latitude = snapshot.data[0].latitude;
                    double longitude = snapshot.data[0].longitude;
                    Set<Polyline> polylines = Set();
                    polylines.add(
                      Polyline(
                        polylineId: PolylineId('tracking'),
                        color: Colors.blue,
                        width: 2,
                        points: snapshot.data
                            .map((e) => LatLng(
                                  e.latitude,
                                  e.longitude,
                                ))
                            .toList(),
                      ),
                    );

                    return SizedBox(
                      height: 350.0,
                      width: 20.0,
                      child: GoogleMap(
                        cameraTargetBounds: CameraTargetBounds.unbounded,
                        indoorViewEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            latitude,
                            longitude,
                          ),
                          zoom: 10.0,
                        ),
                        myLocationButtonEnabled: false,
                        polylines: polylines,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              _buildSignatureBlock(),
              widget.timesheet.status == 5 && !_updated
                  ? StreamBuilder(
                      stream: _signatureStream.stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        return FormSubmitButton(
                          label: translate('button.submit'),
                          onPressed: () => _submitForm(
                            timesheetService,
                            _controller,
                          ),
                          disabled: _fetching ||
                              (widget.timesheet.signatureScheme &&
                                  snapshot.data),
                        );
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
