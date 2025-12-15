import 'dart:async';

class AuthApi {
  static Map<String, dynamic>? _user;
  Future<Map<String, dynamic>> signup(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    _user = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "email": email,
    };
    return _user!;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    if (_user == null || _user!['email'] != email) {
      throw Exception("Invalid credentials");
    }
    return _user!;
  }
}
