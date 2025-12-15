import 'package:flutter/material.dart';
import 'package:my_events_app/practice/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    if (isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signup(email, password); // mock API
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String username, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signup(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
