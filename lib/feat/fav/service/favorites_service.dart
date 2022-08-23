import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';

class FavoritesService {
  final _db = FirebaseFirestore.instance;
  Future<dynamic> getFavorites(UserModel userData) async {
    final res = await _db
        .collection('Users')
        .doc(userData.uid)
        .collection('favorites')
        .get();
    print(res.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<dynamic> addFavorite(String uid, String id) async {
    log('IM CALLED with $uid and $id');
    final res =
        await _db.collection('Users').doc(uid).collection('favorites').add({
      'id': id,
    });

    log(res.toString());
  }
}
