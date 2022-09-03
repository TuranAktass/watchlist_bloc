import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/feat/follow/repository/follow_repository.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FollowInitial()) {
    final _repository = FollowRepositoryImpl();
    on<GetFollowData>((event, emit) async {
      emit(FollowLoading());
      final followers = await _repository.getFollowers();
      final followings = await _repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });

    on<FollowRequest>((event, emit) async {
      emit(FollowLoading());
      await _repository.followRequest(uid: event.uid);
      final followers = await _repository.getFollowers();
      final followings = await _repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });

    on<UnfollowRequest>((event, emit) async {
      emit(FollowLoading());
      await _repository.unFollowRequest(uid: event.uid);
      final followers = await _repository.getFollowers();
      final followings = await _repository.getFollowing();
      emit(FollowPageLoaded(followers: followers, followings: followings));
    });
  }
}
