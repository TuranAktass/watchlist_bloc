part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<MovieBasicModel> favorites;
  const FavoritesLoaded({required this.favorites});
  @override
  List<Object> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String error;
  const FavoritesError({required this.error});
  @override
  List<Object> get props => [error];
}

class FavoritesAdding extends FavoritesState {
  final MovieBasicModel movie;
  const FavoritesAdding({required this.movie});
  @override
  List<Object> get props => [movie];
}

class FavoritesAdded extends FavoritesState {
  final MovieBasicModel movie;
  const FavoritesAdded({required this.movie});
  @override
  List<Object> get props => [movie];
}

class FavoritesRemoving extends FavoritesState {
  final MovieBasicModel movie;
  const FavoritesRemoving({required this.movie});
  @override
  List<Object> get props => [movie];
}

class FavoritesRemoved extends FavoritesState {
  final MovieBasicModel movie;
  const FavoritesRemoved({required this.movie});
  @override
  List<Object> get props => [movie];
}
