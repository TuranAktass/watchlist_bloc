part of 'follow_bloc.dart';

abstract class FollowEvent extends Equatable {
  const FollowEvent();

  @override
  List<Object> get props => [];
}

class FollowRequest extends FollowEvent {
  final String uid;

  const FollowRequest({required this.uid});

  @override
  List<Object> get props => [uid];
}

class UnfollowRequest extends FollowEvent {
  final String uid;
  const UnfollowRequest({required this.uid});

  @override
  List<Object> get props => [uid];
}

class GetFollowers extends FollowEvent {}

class GetFollowings extends FollowEvent {}

class GetFollowData extends FollowEvent {}

class GetUserDetails extends FollowEvent {
  final String uid;
  const GetUserDetails({required this.uid});

  @override
  List<Object> get props => [uid];
}
