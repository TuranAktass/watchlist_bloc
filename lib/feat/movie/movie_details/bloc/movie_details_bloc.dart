import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';
import 'package:watchlist/feat/movie/movie_details/repository/movie_details_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  MovieDetailsBloc() : super(DetailsInitial()) {
    final detailsRepository = MovieDetailsRepository();
    on<GetDetails>((event, emit) async {
      emit(DetailsLoading());
      try {
        final movieDetails = await detailsRepository.fetchDetails(id: event.id);
        emit(DetailsLoaded(movieDetails));
      } catch (e) {
        emit(DetailsError(e.toString()));
      }
    });
  }
}
