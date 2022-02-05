import 'package:piiprent/helpers/functions.dart';

enum JobStatus {
  Unfilled,
  Fullfilled,
  Pending,
  Open,
  Filled,
  Approved,
}

class Job {
  final String id;
  final String jobsite;
  final String status;
  final String contact;
  final Map<String, dynamic> translations;
  final int workers;
  final JobStatus isFulfilled;
  final JobStatus isFulFilledToday;
  final String notes;
  final DateTime workStartDate;
  final List<dynamic> tags;

  static List<String> requestFields = const [
    'id',
    'jobsite',
    'active_states',
    'customer_representative',
    'position',
    'workers',
    'is_fulfilled',
    'is_fulfilled_today',
    'notes',
    'work_start_date',
    'default_shift_starting_time',
    'tags',
  ];

  Job({
    this.id,
    this.jobsite,
    this.status,
    this.contact,
    this.translations,
    this.workers,
    this.isFulfilled,
    this.isFulFilledToday,
    this.notes,
    this.workStartDate,
    this.tags,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> translations = {
      'position': generateTranslations(
        json['position']['name']['translations'],
        json['position']['name']['__str__'],
      ),
    };

    return Job(
      id: json['id'],
      jobsite: json['jobsite']['__str__'],
      status: json['active_states'][0]['__str__'],
      contact: json['customer_representative']['__str__'],
      translations: translations,
      workers: json['workers'],
      isFulfilled: parseStatus(json['is_fulfilled']),
      isFulFilledToday: parseStatus(json['is_fulfilled_today']),
      notes: json['notes'],
      workStartDate: DateTime.parse(
          '${json['work_start_date']}T${json['default_shift_starting_time']}'),
      tags: json['tags'].map((el) => el['name']).toList(),
    );
  }

  get position {
    return translations['position']['en'];
  }

  static JobStatus parseStatus(int status) {
    switch (status) {
      case 0:
        return JobStatus.Unfilled;
      case 1:
        return JobStatus.Fullfilled;
      case 2:
        return JobStatus.Pending;
      case 3:
        return JobStatus.Open;
      case 4:
        return JobStatus.Filled;
      case 5:
        return JobStatus.Approved;
      default:
        return JobStatus.Unfilled;
    }
  }
}
