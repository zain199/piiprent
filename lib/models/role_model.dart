class Role {
  final String id;
  final String name;
  final String companyId;
  final String clientContactId;

  bool active;

  static final requestFields = [
    'id',
    '__str__',
  ];

  Role({this.id, this.name, this.companyId, this.clientContactId});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: (json['__str__'] as String).replaceAll('client - ', ''),
      companyId: json['company_id'],
      clientContactId: json['client_contact_id'],
    );
  }
}
