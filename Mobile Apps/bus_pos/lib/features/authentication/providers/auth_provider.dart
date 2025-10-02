import 'package:bus_pos/core/services/api_client.dart';
import 'package:bus_pos/core/services/local_storage.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';
import 'package:bus_pos/features/authentication/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      user = await repository.login(email, password);
      if (user != null) {
        client.setAuthToken(user!.token);
        storage.setJson("user", user!.toJson());
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
      user = await repository.register(email, name, password);
      if (user != null) {
        client.setAuthToken(user!.token);
        storage.setJson("user", user!.toJson());
      }
    } catch (e) {
      debugPrint("Registration failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
