import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/fav/service/favorites_service.dart';
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';

class FavoritesRepository {
  FavoritesService _service = FavoritesService();

  Future<dynamic> getFavorites(String uid) async {
    return await _service.getFavorites(uid);
  }

  Future<dynamic> addFavorite(String uid, MovieBasicModel movie) async {
    return await _service.addFavorite(uid, movie);
  }

  Future<dynamic> removeFavorite(String uid, MovieBasicModel movie) async {
    return await _service.removeFavorite(uid, movie);
  }
}
