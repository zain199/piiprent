import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/models/job_offer_model.dart';
import 'package:piiprent/screens/candidate_job_details_screen.dart';
import 'package:piiprent/services/job_offer_service.dart';
import 'package:piiprent/services/notification_service.dart';
import 'package:piiprent/widgets/form_submit_button.dart';
import 'package:piiprent/widgets/list_card.dart';
import 'package:piiprent/widgets/list_card_record.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';

class JobCard extends StatefulWidget {
  final Function update;
  final JobOffer jobOffer;

  final bool offer;

  JobCard({
    this.offer = false,
    this.update,
    this.jobOffer,
  });

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool _fetching = false;

  _acceptJobOffer(JobOfferService jobOfferService,
      NotificationService notificationService) async {
    setState(() {
      _fetching = true;
    });
    try {
      await jobOfferService.accept(widget.jobOffer.id);
      await notificationService.checkJobOfferNotifications();

      if (widget.update != null) {
        widget.update();
      }
    } catch (e) {
      print(e);
      setState(() {
        _fetching = false;
      });
    }
  }

  _declineJobOffer(JobOfferService jobOfferService,
      NotificationService notificationService) async {
    setState(() {
      _fetching = true;
    });
    try {
      await jobOfferService.decline(widget.jobOffer.id);
      await notificationService.checkJobOfferNotifications();

      if (widget.update != null) {
        widget.update();
      }
    } catch (e) {
      print(e);
      setState(() {
        _fetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    JobOfferService jobOfferService = Provider.of<JobOfferService>(context);
    NotificationService notificationService =
        Provider.of<NotificationService>(context);
    //print(Get.locale.languageCode.split('_').first);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CandidateJobDetailsScreen(
            jobOffer: widget.jobOffer,
          ),
        ),
      ),
      child: ListCard(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.jobOffer.company,
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
            Text(
              widget.jobOffer.position(Get.locale.languageCode.split('_').first),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        DateFormat.jm().format(widget.jobOffer.datetime),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .format(widget.jobOffer.datetime),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListCardRecord(
              last: true,
              content: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  Text(
                    widget.jobOffer.location,
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            widget.offer
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FormSubmitButton(
                                  label: translate('button.accept'),
                                  onPressed: () => _acceptJobOffer(
                                    jobOfferService,
                                    notificationService,
                                  ),
                                  disabled: _fetching,
                                  color: Colors.green[400],
                                  horizontalPadding: 20,
                                ),
                                FormSubmitButton(
                                  label: translate('button.reject'),
                                  onPressed: () => _declineJobOffer(
                                    jobOfferService,
                                    notificationService,
                                  ),
                                  disabled: _fetching,
                                  color: Colors.red[400],
                                  horizontalPadding: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
