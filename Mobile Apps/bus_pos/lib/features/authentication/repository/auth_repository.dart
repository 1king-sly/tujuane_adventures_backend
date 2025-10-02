import 'package:bus_pos/features/authentication/data/auth_api.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';

class AuthRepository {
  final AuthApi _api = AuthApi();


  Future<UserModel> login(String email, String password) =>
      _api.login(email, password);

  Future<UserModel> register(String email, String name, String password) =>
      _api.register(email, name, password);
}