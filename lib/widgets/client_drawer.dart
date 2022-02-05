import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:provider/provider.dart';

class ClientDrawer extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(fontSize: 18, color: Colors.blue);
  final bool dashboard;

  ClientDrawer({this.dashboard = false});

  @override
  Widget build(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context);
    ContactService contactService = Provider.of<ContactService>(context);

    return Container(
      width: 250,
      decoration: BoxDecoration(color: Colors.white),
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
              future:
                  contactService.getContactPicture(loginService.user.userId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return DrawerHeader(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: snapshot.hasData
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot.data),
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          loginService.user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            !dashboard
                ? ListTile(
                    title: Text(translate('page.title.dashboard'),
                        style: _textStyle),
                    onTap: () => Navigator.pushNamed(context, '/client_home'),
                  )
                : SizedBox(),
            !dashboard
                ? Divider(
                    color: Colors.grey[300],
                  )
                : SizedBox(),
            ListTile(
              title: Text(translate('page.title.profile'), style: _textStyle),
              onTap: () => Navigator.pushNamed(context, '/client_profile'),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            ListTile(
              title: Text(translate('page.title.jobsites'), style: _textStyle),
              onTap: () => Navigator.pushNamed(context, '/client_jobsites'),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            ListTile(
              title: Text(translate('page.title.jobs'), style: _textStyle),
              onTap: () => Navigator.pushNamed(context, '/client_jobs'),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            ListTile(
              title:
                  Text(translate('page.title.timesheets'), style: _textStyle),
              onTap: () => Navigator.pushNamed(context, '/client_timesheets'),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            ListTile(
              title: Text(translate('button.logout'), style: _textStyle),
              onTap: () => {
                loginService
                    .logout()
                    .then((bool success) => Navigator.pushNamed(context, '/'))
              },
            ),
            Divider(
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
