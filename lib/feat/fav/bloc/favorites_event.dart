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
  final String id;
  final String uid;
  const FavoritesAdd({required this.uid, required this.id});
}

class FavoritesRemove extends FavoritesEvent {
  final String id;
  const FavoritesRemove({required this.id});
}

