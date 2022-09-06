part of 'follow_bloc.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowPageLoaded extends FollowState {
  final List<FollowUserModel> followers;
  final List<FollowUserModel> followings;

  const FollowPageLoaded({required this.followers, required this.followings});

  @override
  List<Object> get props => [followers, followings];
}

class FollowPageError extends FollowState {
  final String message;
  const FollowPageError({required this.message});

  @override
  List<Object> get props => [message];
}
