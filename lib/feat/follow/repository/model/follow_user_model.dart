import 'package:flutter/material.dart';

class FollowUserModel {
  String? uid;
  String? displayName;
  String? email;
  bool? isFollowing;

  FollowUserModel.fromJson({required Map<String, dynamic> json}) {
    print('json : ${json.toString()}');
    uid = json['uid'];
    displayName = json['displayName'];
    email = json['email'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> followRequest({required String uid}) {
    return {'uid': uid};
  }
}
