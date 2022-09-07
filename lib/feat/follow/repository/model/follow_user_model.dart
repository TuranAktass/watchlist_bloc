import 'package:watchlist/feat/fav/repository/model/fav_model.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';

class FollowUserModel {
  String? uid;
  String? displayName;
  String? email;
  bool? isFollowing;
  List<FollowUserModel> followings = [];
  List<FollowUserModel> followers = [];
  List<MovieBasicModel> favs = [];

  FollowUserModel.fromJson({required Map<String, dynamic> json, String? id}) {
    uid = id ?? json['uid'];
    displayName = json['displayName'];
    email = json['email'];
    isFollowing = json['isFollowing'];

    if (json['followings'] != null) {
      followings = [];
      json['followings'].forEach((v) {
        followings.add(FollowUserModel.fromJson(json: v));
      });
    }

    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers.add(FollowUserModel.fromJson(json: v));
      });
    }
  }

  Map<String, dynamic> followRequest({required String uid}) {
    return {'uid': uid};
  }

  @override
  String toString() {
    return 'FollowUserModel{uid: $uid, displayName: $displayName, email: $email, isFollowing: $isFollowing, followings: $followings, followers: $followers}';
  }
}
