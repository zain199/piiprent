import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/constants.dart';
import 'package:piiprent/helpers/validator.dart';
import 'package:piiprent/models/average_scores_model.dart';
import 'package:piiprent/models/candidate_model.dart';
import 'package:piiprent/models/candidate_skill_model.dart';
import 'package:piiprent/models/candidate_tag_model.dart';
import 'package:piiprent/screens/change_password_screen.dart';
import 'package:piiprent/services/candidate_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/widgets/candidate_app_bar.dart';
import 'package:piiprent/widgets/form_field.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/page_container.dart';
import 'package:piiprent/widgets/profile_group.dart';
import 'package:piiprent/widgets/score_badge.dart';
import 'package:piiprent/widgets/stars.dart';
import 'package:provider/provider.dart';

class CandidateProfileScreen extends StatefulWidget {
  const CandidateProfileScreen({Key key}) : super(key: key);

  @override
  _CandidateProfileScreenState createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  int _height;
  int _weight;
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  bool _fetching = false;
  dynamic _formError;
  Map<String, bool> _editMap = {
    'details': false,
    'skills': false,
    'contact': false,
  };
  final GlobalKey<FormState> _detailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Uint8List _imageBytes;

  _onTapImage(
    CandidateService candidateService,
    Candidate candidate,
    BuildContext context,
  ) async {
    print('called');
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      final picture = 'data:image/jpeg;base64,${base64.encode(bytes)}';
      final String contactId = candidate.contact.id;

      final result = await candidateService.updatePicture(
        contactId: contactId,
        title: candidate.contact.title ?? '',
        birthday: candidate.contact.birthday ?? '',
        firstName: _firstName == null ? candidate.firstName : _firstName,
        lastName: _lastName == null ? candidate.lastName : _lastName,
        email: _email == null ? candidate.email : _email,
        phoneMobile: _phoneNumber == null ? candidate.phone : _phoneNumber,
        picture: picture,
      );

      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[400],
            content: const Text(
              'Avatar updated',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );

        setState(() {
          _imageBytes = bytes;
        });
      }
    }
  }

  _onSavePersonalDetails(
    CandidateService candidateService,
    Candidate candidate,
  ) async {
    String id = candidate.id;
    String contactId = candidate.contact.id;

    if (!_detailsFormKey.currentState.validate() ||
        !_contactFormKey.currentState.validate()) {
      return;
    }

    _detailsFormKey.currentState.save();
    _contactFormKey.currentState.save();

    setState(() {
      _fetching = true;
      _formError = null;
    });

    try {
      bool result = await candidateService.updatePersonalDetails(
        id: id,
        contactId: contactId,
        height: _height == null ? candidate.height : _height,
        weight: _weight == null ? candidate.weight : _weight,
        firstName: _firstName == null ? candidate.firstName : _firstName,
        lastName: _lastName == null ? candidate.lastName : _lastName,
        email: _email == null ? candidate.email : _email,
        phoneMobile: _phoneNumber == null ? candidate.phone : _phoneNumber,
      );

      if (result) {
        setState(() {
          _editMap['details'] = false;
          _editMap['contact'] = false;
        });
      }
    } catch (e) {
      setState(() {
        _formError = e;
      });
    } finally {
      setState(() {
        _fetching = false;
      });
    }
  }

  Widget _listItem({Widget child}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[700],
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: child,
    );
  }

  Widget _buildPersonalDetails(
    Candidate candidate, [
    bool edit = false,
    Function onEdit,
  ]) {
    CandidateService candidateService = Provider.of<CandidateService>(context);

    return ProfileGroup(
      title: translate('group.title.personal_details'),
      content: [
        Row(
          children: [
            Expanded(
              child: Field(
                label: translate('field.first_name'),
                initialValue: candidate.firstName,
                readOnly: !edit,
                onChanged: (String value) {
                  setState(() {
                    _firstName = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Field(
                label: translate('field.last_name'),
                initialValue: candidate.lastName,
                readOnly: !edit,
                onChanged: (String value) {
                  setState(() {
                    _lastName = value;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Field(
                label: translate('field.height'),
                type: TextInputType.number,
                initialValue: candidate.height.toString(),
                readOnly: !edit,
                validator: numberValidator,
                onChanged: (String value) {
                  setState(() {
                    _height = int.parse(value);
                  });
                },
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Field(
                label: translate('field.weight'),
                initialValue: candidate.weight.toString(),
                readOnly: !edit,
                validator: numberValidator,
                onChanged: (String value) {
                  setState(() {
                    _weight = int.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
        Container(
          child: Field(
            label: translate('field.bmi'),
            initialValue: candidate.bmi,
            readOnly: true,
          ),
        ),
        Container(
          child: Field(
            label: translate('field.birthday'),
            initialValue: DateFormat('dd/MM/yyyy').format(candidate.birthday),
            readOnly: true,
          ),
        ),
        edit
            ? FormSubmitButton(
                disabled: _fetching,
                onPressed: () => _onSavePersonalDetails(
                  candidateService,
                  candidate,
                ),
                label: translate('button.update'),
              )
            : FormSubmitButton(
                disabled: _fetching,
                onPressed: onEdit,
                label: translate('button.edit'),
              ),
      ],
    );
  }

  Widget _buildContactDetails(
    Candidate candidate, [
    bool edit = false,
    Function onEdit,
  ]) {
    CandidateService candidateService = Provider.of<CandidateService>(context);

    return ProfileGroup(
      title: translate('group.title.contact_details'),
      content: [
        Container(
          child: Field(
            label: translate('field.email'),
            initialValue: candidate.email,
            readOnly: !edit,
            onChanged: (String value) {
              setState(() {
                _email = value;
              });
            },
          ),
        ),
        Container(
          child: Field(
            label: translate('field.phone'),
            initialValue: candidate.phone,
            readOnly: !edit,
            onChanged: (String value) {
              setState(() {
                _phoneNumber = value;
              });
            },
          ),
        ),
        Container(
          child: Field(
            label: translate('field.address'),
            initialValue: candidate.address,
            readOnly: true,
          ),
        ),
        edit
            ? FormSubmitButton(
                disabled: _fetching,
                onPressed: () => _onSavePersonalDetails(
                  candidateService,
                  candidate,
                ),
                label: translate('button.update'),
              )
            : FormSubmitButton(
                disabled: _fetching,
                onPressed: onEdit,
                label: translate('button.edit'),
              ),
      ],
    );
  }

  Widget _buildSkills(List<CandidateSkill> skills) {
    return ProfileGroup(
      title: translate('group.title.skills'),
      onEdit: () {},
      canEdit: false,
      content: skills
          .map(
            (e) => _listItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.skill.name),
                  ScoreBadge(score: e.score),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildScore(AverageScores averageScores) {
    return ProfileGroup(
      title: translate('group.title.score'),
      content: [
        _listItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate('skill.average_test')),
              Stars(
                active: averageScores.recruitmentScore,
              )
            ],
          ),
        ),
        _listItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate('skill.client_feedback')),
              Stars(
                active: averageScores.clientFeedback,
              )
            ],
          ),
        ),
        _listItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate('skill.reliability')),
              Stars(
                active: averageScores.reliability,
              )
            ],
          ),
        ),
        _listItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate('skill.loyality')),
              Stars(
                active: averageScores.loyality,
              )
            ],
          ),
        ),
        _listItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate('skill.avarage_skill')),
              Stars(
                active: averageScores.skillScore,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResidency(Candidate candidate) {
    return ProfileGroup(
      title: translate('group.title.residency'),
      content: [
        Row(
          children: [
            Expanded(
              child: Field(
                label: translate('field.residency_status'),
                initialValue: candidate.residency != null
                    ? Residency[candidate.residency]
                    : '',
                readOnly: true,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Field(
                label: translate('field.nationality'),
                initialValue: candidate.nationality,
                readOnly: true,
              ),
            ),
          ],
        ),
        candidate.residency == 3
            ? Row(
                children: [
                  Expanded(
                    child: Field(
                      label: translate('field.visa_type'),
                      initialValue: candidate.visaType,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Field(
                      label: translate('field.visa_expire_date'),
                      initialValue: candidate.visaExpiryDate != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(candidate.visaExpiryDate)
                          : '',
                      readOnly: true,
                    ),
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildTags(List<CandidateTag> tags) {
    return ProfileGroup(
      title: translate('group.title.tags'),
      content: tags
          .map(
            (e) => _listItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.tag.name),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    CandidateService candidateService = Provider.of<CandidateService>(context);
    LoginService loginService = Provider.of<LoginService>(context);

    return Scaffold(
      appBar: getCandidateAppBar(translate('page.title.profile'), context),
      body: FutureBuilder(
        future: candidateService.getCandidate(loginService.user.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Candidate candidate = snapshot.data;
          return SingleChildScrollView(
            child: PageContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => _onTapImage(
                        candidateService,
                        candidate,
                        context,
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                          image: candidate.contact.userAvatarUrl() != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _imageBytes != null
                                      ? MemoryImage(_imageBytes)
                                      : NetworkImage(
                                          candidate.contact.userAvatarUrl(),
                                        ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${candidate.firstName} ${candidate.lastName}',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18.0,
                        ),
                      ),
                      ScoreBadge(
                        score: candidate.averageScore,
                      )
                    ],
                  ),
                  Center(
                    child: Text(
                      candidate.address,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      candidate.designation,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Form(
                    key: _detailsFormKey,
                    child: _buildPersonalDetails(
                      candidate,
                      _editMap['details'],
                      () {
                        bool isEdit = _editMap['details'];
                        setState(
                          () {
                            _editMap['details'] = !isEdit;
                            _editMap = _editMap;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Form(
                    key: _contactFormKey,
                    child: _buildContactDetails(
                      candidate,
                      _editMap['contact'],
                      () {
                        bool isEdit = _editMap['contact'];
                        setState(
                          () {
                            _editMap['contact'] = !isEdit;
                            _editMap = _editMap;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildSkills(candidate.skills),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildScore(candidate.averageScores),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildResidency(candidate),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildTags(candidate.tags),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      translate('button.change_password'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
