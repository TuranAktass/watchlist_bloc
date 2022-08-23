part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<String> favorites;
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
