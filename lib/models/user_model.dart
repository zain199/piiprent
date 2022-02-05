import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/models/role_model.dart';

class User {
  String name;
  String email;
  RoleType type;
  Map<String, dynamic> picture;
  String id;
  String userId;
  List<Role> roles;
  String candidateId;

  User({
    this.name,
    this.email,
    this.type,
    this.picture,
    this.id,
    this.userId,
    this.candidateId,
  });

  factory User.fromTokenPayload(Map<String, dynamic> payload) {
    if (payload['contact'] == null) {
      throw 'Error';
    }

    var contact = payload['contact'][0];

    return User(
      name: contact['name'],
      email: contact['email'],
      type: getRole(contact['contact_type']),
      picture: contact['picture'],
      id: contact['contact_id'],
      userId: contact['id'],
      candidateId: contact['candidate_contact'],
    );
  }

  String userAvatarUrl() {
    if (picture != null && picture['origin'] != null) {
      return picture['origin'];
    }

    return null;
  }

  Role get activeRole {
    if (roles != null) {
      return roles.firstWhere((element) => element.active);
    }

    return null;
  }
}

RoleType getRole(String contactType) {
  switch (contactType) {
    case 'candidate':
      return RoleType.Candidate;
    case 'client':
      return RoleType.Client;
    default:
      throw 'Unknown role';
  }
}
