import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/widgets/form_field.dart';
import 'package:piiprent/widgets/form_message.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/page_container.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _oldPass;
  String _newPass;
  String _confirmPass;

  bool _fetching = false;
  String _error;
  String _message;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onSubmit(ContactService service, String id) async {
    // TODO: add more validation
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    setState(() {
      _fetching = true;
      _message = null;
      _error = null;
    });

    try {
      String message = await service.changePassowrd(
        oldPass: _oldPass,
        newPass: _newPass,
        confirmPass: _confirmPass,
        id: id,
      );

      setState(() {
        _message = message;
      });
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
    ContactService contactService = Provider.of<ContactService>(context);
    LoginService loginService = Provider.of<LoginService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(translate('page.title.change_password'))),
      body: SingleChildScrollView(
        child: PageContainer(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Field(
                  label: translate('field.current_password'),
                  obscureText: true,
                  onSaved: (String value) {
                    _oldPass = value;
                  },
                ),
                Field(
                  label: translate('field.new_password'),
                  obscureText: true,
                  onSaved: (String value) {
                    _newPass = value;
                  },
                ),
                Field(
                  label: translate('field.verify_pssword'),
                  obscureText: true,
                  onSaved: (String value) {
                    _confirmPass = value;
                  },
                ),
                FormMessage(
                  type: MessageType.Error,
                  message: _error,
                ),
                FormMessage(
                  type: MessageType.Success,
                  message: _message,
                ),
                SizedBox(
                  height: 15.0,
                ),
                FormSubmitButton(
                  disabled: _fetching,
                  onPressed: () {
                    _onSubmit(contactService, loginService.user.userId);
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
