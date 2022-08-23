import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/auth/service/auth_service.dart';

class AuthRepository {
  final AuthService service = AuthService();

  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  Future<UserCredential?> signUp(UserModel user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> signOut() {
    return service.signOut();
  }

  Future<String?> retrieveUserName(UserModel user) {
    return service.retrieveUserName(user);
  }
}
