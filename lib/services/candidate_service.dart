import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:piiprent/models/candidate_model.dart';
import 'package:piiprent/models/carrier_model.dart';
import 'package:piiprent/services/api_service.dart';

class CandidateService {
  final ApiService apiService = ApiService.create();

  Future<Candidate> getCandidate(String id) async {
    Map<String, dynamic> params = {
      'fields': Candidate.requestFields,
    };

    try {
      http.Response res = await apiService.get(
          path: 'candidate/candidatecontacts/$id/', params: params);

      if (res.statusCode == 200) {
        Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
        Candidate candidate = Candidate.fromJson(body);

        return candidate;
      } else {
        throw Exception('Failed to load Candidate');
      }
    } catch (e) {
      return e;
    }
  }

  Future<List<Carrier>> getCandidateAvailability(String id) async {
    Map<String, dynamic> params = {
      'limit': '-1',
      'target_date_0': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'candidate_contact': id,
      'fields': Carrier.requestFields,
    };

    try {
      http.Response res =
          await apiService.get(path: 'hr/carrierlists/', params: params);

      if (res.statusCode == 200) {
        Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
        List<dynamic> results = body['results'];
        List<Carrier> carriers =
            results.map((dynamic el) => Carrier.fromJson(el)).toList();

        return carriers;
      } else {
        throw Exception('Failed to load Carriers');
      }
    } catch (e) {
      return e;
    }
  }

  Future<Carrier> setAvailability(
      DateTime date, bool available, String id) async {
    Map<String, dynamic> body = {
      'confirmed_available': available,
      'target_date': DateFormat('yyyy-MM-dd').format(date),
      'candidate_contact': id,
    };

    try {
      http.Response res =
          await apiService.post(path: 'hr/carrierlists/', body: body);

      if (res.statusCode == 201) {
        Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
        return Carrier.fromJson(body);
      } else {
        throw Exception('Failed set candidate availability');
      }
    } catch (e) {
      return e;
    }
  }

  Future<Carrier> updateAvailability(
    DateTime date,
    bool available,
    String userId,
    String id,
  ) async {
    Map<String, dynamic> body = {
      'confirmed_available': available,
      'target_date': DateFormat('yyyy-MM-dd').format(date),
      'candidate_contact': userId,
    };

    try {
      http.Response res =
          await apiService.put(path: 'hr/carrierlists/$id/', body: body);

      if (res.statusCode == 200) {
        Map<String, dynamic> body = json.decode(utf8.decode(res.bodyBytes));
        return Carrier.fromJson(body);
      } else {
        throw Exception('Failed update candidate availability');
      }
    } catch (e) {
      return e;
    }
  }

  Future<bool> updatePersonalDetails({
    String id,
    String contactId,
    int height,
    int weight,
    String firstName,
    String lastName,
    String email,
    String phoneMobile,
  }) async {
    Map<String, dynamic> body = {
      'contact': {
        'id': contactId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_mobile': phoneMobile,
      },
      'height': height,
      'weight': weight,
    };

    try {
      http.Response res = await apiService.put(
          path: '/candidate/candidatecontacts/$id/', body: body);

      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed update candidate personal details');
      }
    } catch (e) {
      return e;
    }
  }

  Future<bool> updatePicture({
    String contactId,
    String title,
    String firstName,
    String lastName,
    String email,
    String phoneMobile,
    String picture,
    String birthday,
  }) async {
    Map<String, dynamic> body = {
      'id': contactId,
      'title': title,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_mobile': phoneMobile,
      'birthday': birthday,
      'picture': picture
    };

    try {
      http.Response res =
          await apiService.put(path: '/core/contacts/$contactId/', body: body);

      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed update contact personal details');
      }
    } catch (e) {
      return false;
    }
  }
}
