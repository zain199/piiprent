import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/models/jobsite_model.dart';
import 'package:piiprent/widgets/client_app_bar.dart';
import 'package:piiprent/widgets/details_record.dart';
import 'package:piiprent/widgets/group_title.dart';

class ClientJobsiteDetailsScreen extends StatefulWidget {
  final Jobsite jobsite;

  ClientJobsiteDetailsScreen({
    this.jobsite,
  });

  @override
  _ClientJobsiteDetailsScreenState createState() =>
      _ClientJobsiteDetailsScreenState();
}

class _ClientJobsiteDetailsScreenState
    extends State<ClientJobsiteDetailsScreen> {
  GoogleMapController _mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  int _id = 1;

  void _add(double latitude, double longitude) {
    final MarkerId markerId = MarkerId(_id.toString());

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        latitude,
        longitude,
      ),
    );

    setState(() {
      markers[markerId] = marker;
      _id = _id + 1;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _add(
      widget.jobsite.latitude,
      widget.jobsite.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getClientAppBar(
        translate('page.title.jobsite'),
        context,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 36.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Text(
                widget.jobsite.name,
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.jobsite.company,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              // TODO: Add tags
              // GroupTitle(title: 'Tags'),
              GroupTitle(
                title: translate('group.title.primary_contact'),
              ),
              SizedBox(
                height: 15.0,
              ),
              DetailsRecord(
                label: translate('field.name'),
                value: widget.jobsite.primaryContact.str,
              ),
              DetailsRecord(
                label: translate('field.job_title'),
                value: widget.jobsite.primaryContactJobTitle,
              ),
              DetailsRecord(
                label: translate('field.phone'),
                value: widget.jobsite.primaryContact.phoneMobile,
              ),
              SizedBox(
                height: 15.0,
              ),
              GroupTitle(
                title: translate('group.title.jobsite_information'),
              ),
              SizedBox(
                height: 15.0,
              ),
              DetailsRecord(
                label: translate('field.industry'),
                value: widget.jobsite.industry,
              ),
              DetailsRecord(
                label: translate('field.start_date'),
                value: widget.jobsite.startDate != null
                    ? DateFormat('dd/MM/yyyy').format(widget.jobsite.startDate)
                    : '',
              ),
              DetailsRecord(
                label: translate('field.end_date'),
                value: widget.jobsite.endDate != null
                    ? DateFormat.jm().format(widget.jobsite.endDate)
                    : '',
              ),
              DetailsRecord(
                label: translate('field.note'),
                value: widget.jobsite.notes,
              ),
              SizedBox(
                height: 15.0,
              ),
              GroupTitle(
                title: translate('group.title.portfolio_manager'),
              ),
              SizedBox(
                height: 15.0,
              ),
              DetailsRecord(
                label: translate('field.name'),
                value: widget.jobsite.portfolioManager.str,
              ),
              DetailsRecord(
                label: translate('field.job_title'),
                value: widget.jobsite.portfolioManagerJobTitle,
              ),
              DetailsRecord(
                label: translate('field.phone'),
                value: widget.jobsite.portfolioManager.phoneMobile,
              ),
              SizedBox(
                height: 15.0,
              ),
              GroupTitle(
                title: translate('group.title.map'),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 350.0,
                width: 20.0,
                child: GoogleMap(
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  indoorViewEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.jobsite.latitude,
                      widget.jobsite.longitude,
                    ),
                    zoom: 10.0,
                  ),
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
