import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/models/role_model.dart';
import 'package:piiprent/redesign_candidate_registration_form/registration_1.dart';
import 'package:piiprent/screens/candidate_home_screen.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/login_service.dart';

class LoginController extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var selectedlan = "".obs;

  String _formError;
  bool _fetching = false;
  var emailcontroller = TextEditingController(text: "");
  var pwdcontroller = TextEditingController(text: "");

  OnSubmit() {
    if (username.value.isEmpty) {
      Get.snackbar("Email i'd is empty", "Enter your Email");
      return;
    }
    if (!username.value.isEmail) {
      Get.snackbar("Email not valid", "Enter valid Email");
      return;
    }

    if (password.value.isEmpty) {
      Get.snackbar("Password Not Valid", "Enter valid Password");
      return;
    }
    Get.to(RegistrasionPage1());
    // Get.to(()=>LoginForm());
  }

  onChangelan(lan) {
    selectedlan.value = lan;
      changeLocale(Get.context, lan);
      var locale = Locale(lan, '');
      Get.updateLocale(locale);
  }

  onLogin(LoginService loginService, ContactService contactService,
      BuildContext context) async {
    _fetching = true;
    _formError = null;

    try {
      RoleType type = await loginService.login(username.value, password.value);

      if (type == RoleType.Candidate) {
        // Navigator.pushNamed(context, '/candidate_home');
        Get.to(() => CandidateHomeScreen());
        return;
      } else if (type == RoleType.Client) {
        List<Role> roles = await contactService.getRoles();
        roles[0].active = true;
        loginService.user.roles = roles;

        Get.to(() => CandidateHomeScreen());

        // Navigator.pushNamed(context, '/client_home');
        return;
      }
    } catch (e) {
      _fetching = false;
      _formError = e?.toString() ?? 'Unexpected error occurred.';
    }
  }
}
