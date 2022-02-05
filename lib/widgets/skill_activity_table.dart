import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piiprent/helpers/colors.dart';
import 'package:piiprent/models/skill_activity_model.dart';
import 'package:piiprent/screens/candidate_skill_activity_screen.dart';
import 'package:piiprent/screens/timesheets_details/widgets/time_add_widget.dart';
import 'package:piiprent/services/skill_activity_service.dart';

class SkillActivityTable extends StatefulWidget {
  final bool hasActions;
  final String timesheet;
  final String skill;
  final SkillActivityService service;
  final String companyId;

  SkillActivityTable({
    this.hasActions,
    this.timesheet,
    this.skill,
    this.service,
    this.companyId,
  });

  @override
  _SkillActivityTableState createState() => _SkillActivityTableState();
}

class _SkillActivityTableState extends State<SkillActivityTable> {
  final StreamController<List<SkillActivity>> _streamController =
      StreamController();

  bool _fetching = true;
  bool _error;

  @override
  void initState() {
    super.initState();

    getSkillActivities();
  }

  void getSkillActivities() async {
    setState(() {
      _fetching = true;
    });

    try {
      List<SkillActivity> data =
          await widget.service.getSkillActivitiesByTimesheet({
        'timesheet': widget.timesheet,
        'skill': widget.skill,
      });


      setState(() {
        _fetching = false;
        _error = null;
      });

      _streamController.add(data);
    } catch (e) {
      setState(() {
        _error = true;
        _fetching = false;
      });
    }
  }

  void deleteSkillActivity(String id) async {
    setState(() {
      _fetching = true;
    });

    try {
      await widget.service.removeSkillActivity(id);

      getSkillActivities();
    } catch (e) {
      setState(() {
        _fetching = false;
        _error = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<SkillActivity> data = snapshot.data;
          return _fetching
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    widget.hasActions
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translate("Activity"),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                  color: AppColors.lightBlack,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CandidateSkillActivityScreen(
                                              skill: widget.skill,
                                              timesheet: widget.timesheet,
                                              companyId: widget.companyId),
                                    ),
                                  )
                                      .then((dynamic result) {
                                    if (result == true) {
                                      getSkillActivities();
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.blue,
                                        size: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      'ADD',
                                      style: TextStyle(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) => Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[index].worktype != null
                                  ? data[index].worktype.name == null
                                      ? ""
                                      : data[index].worktype.name(
                                          localizationDelegate.currentLocale)
                                  : "",
                              style: TextStyle(
                                color: AppColors.lightBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            widget.hasActions
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CandidateSkillActivityScreen(
                                                        timesheet:
                                                            widget.timesheet,
                                                        skill: widget.skill,
                                                        companyId:
                                                            widget.companyId,
                                                        skillActivityModel:
                                                            data[index]),
                                              ),
                                            )
                                                .then((dynamic result) {
                                              if (result == true) {
                                                getSkillActivities();
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: AppColors.green,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 3.0,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (!_fetching) {
                                              deleteSkillActivity(
                                                  data[index].id);
                                            }
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                        SizedBox(height: 20),
                        TimeAddWidget(translate('AMOUNT'), data[index].value.toString())
                      ]),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: data.length,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _error != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              translate('message.has_error'),
                              style: TextStyle(color: Colors.red[400]),
                            ),
                          )
                        : SizedBox()
                  ],
                );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
