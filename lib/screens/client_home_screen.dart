import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/widgets/client_app_bar.dart';
import 'package:piiprent/widgets/client_drawer.dart';
import 'package:piiprent/widgets/home_calendar.dart';
import 'package:piiprent/widgets/home_screen_button.dart';
import 'package:piiprent/widgets/page_container.dart';
import 'package:provider/provider.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context);

    return Scaffold(
      drawer: ClientDrawer(
        dashboard: true,
      ),
      appBar: getClientAppBar(translate('page.title.dashboard'), context),
      body: SingleChildScrollView(
        child: PageContainer(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: HomeScreenButton(
                        color: Colors.blue[700],
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue[700],
                        ),
                        path: '/client_profile',
                        text: translate('page.title.profile'),
                      )),
                  Expanded(
                    flex: 1,
                    child: HomeScreenButton(
                      color: Colors.orange[700],
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.orange[700],
                      ),
                      path: '/client_jobsites',
                      text: translate('page.title.jobsites'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: HomeScreenButton(
                      color: Colors.amber[700],
                      icon: Icon(
                        Icons.business_center,
                        color: Colors.amber[700],
                      ),
                      path: '/client_jobs',
                      text: translate('page.title.jobs'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: HomeScreenButton(
                      color: Colors.green[700],
                      icon: Icon(
                        Icons.query_builder,
                        color: Colors.green[700],
                      ),
                      path: '/client_timesheets',
                      text: translate('page.title.timesheets'),
                    ),
                  )
                ],
              ),
              HomeCalendar(
                type: CalendarType.Client,
                role: loginService.user.activeRole.id,
              )
            ],
          ),
        ),
      ),
    );
  }
}
