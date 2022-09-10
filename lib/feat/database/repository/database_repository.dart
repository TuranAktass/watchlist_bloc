import 'package:watchlist/feat/auth/repository/firebase_auth/model/user_model.dart';
import 'package:watchlist/feat/database/service/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  @override
  Future<UserModel> retrieveUserData() {
    return service.retrieveUserData();
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<UserModel> retrieveUserData();
}
