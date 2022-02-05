class Auth {
  // ignore: non_constant_identifier_names
  final String access_token_jwt;

  // ignore: non_constant_identifier_names
  final String refresh_token;

  // ignore: non_constant_identifier_names
  final String token_type;

  Auth({
    // ignore: non_constant_identifier_names
    this.access_token_jwt,
    // ignore: non_constant_identifier_names
    this.refresh_token,
    // ignore: non_constant_identifier_names
    this.token_type,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      access_token_jwt: json['access_token_jwt'] as String,
      refresh_token: json['refresh_token'] as String,
      token_type: json['token_type'] as String,
    );
  }
}
