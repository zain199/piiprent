import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/helpers/validator.dart';
import 'package:piiprent/models/application_form_model.dart';
import 'package:piiprent/models/async_dropdown_option.dart';
import 'package:piiprent/models/country_model.dart';
import 'package:piiprent/models/industry_model.dart';
import 'package:piiprent/models/settings_model.dart';
import 'package:piiprent/models/skill_model.dart';
import 'package:piiprent/models/tag_model.dart';
import 'package:piiprent/services/company_service.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/country_service.dart';
import 'package:piiprent/services/industry_service.dart';
import 'package:piiprent/services/tag_service.dart';
import 'package:piiprent/widgets/address_field.dart';
import 'package:piiprent/widgets/async_dropdown.dart';
import 'package:piiprent/widgets/form_field.dart';
import 'package:piiprent/widgets/form_message.dart';
import 'package:piiprent/widgets/form_select.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/picture_field.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final Settings settings;
  final GlobalKey key;

  RegisterForm({
    this.key,
    this.settings,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String _title;
  String _gender;
  String _residency;
  String _nationality;
  String _transport;
  String _height;
  String _weight;
  String _bankAccountName;
  String _bankName;
  String _iban;
  List<dynamic> _tags;
  String _firstName;
  String _lastName;
  String _email;
  String _phone;
  String _birthday;
  String _industry;
  String _personalId;
  String _picture;
  List<dynamic> _skills;
  CountryCode _phoneCountryCode;
  Map<String, dynamic> _address;
  bool _registered = false;

  final StreamController _industryStream = StreamController();
  final StreamController _fetchingStream = StreamController();
  final StreamController _errorStream = StreamController();

  List<Option> titleOptions = [
    const Option(value: 'Mr.', title: 'Mr.'),
    const Option(value: 'Ms.', title: 'Ms.'),
    const Option(value: 'Mrs.', title: 'Mrs.'),
    const Option(value: 'Dr.', title: 'Dr.'),
  ];

  List<Option> genderOptions = [
    const Option(
      value: 'male',
      title: 'Male',
      translateKey: 'gender.male',
    ),
    const Option(
      value: 'female',
      title: 'Female',
      translateKey: 'gender.female',
    ),
  ];

  List<AsyncDropdownOption> residencyOptions = [
    const AsyncDropdownOption(
      id: '0',
      label: 'Unknown',
      translateKey: 'residency.unknown',
    ),
    const AsyncDropdownOption(
      id: '1',
      label: 'Citizen',
      translateKey: 'residency.citizen',
    ),
    const AsyncDropdownOption(
      id: '2',
      label: 'Permanent Resident',
      translateKey: 'residency.permanent_resident',
    ),
    const AsyncDropdownOption(
      id: '3',
      label: 'Temporary Resident',
      translateKey: 'residency.temporary_resident',
    ),
  ];

  List<Widget> _fields = [];

  List<Option> transportationOptions = [
    const Option(
      value: "1",
      title: "Own Car",
      translateKey: 'transport.own_car',
    ),
    const Option(
      value: "2",
      title: "Public Transportation",
      translateKey: 'transport.public',
    )
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _configFetching = true;

  CompanyService companyService;
  CountryService countryService;
  IndustryService industryService;

  Future _generateFields() async {
    try {
      ApplicationForm form = await this
          .companyService
          .getApplicationFormSettings(widget.settings.formId);

      setState(() {
        this._fields = [
          if (form.isExist(['contact.picture']))
            _buildPictureField(
              context,
              form.isRequired('contact.picture'),
            ),
          if (form.isExist(['contact.title']))
            _buildTitleField(
              context,
              form.isRequired('contact.title'),
            ),
          if (form.isExist(['contact.first_name', 'contact.last_name']))
            Row(
              children: [
                if (form.isExist(['contact.first_name']))
                  _buildFirstNameField(
                    context,
                    form.isRequired('contact.first_name'),
                  ),
                if (form.isExist(['contact.last_name']))
                  _buildLastNameField(
                    context,
                    form.isRequired('contact.last_name'),
                  )
              ],
            ),
          if (form.isExist(['contact.gender']))
            _buildGenderField(
              context,
              form.isRequired('contact.gender'),
            ),
          if (form.isExist(['contact.email']))
            _buildEmailField(
              context,
              form.isRequired('contact.email'),
            ),
          if (form.isExist(['contact.phone_mobile']))
            _buildPhoneNumberField(
                context, form.isRequired('contact.phone_mobile')),
          if (form.isExist(['contact.birthday']))
            _buildBirthdayField(
              context,
              form.isRequired('contact.birthday'),
            ),
          if (form.isExist(['contact.address.street_address']))
            _buildAddressField(
              context,
              form.isRequired('contact.address.street_address'),
            ),
          if (form.isExist(['nationality']))
            _buildNationalityField(
              context,
              form.isRequired('nationality'),
            ),
          if (form.isExist(['residency']))
            _buildResidencyField(
              context,
              form.isRequired('residency'),
            ),
          if (form.isExist(['transportation_to_work']))
            _transportationToWorkField(
              context,
              form.isRequired('transportation_to_work'),
            ),
          if (form.isExist(['height', 'weight']))
            Row(
              children: [
                if (form.isExist(['height']))
                  _buildHeightField(
                    context,
                    form.isRequired('height'),
                  ),
                if (form.isExist(['weight']))
                  _buildWeightField(
                    context,
                    form.isRequired('weight'),
                  )
              ],
            ),
          if (form.isExist(['skill']))
            _buildIndustryField(
              context,
              form.isRequired('skill'),
            ),
          if (form.isExist(['skill']))
            _buildSkillField(
              context,
              form.isRequired('skill'),
            ),
          if (form.isExist(['tag']))
            _buildTagField(context, form.isRequired('tag')),
          if (form.isExist(['contact.bank_accounts.AccountholdersName']))
            _buildBankAccountNameField(
              context,
              form.isRequired('contact.bank_accounts.AccountholdersName'),
            ),
          if (form.isExist(['contact.bank_accounts.bank_name']))
            _buildBankNameField(
              context,
              form.isRequired('contact.bank_accounts.bank_name'),
            ),
          if (form.isExist(['contact.bank_accounts.IBAN']))
            _buildIbanField(
              context,
              form.isRequired('contact.bank_accounts.IBAN'),
            ),
          if (form.isExist(['formalities.personal_id']))
            _buildPersonalIdField(
              context,
              form.isRequired('formalities.personal_id'),
            ),
        ];
        this._configFetching = false;
      });

      print(this._fields);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var context = widget.key.currentContext;
      this.companyService = Provider.of<CompanyService>(
        context,
        listen: false,
      );
      this.countryService = Provider.of<CountryService>(
        context,
        listen: false,
      );
      this.industryService = Provider.of<IndustryService>(
        context,
        listen: false,
      );

      this._generateFields();
    });
  }

  _register(ContactService contactService) async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    _fetchingStream.add(true);
    _errorStream.add(null);

    try {
      var result = await contactService.register(
        birthday: _birthday,
        email: _email,
        firstName: _firstName,
        lastName: _lastName,
        industry: _industry,
        phone: _phone,
        skills: _skills,
        title: _title,
        gender: _gender,
        residency: _residency,
        nationality: _nationality,
        transport: _transport,
        height: _height,
        weight: _weight,
        bankAccountName: _bankAccountName,
        bankName: _bankName,
        iban: _iban,
        tags: _tags,
        address: _address,
        personalId: _personalId,
        picture: _picture,
      );
      debugPrintThrottled("debug Image date : $_picture");
      if (result == true) {
        setState(() {
          _registered = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[400],
            content: const Text(
              'You are registered!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } catch (e) {
      _errorStream.add(e.toString());
      print("error: ${e.toString()}");
    } finally {
      _fetchingStream.add(false);
    }
  }

  Widget _buildPictureField(BuildContext context, bool isRequired) {
    return PictureField(
      label: translate('field.picture'),
      validator: isRequired == true ? requiredValidator : null,
      onSaved: (String val) {
        _picture = val;
        print("picture : $_picture");
      },
    );
  }

  Widget _buildTitleField(BuildContext context, bool isRequired) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: FormSelect(
            title: translate('field.title'),
            columns: 4,
            options: titleOptions,
            multiple: false,
            validator: isRequired == true ? requiredValidator : null,
            onSave: (Option title) {
              _title = title?.value;
              print("title:$_title");
            },
          ),
        )
      ],
    );
  }

  Widget _buildGenderField(BuildContext context, bool isRequired) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: FormSelect(
            title: translate('field.gender'),
            columns: 2,
            options: genderOptions,
            multiple: false,
            validator: isRequired == true ? requiredValidator : null,
            onSave: (Option gender) {
              _gender = gender?.value;
              print("gender:$_gender");
            },
          ),
        )
      ],
    );
  }

  Widget _buildFirstNameField(BuildContext context, bool isRequired) {
    return Expanded(
      flex: 2,
      child: Field(
        validator: isRequired == true ? requiredValidator : null,
        label: translate('field.first_name'),
        onSaved: (String value) {
          _firstName = value;
          print("firstname:$_firstName");
        },
      ),
    );
  }

  Widget _buildLastNameField(BuildContext context, bool isRequired) {
    return Expanded(
      flex: 2,
      child: Field(
        validator: isRequired == true ? requiredValidator : null,
        label: translate('field.last_name'),
        onSaved: (String value) {
          _lastName = value;
          print("lastname:$_lastName");
        },
      ),
    );
  }

  Widget _buildEmailField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.email'),
      onSaved: (String value) {
        _email = value;
        print("mail:$_email");
      },
    );
  }

  Widget _buildPhoneNumberField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.phone'),
      initialValue: '',
      onSaved: (String value) {
        _phone = '$_phoneCountryCode$value';
        print("phone :$_phone");
      },
      leading: widget.settings != null
          ? Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CountryCodePicker(
                onInit: (prefix) => _phoneCountryCode = prefix,
                onChanged: (prefix) =>
                    setState(() => _phoneCountryCode = prefix),
                initialSelection: widget.settings.countryCode,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
            )
          : SizedBox(),
    );
  }

  Widget _buildBirthdayField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.birthday'),
      datepicker: true,
      onSaved: (String value) {
        _birthday = value;
        print("Dbo:$_birthday");
      },
    );
  }

  Widget _buildNationalityField(BuildContext context, bool isRequired) {
    return AsyncDropdown<Country>(
      label: translate('field.nationality'),
      validator: isRequired == true ? requiredValidator : null,
      future: this.countryService.getCountries,
      renderFn: (Country item) => item.name,
      compareFn: (Country item, Country selectedItem) =>
          item.id == selectedItem.id,
      onSaved: (Country item) {
        _nationality = item?.id;
      },
    );
  }

  Widget _buildResidencyField(BuildContext context, bool isRequired) {
    return AsyncDropdown<AsyncDropdownOption>(
      label: translate('field.residency'),
      validator: isRequired == true ? requiredValidator : null,
      items: residencyOptions,
      renderFn: (AsyncDropdownOption item) => translate(item.name),
      compareFn: (AsyncDropdownOption item, AsyncDropdownOption selectedItem) =>
          item.id == selectedItem.id,
      onSaved: (AsyncDropdownOption item) {
        _residency = item?.id;
      },
    );
  }

  Widget _transportationToWorkField(BuildContext context, bool isRequired) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: FormSelect(
            title: translate('field.transport'),
            columns: 1,
            options: transportationOptions,
            multiple: false,
            validator: isRequired == true ? requiredValidator : null,
            onSave: (Option transport) {
              _transport = transport?.value;
              print("transport:$_transport");
            },
          ),
        )
      ],
    );
  }

  Widget _buildHeightField(BuildContext context, bool isRequired) {
    return Expanded(
      flex: 2,
      child: Field(
        validator: isRequired == true ? requiredValidator : null,
        label: translate('field.height'),
        onSaved: (String height) {
          _height = height;
          print("height:$_height");
        },
      ),
    );
  }

  Widget _buildWeightField(BuildContext context, bool isRequired) {
    return Expanded(
      flex: 2,
      child: Field(
        validator: isRequired == true ? requiredValidator : null,
        label: translate('field.weight'),
        onSaved: (String weight) {
          _weight = weight;
          print("weight:$_weight");
        },
      ),
    );
  }

  Widget _buildBankAccountNameField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.account_holders_name'),
      onSaved: (String value) {
        _bankAccountName = value;
        print("account name:$_bankAccountName");
      },
    );
  }

  Widget _buildBankNameField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.bank_name'),
      onSaved: (String value) {
        _bankName = value;
        print("bankname:$_bankName");
      },
    );
  }

  Widget _buildIbanField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.iban'),
      onSaved: (String value) {
        _iban = value;
        print("iban:$_iban");
      },
    );
  }

  Widget _buildPersonalIdField(BuildContext context, bool isRequired) {
    return Field(
      validator: isRequired == true ? requiredValidator : null,
      label: translate('field.personal_id'),
      onSaved: (String value) {
        _personalId = value;
        print(_personalId);
        print("personalid:$_personalId");
      },
    );
  }

  Widget _buildIndustryField(BuildContext context, bool isRequired) {
    return AsyncDropdown<Industry>(
      label: translate('field.industries'),
      validator: isRequired == true ? requiredValidator : null,
      future: this.industryService.getIndustries,
      onSaved: (Industry item) {
        _industry = item?.id;
      },
      renderFn: (Industry item) => item.name,
      compareFn: (Industry item, Industry selectedItem) =>
          item.id == selectedItem.id,
      onChanged: (Industry instance) {
        _industryStream.add(instance?.id);
        print("industry : $_industry");
      },
    );
  }

  Widget _buildAddressField(BuildContext context, bool isRequired) {
    return AddressField(
        validator: isRequired == true ? requiredValidator : null,
        onSaved: (
          Map<String, dynamic> address,
        ) {
          _address = address;
          print("address: $_address");
        });
  }

  Widget _buildSkillField(BuildContext context, bool isRequired) {
    return StreamBuilder(
      stream: _industryStream.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        String industry = snapshot.data;

        return FutureBuilder(
          future: Future.value(industry),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AsyncDropdown<Skill>(
                future: (Map<String, dynamic> query) => this
                    .industryService
                    .getSkills(snapshot.data, widget.settings.company, query),
                label: translate('field.skills'),
                renderFn: (Skill item) => item.name,
                compareFn: (Skill item, Skill selectedItem) =>
                    item.id == selectedItem.id,
                validator: isRequired == true ? requiredValidator : null,
                multiple: true,
                onSaved: (List<Skill> skills) {
                  if (skills != null) {
                    _skills = skills.map((e) => e.id).toList();
                    print("skill:$_skills");
                  } else {
                    skills = [];
                  }
                },
              );
            }

            return Container();
          },
        );
      },
    );
  }

  Widget _buildTagField(BuildContext context, bool isRequired) {
    TagService tagService = Provider.of<TagService>(context);

    return FutureBuilder(
      future: tagService.getAllTags(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Tag> data = snapshot.data;

          return FormSelect(
            multiple: true,
            title: translate('field.tags'),
            columns: 1,
            onSave: (List<dynamic> ids) {
              _tags = ids;
              print("tag : $_tags");
            },
            options: data.map((Tag el) {
              return Option(
                value: el.id,
                title: el.name,
              );
            }).toList(),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ContactService contactService = Provider.of<ContactService>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 14.0,
            ),
            ...this._fields,
            if (this._configFetching)
              Center(
                child: Padding(
                  child: CircularProgressIndicator(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            StreamBuilder(
              stream: _errorStream.stream,
              builder: (context, snapshot) {
                return FormMessage(
                  type: MessageType.Error,
                  message: snapshot.data,
                );
              },
            ),
            if (_registered == false)
              StreamBuilder(
                stream: _fetchingStream.stream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormSubmitButton(
                      disabled: (snapshot.hasData && snapshot.data) ||
                          this._configFetching,
                      onPressed: () => _register(contactService),
                      label: translate('button.register'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
