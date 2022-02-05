import 'package:flutter/material.dart';
import 'package:piiprent/widgets/forgot_password_form.dart';
import 'package:piiprent/widgets/page_container.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: PageContainer(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 45.0),
                  Image.asset('images/company_banner.png'),
                  SizedBox(
                    height: 45.0,
                  ),
                  ForgotPasswordForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
