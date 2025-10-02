import 'package:bus_pos/core/services/api_client.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';
import 'package:bus_pos/features/authentication/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider(this.repository);

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await repository.login(email, password);
      if (_user != null) {
        client.setAuthToken(_user!.token);
      }
    } catch (e) {
      debugPrint("Login failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String name, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await repository.register(email, name, password);
      if (_user != null) {
        client.setAuthToken(_user!.token);
      }
    } catch (e) {
      debugPrint("Registration failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
