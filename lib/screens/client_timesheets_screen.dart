import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/models/timesheet_model.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/services/timesheet_service.dart';
import 'package:piiprent/widgets/client_app_bar.dart';
import 'package:piiprent/widgets/client_drawer.dart';
import 'package:piiprent/widgets/client_timesheet_card.dart';
import 'package:piiprent/widgets/filter_dialog_button.dart';
import 'package:piiprent/widgets/list_page.dart';
import 'package:provider/provider.dart';

class ClientTimesheetsScreen extends StatelessWidget {
  final StreamController _updateStream = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    TimesheetService timesheetService = Provider.of<TimesheetService>(context);
    LoginService loginService = Provider.of<LoginService>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: getClientAppBar(
          translate('page.title.timesheets'),
          context,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(translate('page.title.timesheets.unapproved')),
                  )
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.query_builder),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(translate('page.title.timesheets.history')),
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: ClientDrawer(),
        floatingActionButton: FilterDialogButton(
          onClose: (data) {
            _updateStream.add({
              'shift_started_at_0': data['from'],
              'shift_started_at_1': data['to'],
            });
          },
        ),
        body: TabBarView(
          children: [
            ListPage<Timesheet>(
              action: timesheetService.getUnapprovedTimesheets,
              updateStream: _updateStream.stream,
              params: {
                'role': loginService.user.activeRole.id,
              },
              getChild: (Timesheet instance, Function reset) {
                return ClientTimesheetCard(
                  timesheet: instance,
                  update: reset,
                );
              },
            ),
            ListPage<Timesheet>(
              action: timesheetService.getHistoryTimesheets,
              updateStream: _updateStream.stream,
              params: {
                'role': loginService.user.activeRole.id,
              },
              getChild: (Timesheet instance, Function reset) {
                return ClientTimesheetCard(
                  timesheet: instance,
                  update: reset,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
