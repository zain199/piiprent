import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/services/company_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {
  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  bool _showErrorMessage = false;

  _redirect() async {
    LoginService loginService = Provider.of<LoginService>(
      key.currentContext,
      listen: false,
    );

    final role = await loginService.getUser();

    if (role == RoleType.Candidate) {
      Navigator.pushNamed(context, '/candidate_home');
    } else if (role == RoleType.Client) {
      Navigator.pushNamed(context, '/client_home');
    } else {
      Navigator.pushNamed(context, '/loginV2');
    }
  }

  _getSettings() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      CompanyService companyService = Provider.of<CompanyService>(
        key.currentContext,
        listen: false,
      );

      var result = await companyService.fetchSettings();

      if (result == true) {
        _redirect();
      } else {
        setState(() {
          _showErrorMessage = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/company_banner.png'),
            _showErrorMessage
                ? 'Please turn on internet'
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
