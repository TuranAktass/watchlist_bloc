import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';

class FollowService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<dynamic> followRequest({required String uid}) async {
    final currentUser = _auth.currentUser!.uid;
    final res = await _firestore
        .collection("Users")
        .doc(currentUser)
        .collection('followings')
        .doc(uid)
        .set({'uid': uid});

    await _firestore
        .collection("Users")
        .doc(uid)
        .collection('followers')
        .doc(currentUser)
        .set({'uid': currentUser});
  }

  Future<dynamic> unFollowRequest({required String uid}) async {
    final currentUser = _auth.currentUser!.uid;
    final res = await _firestore
        .collection("Users")
        .doc(currentUser)
        .collection('followings')
        .doc(uid)
        .delete();

    await _firestore
        .collection('Users')
        .doc(uid)
        .collection('followers')
        .doc(currentUser)
        .delete();
  }

  Future<List<FollowUserModel>?> getFollowers({required String uid}) async {
    final res = await _firestore
        .collection('Users')
        .doc(uid)
        .collection('followers')
        .get();

    var followers =
        res.docs.map((e) => FollowUserModel.fromJson(json: e.data())).toList();
    List<FollowUserModel> list = [];
    followers.forEach((element) async {
      var x = await _firestore.collection('Users').doc(element.uid).get();
      list.add(FollowUserModel.fromJson(json: x.data()!));
    });

    return list;
  }

  Future<List<FollowUserModel>?> getFollowing({required String uid}) async {
    final res = await _firestore
        .collection('Users')
        .doc(uid)
        .collection('followings')
        .get();

    var followings =
        res.docs.map((e) => FollowUserModel.fromJson(json: e.data())).toList();
    List<FollowUserModel> list = [];

    for (var element in followings) {
      var x = await _firestore.collection('Users').doc(element.uid).get();
      list.add(FollowUserModel.fromJson(json: x.data()!));
      print(element);
    }

    return list;
  }
}
