import 'package:get/get.dart';

class LangugesModel {
  String _name;
  RxBool _isChecked = false.obs;

  String get name => _name;

  RxBool get isChecked => _isChecked;

  LangugesModel(
    String name, {
    RxBool isChecked,
  }) {
    _name = name;
    _isChecked = isChecked;
  }

  LangugesModel.fromJson(dynamic json) {
    _name = json['name'];
    _isChecked.value = json['isChecked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['isChecked'] = _isChecked.value;
    return map;
  }
}
