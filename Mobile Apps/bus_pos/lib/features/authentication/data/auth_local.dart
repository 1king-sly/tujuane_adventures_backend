import 'package:bus_pos/core/services/local_storage.dart';
import 'package:bus_pos/features/authentication/models/user_model.dart';

class AuthLocal {
  void getUser(String email, String password) async {
    final response = storage.getJson("user");
    if (response != null) {
      user = UserModel.fromJson(response);
    }
  }
}
