bool isEmail(String value) {
  if (value.contains('@')) {
    return true;
  }

  return false;
}

String emailValidator(String value) {
  if (isEmail(value)) {
    return null;
  }
  return 'Please enter a valid email!';
}

String numberValidator(String value) {
  try {
    double.parse(value);

    return null;
  } catch (e) {
    return 'Phone : Please enter a valid number!';
  }
}

String requiredValidator(dynamic value) {
  if (value != null && value != '') {
    return null;
  }

  return 'This field is required';
}

String emptyValidator(List<dynamic> value) {
  if (value.isNotEmpty) {
    return null;
  }

  return 'This field is required';
}
