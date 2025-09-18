import '../models/user_model.dart';

class AuthService {
  Future<UserModel> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return UserModel(id: '1', email: email, name: 'Demo User');
  }
}


