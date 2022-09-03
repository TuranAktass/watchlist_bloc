import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/fav/repository/model/fav_model.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';

class FavoritesService {
  final _db = FirebaseFirestore.instance;
  Future<dynamic> getFavorites(String uid) async {
    final res =
        await _db.collection('Users').doc(uid).collection('favorites').get();
    try {
      var rModel = FavResponseModel(
          data: res.docs.map((docSnapshot) => docSnapshot.data()).toList());
      return rModel.favList;
    } catch (e) {
      return FavResponseModel.withError(e.toString());
    }
  }

  Future<dynamic> addFavorite(String uid, MovieBasicModel movie) async {
    log('IM CALLED with $uid and $movie');
    final res = await _db
        .collection('Users')
        .doc(uid)
        .collection('favorites')
        .doc(movie.imdbID)
        .set(movie.toJson());
  }

  Future<dynamic> removeFavorite(String uid, MovieBasicModel movie) async {
    final res = await _db
        .collection('Users')
        .doc(uid)
        .collection('favorites')
        .doc(movie.imdbID)
        .delete();
  }
}
