part of 'movie_details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final MovieDetailsModel movieDetails;

  @override
  List<MovieDetailsModel> get props => [movieDetails];

  const DetailsLoaded(this.movieDetails);
}

class DetailsError extends DetailsState {
  final String? message;
  const DetailsError(this.message);
}
