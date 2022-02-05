import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/models/worktype_model.dart';
import 'package:piiprent/services/skill_activity_service.dart';
import 'package:piiprent/services/worktype_service.dart';
import 'package:piiprent/widgets/form_field.dart';
import 'package:piiprent/widgets/form_message.dart';
import 'package:piiprent/widgets/form_select.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/page_container.dart';
import 'package:provider/provider.dart';

class CandidateSkillActivityScreenOld extends StatefulWidget {
  final String timesheet;
  final String skill;
  final String companyId;

  CandidateSkillActivityScreenOld({
    this.timesheet,
    this.skill,
    this.companyId,
  });

  @override
  _CandidateSkillActivityScreenOldState createState() =>
      _CandidateSkillActivityScreenOldState();
}

class _CandidateSkillActivityScreenOldState
    extends State<CandidateSkillActivityScreenOld> {
  String _worktype;
  String _rate;
  double _value;

  bool _fetching = false;
  String _error;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onSubmit(SkillActivityService service, context) async {
    // TODO: add more validation
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    setState(() {
      _fetching = true;
      _error = null;
    });

    try {
      //TODO pass value accroding isedit or not
      // await service.createSkillActivity(SkillActivityBody(
      //   rate: double.parse(_rate),
      //   worktype: _worktype,
      //   value: _value,
      //   timesheet: widget.timesheet,
      //   skill: widget.skill,
      // ));

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
  Widget build(BuildContext context) {
    SkillActivityService skillActivityService =
        Provider.of<SkillActivityService>(context);
    WorktypeService worktypeService = Provider.of<WorktypeService>(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return Scaffold(
      appBar:
          AppBar(title: Text(translate('page.title.create_skill_activity'))),
      body: SingleChildScrollView(
        child: PageContainer(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FutureBuilder(
                  future: worktypeService.getSkillWorktypes({
                    'skill': widget.skill,
                    'company': widget.companyId,
                    'priced': 'true'
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Worktype> data = snapshot.data;

                      return FormSelect(
                        multiple: false,
                        title: translate('field.skill_activity'),
                        columns: 1,
                        onChanged: (String id) {
                          _worktype = id;
                          var el =
                              data.firstWhere((element) => element.id == id);
                          _rate = el.defaultRate;
                        },
                        options: data.map((Worktype el) {
                          return Option(
                            value: el.id,
                            title: el.name(localizationDelegate.currentLocale),
                          );
                        }).toList(),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Field(
                  label: translate('field.skill_activity_amount'),
                  type: TextInputType.number,
                  onSaved: (String value) {
                    _value = double.parse(value);
                  },
                ),
                FormMessage(
                  type: MessageType.Error,
                  message: _error,
                ),
                SizedBox(
                  height: 15.0,
                ),
                FormSubmitButton(
                  disabled: _fetching,
                  onPressed: () {
                    _onSubmit(skillActivityService, context);
                  },
                  label: translate('button.submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
