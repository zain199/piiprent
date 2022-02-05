import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/models/job_model.dart';
import 'package:piiprent/screens/client_job_details_screen.dart';
import 'package:piiprent/widgets/list_card.dart';
import 'package:piiprent/widgets/list_card_record.dart';

class ClientJobCard extends StatelessWidget {
  final Job job;

  ClientJobCard({
    this.job,
  });

  Widget _buildStatus(String label, JobStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case JobStatus.Unfilled:
        {
          icon = Icons.close;
          color = Colors.red[400];
          break;
        }
      case JobStatus.Fullfilled:
        {
          icon = Icons.check_circle;
          color = Colors.green[400];
          break;
        }
      default:
        {
          icon = Icons.remove_circle;
          color = Colors.grey[400];
        }
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: Row(
        children: [
          Text(translate('timesheet.status')),
          SizedBox(
            width: 4.0,
          ),
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            icon,
            color: color,
            size: 20.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ClientJobDetailsScreen(
            position: job.translations['position']['en'],
            jobsite: job.jobsite,
            workStartDate: job.workStartDate,
            notes: job.notes,
            tags: job.tags,
            id: job.id,
            contact: job.contact,
          ),
        ),
      ),
      child: ListCard(
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobsite,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    job.contact,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  )
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(14.0),
                        ),
                      ),
                      child: Text(
                        job.status,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          translate('table.workers'),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20.0,
                          width: 20.0,
                          margin: const EdgeInsets.only(left: 8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            job.workers.toString(),
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            ListCardRecord(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('timesheet.position')),
                  Text(job.translations['position']['en']),
                ],
              ),
            ),
            ListCardRecord(
              last: true,
              content: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildStatus(
                      'Today',
                      job.isFulFilledToday,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildStatus(
                      'Tomorrow',
                      job.isFulfilled,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
