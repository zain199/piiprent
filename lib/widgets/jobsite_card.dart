import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/models/jobsite_model.dart';
import 'package:piiprent/screens/client_jobsite_details_screen.dart';
import 'package:piiprent/widgets/list_card.dart';
import 'package:piiprent/widgets/list_card_record.dart';

class JobsiteCard extends StatelessWidget {
  final Function update;
  final Jobsite jobsite;

  JobsiteCard({
    this.update,
    this.jobsite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ClientJobsiteDetailsScreen(
            jobsite: jobsite,
          ),
        ),
      ),
      child: ListCard(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobsite.name,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
            Text(
              jobsite.company,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            ListCardRecord(
              content: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  Text(jobsite.address),
                ],
              ),
            ),
            ListCardRecord(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('field.start_date')),
                  Text(jobsite.startDate != null
                      ? DateFormat('dd/MM/yyyy').format(jobsite.startDate)
                      : ''),
                ],
              ),
            ),
            ListCardRecord(
              last: true,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('field.end_date')),
                  Text(jobsite.endDate != null
                      ? DateFormat.jm().format(jobsite.endDate)
                      : ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
