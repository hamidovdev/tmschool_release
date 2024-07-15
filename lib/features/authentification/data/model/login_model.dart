// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoginModel {
  final bool success;
  final String messages;
  final String token;
  final int id;

  LoginModel({
    required this.success,
    required this.messages,
    required this.token,
    required this.id,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] as bool,
      messages: json['messages'] as String,
      token: json['token'] as String,
      id: json['data']['id'] as int,
    );
  }
}
