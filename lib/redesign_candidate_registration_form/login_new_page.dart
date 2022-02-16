import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:piiprent/redesign_candidate_registration_form/controller/login_page_controller.dart';
import 'package:piiprent/redesign_candidate_registration_form/registration_1.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/field.dart';
import 'package:piiprent/redesign_candidate_registration_form/widgets/lang_icon.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/widgets/forgot_password_form.dart';
import 'package:provider/provider.dart';

class LoginNewPage extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context);
    ContactService contactService = Provider.of<ContactService>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: LagIcon(
                  buttoncolor: Color(0XFF919CA7),
                ),
              ),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: Image.asset("images/company_banner.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 80, right: 16),
                child: Container(
                  height: 345,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x215d7cac),
                          offset: Offset(0, 4),
                          blurRadius: 38,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Text(
                          translate('button.login').toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              fontFamily: "Roboto",
                              color: Color(0XFF2196F3)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 35, right: 15),
                        child: TxtFeild(
                          readonly: false,
                          pwdstr: false,
                          cntrlr: loginController.emailcontroller,
                          changeValdt: (value) {
                            loginController.username.value = value;
                          },
                          hinttxt: translate('field.email'),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 5, right: 15),
                        child: TxtFeild(
                          readonly: false,
                          hinttxt: translate('field.password'),
                          pwdstr: true,
                          cntrlr: loginController.pwdcontroller,
                          changeValdt: (value) {
                            loginController.password.value = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35, left: 12),
                        child: Container(
                          height: 43,
                          width: 164,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0XFF2196F3),
                            // boxShadow: [
                            //   BoxShadow(offset: Offset(5,5)
                            //   )
                            // ],
                          ),
                          child: TextButton(
                            child: Text(
                              translate('button.login'),
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            onPressed: () => loginController.onLogin(
                                loginService, contactService, context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            Get.to(ForgotPasswordForm());
                          },
                          child: Text(
                            translate('link.forgot_password'),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: "Roboto",
                                color: Color(0XFF2196F3)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
        child: Container(

          height: 52,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translate('text.login_page'),
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF919CA7)),
              ),
              SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  Get.to(RegistrasionPage1());
                  // Get.to(GeneralQues());
                },
                child: Text(
                  translate('link.register_here'),
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF2196F3),
                    decoration: TextDecoration.underline,
                  ),

                ),
              ),
              SizedBox(
                height: 3,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

