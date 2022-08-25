import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/fav/repository/model/fav_model.dart';

class FavoritesService {
  final _db = FirebaseFirestore.instance;
  Future<dynamic> getFavorites(UserModel userData) async {
    final res = await _db
        .collection('Users')
        .doc(userData.uid)
        .collection('favorites')
        .get();
    try {
      var rModel = FavResponseModel(
          data: res.docs.map((docSnapshot) => docSnapshot.data()).toList());
      return rModel.favList;
    } catch (e) {
      return FavResponseModel.withError(e.toString());
    }
  }

  Future<dynamic> addFavorite(String uid, String id) async {
    log('IM CALLED with $uid and $id');
    final res =
        await _db.collection('Users').doc(uid).collection('favorites').add({
      'id': id,
    });
  }
}
