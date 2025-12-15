// ignore_for_file: avoid_print

import '../mock_api/auth_api.dart';
import '../models/user.dart';

class AuthRepository {
  final AuthApi api = AuthApi();
  Future<User> signup(String email, String password) async {
    print('API called with: $email | $password');
    await Future.delayed(const Duration(seconds: 2));
    final data = await api.signup(email, password);
    return User.fromJson(data);
  }

  Future<User> login(String email, String password) async {
    final data = await api.login(email, password);
    return User.fromJson(data);
  }
}
