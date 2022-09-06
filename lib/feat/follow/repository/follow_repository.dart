import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';
import 'package:watchlist/feat/follow/service/follow_service.dart';

abstract class FollowRepository {
  Future<dynamic> followRequest({required String uid});
  Future<dynamic> unFollowRequest({required String uid});
  Future<List<FollowUserModel>> getFollowers();
  Future<List<FollowUserModel>> getFollowing();
}

class FollowRepositoryImpl extends FollowRepository {
  final _service = FollowService();
  @override
  Future followRequest({required String uid}) async {
    await _service.followRequest(uid: uid);
  }

  @override
  Future<List<FollowUserModel>> getFollowers() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return await _service.getFollowers(uid: uid) ?? [];
  }

  @override
  Future<List<FollowUserModel>> getFollowing() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return await _service.getFollowing(uid: uid) ?? [];
  }

  @override
  Future unFollowRequest({required String uid}) async {
    await _service.unFollowRequest(uid: uid);
  }
}
