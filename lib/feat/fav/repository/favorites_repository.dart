import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/fav/service/favorites_service.dart';

class FavoritesRepository {
  FavoritesService _service = FavoritesService();

  Future<dynamic> getFavorites(UserModel userData) async {
    return await _service.getFavorites(userData);
  }

  Future<dynamic> addFavorite(String uid, String id) async {
    return await _service.addFavorite(uid, id);
  }
}
