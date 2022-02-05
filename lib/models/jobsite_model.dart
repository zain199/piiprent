import 'package:piiprent/helpers/functions.dart';
import 'package:piiprent/models/contact_model.dart';

class Jobsite {
  String id;
  String name;
  String address;
  DateTime startDate;
  DateTime endDate;
  String company;
  Contact portfolioManager;
  String portfolioManagerJobTitle;
  Contact primaryContact;
  String primaryContactJobTitle;
  final Map<String, dynamic> translations;
  double latitude;
  double longitude;
  String notes;

  static final requestFields = [
    'id',
    'industry',
    'short_name',
    'regular_company',
    'address',
    'portfolio_manager',
    'primary_contact',
    'start_date',
    'end_date',
    'notes',
  ];

  Jobsite({
    this.id,
    this.name,
    this.address,
    this.startDate,
    this.endDate,
    this.company,
    this.portfolioManager,
    this.portfolioManagerJobTitle,
    this.primaryContact,
    this.primaryContactJobTitle,
    this.translations,
    this.latitude,
    this.longitude,
    this.notes,
  });

  factory Jobsite.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> translations = {
      'industry': generateTranslations(
        json['industry']['translations'],
        json['industry']['__str__'],
      ),
    };

    var primaryContact = json['primary_contact'];
    var portfolioManager = json['portfolio_manager'];

    return Jobsite(
      id: json['id'],
      name: json['short_name'],
      translations: translations,
      company: json['regular_company']['__str__'],
      address: (json['address']['__str__'] as String).replaceAll('\n', ' '),
      portfolioManager: portfolioManager != null
          ? Contact.fromJson(portfolioManager['contact'])
          : Contact(),
      portfolioManagerJobTitle:
          portfolioManager != null ? portfolioManager['job_title'] : '',
      primaryContact: Contact.fromJson(primaryContact['contact']),
      primaryContactJobTitle: primaryContact['job_title'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      latitude: double.parse(json['address']['latitude']),
      longitude: double.parse(json['address']['longitude']),
      notes: json['notes'],
    );
  }

  String get industry {
    return translations['industry']['en'];
  }
}
