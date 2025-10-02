import 'dart:convert';

import 'package:bus_pos/core/services/api_client.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';

class AuthApi {
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      '/auth/login',
      body: {"email": email, "password": password},
    );

    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<UserModel> register(String email, String name, String password) async {
    final response = await client.post(
      '/auth/register',
      body: {"email": email, "name": name, "password": password},
    );

    return UserModel.fromJson(jsonDecode(response.body));
  }
}
