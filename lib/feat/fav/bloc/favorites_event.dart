part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoad extends FavoritesEvent {
  const FavoritesLoad();
}

class FavoritesAdd extends FavoritesEvent {
  final MovieBasicModel movie;
  final String uid;
  const FavoritesAdd({required this.uid, required this.movie});
}

class FavoritesRemove extends FavoritesEvent {
  final String uid;
  final MovieBasicModel movie;
  const FavoritesRemove({required this.uid, required this.movie});
}
