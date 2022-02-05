import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/models/skill_activity_model.dart';
import 'package:piiprent/models/worktype_model.dart';
import 'package:piiprent/services/skill_activity_service.dart';
import 'package:piiprent/services/worktype_service.dart';
import 'package:piiprent/widgets/form_message.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:provider/provider.dart';

class CandidateSkillActivityScreen extends StatefulWidget {
  final String timesheet;
  final String skill;
  final String companyId;
  final SkillActivity skillActivityModel;

  CandidateSkillActivityScreen(
      {this.timesheet, this.skill, this.companyId, this.skillActivityModel});

  @override
  _CandidateSkillActivityScreenState createState() =>
      _CandidateSkillActivityScreenState();
}

class _CandidateSkillActivityScreenState
    extends State<CandidateSkillActivityScreen> {
  String _worktype;
  String _rate;
  double _value;
  String hint = translate("Activity");

  bool _fetching = false;
  String _error;
  List<Worktype> data = [];
  var amountTextController = TextEditingController();

  _onSubmit(SkillActivityService service, context) async {
    if (_worktype == null) {
      Get.snackbar('Select Activity', '');
      return;
    }

    if (_value == null) {
      Get.snackbar('Enter Amount', '');
      return;
    }

    setState(() {
      _fetching = true;
      _error = null;
    });

    try {
      await service.createSkillActivity(
          SkillActivityBody(
            rate: double.parse(_rate),
            worktype: _worktype,
            value: _value,
            timesheet: widget.timesheet,
            skill: widget.skillActivityModel == null ? widget.skill : null,
          ),
          widget.skillActivityModel);
      Navigator.pop(context, true);
    } catch (err) {
      setState(() {
        _error = err.message;
      });
    } finally {
      setState(() {
        _fetching = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    callActivityList();
    super.didChangeDependencies();
  }

  void setData(List<Worktype> data) {
    if (widget.skillActivityModel != null) {
      _worktype = data
          .firstWhere(
              (element) => element.id == widget.skillActivityModel.worktype.id)
          .id;
      var el = data.firstWhere(
          (element) => element.id == widget.skillActivityModel.worktype.id);
      _rate = el.defaultRate;
      hint = data
          .firstWhere(
              (element) => element.id == widget.skillActivityModel.worktype.id)
          .name(LocalizedApp.of(context).delegate.currentLocale);
      if (widget.skillActivityModel.value != null) {
        amountTextController.text = widget.skillActivityModel.value.toString();
      }
      setState(() {});
    }
  }

  callActivityList() async {
    _fetching = true;
    setState(() {});
    var temp = await Provider.of<WorktypeService>(context).getSkillWorktypes(
        {'skill': widget.skill, 'company': widget.companyId, 'priced': 'true'});
    if (temp != null) {
      data.clear();
      var temp2 = temp as List<Worktype>;
      data.addAll(temp2);
    }
    _fetching = false;
    setState(() {});
    setData(data);
  }

  @override
  Widget build(BuildContext context) {
    SkillActivityService skillActivityService =
        Provider.of<SkillActivityService>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
        appBar: AppBar(
            title: Text(translate('page.title.create_skill_activity')),
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
                  _onSubmit(skillActivityService, context);
                },
              ),
            ]),
        body: _fetching
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xffEEF6FF),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffD3DEEA),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0), //         <--- border radius here
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text(
                        hint,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      items: data.map((e) {
                        return DropdownMenuItem(
                            child: Text(
                                e.name(localizationDelegate.currentLocale)),
                            value: e.id);
                      }).toList(),
                      onChanged: (value) {
                        _worktype = value;
                        var el =
                            data.firstWhere((element) => element.id == value);
                        _rate = el.defaultRate;
                        hint = data
                            .firstWhere((element) => element.id == value)
                            .name(localizationDelegate.currentLocale);
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xffEEF6FF),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffD3DEEA),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              5.0), //         <--- border radius here
                        ),
                      ),
                      child: TextFormField(
                        onChanged: (String value) {
                          _value = double.parse(value);
                        },
                        controller: amountTextController,
                        decoration: InputDecoration(
                            hintText: translate('field.skill_activity_amount'),
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                  FormMessage(
                    type: MessageType.Error,
                    message: _error,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: FormSubmitButton(
                      label: translate('button.submit'),
                      onPressed: () {
                        _onSubmit(skillActivityService, context);
                      },
                      disabled: _fetching,
                    ),
                  )
                ],
              )
    );
  }
}
