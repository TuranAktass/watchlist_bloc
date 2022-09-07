import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/follow/repository/follow_repository.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FollowInitial()) {
    final repository = FollowRepositoryImpl();
    on<GetFollowData>((event, emit) async {
      emit(FollowLoading());
      final followers = await repository.getFollowers();
      final followings = await repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });

    on<FollowRequest>((event, emit) async {
      emit(FollowLoading());
      await repository.followRequest(uid: event.uid);
      final followers = await repository.getFollowers();
      final followings = await repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });

    on<UnfollowRequest>((event, emit) async {
      emit(FollowLoading());
      await repository.unFollowRequest(uid: event.uid);
      final followers = await repository.getFollowers();
      final followings = await repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });
    on<GetUserDetails>((event, emit) async {
      emit(UserDetailsLoading());
      final user = await repository.getUserDetails(uid: event.uid);
      emit(UserDetailsFetched(user: user));
    });
  }
}
