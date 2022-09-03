import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/feat/database/repository/database_repository.dart';
import 'package:watchlist/feat/fav/repository/favorites_repository.dart';
import 'package:watchlist/feat/fav/repository/model/fav_model.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    final FavoritesRepository favoritesRepository = FavoritesRepository();
    final DatabaseRepository db = DatabaseRepositoryImpl();

    on<FavoritesLoad>((event, emit) async {
      print('HEYYY');
      try {
        emit(FavoritesLoading());
        final user = await db.retrieveUserData();
        final fList = await favoritesRepository.getFavorites(user.uid!);
        emit(FavoritesLoaded(favorites: fList));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });

    on<FavoritesAdd>((event, emit) async {
      try {
        await favoritesRepository.addFavorite(event.uid, event.movie);
       // add(FavoritesLoad());
        emit(FavoritesLoaded(
            favorites: await favoritesRepository.getFavorites(event.uid)));
        // emit(FavoritesAdded(movie: event.movie));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });

    on<FavoritesRemove>((event, emit) async {
      try {
        // emit(FavoritesRemoving(movie: event.movie));
        await favoritesRepository.removeFavorite(event.uid, event.movie);
         emit(FavoritesLoaded(
            favorites: await favoritesRepository.getFavorites(event.uid)));
        //add(const FavoritesLoad());
        //emit(FavoritesRemoved(movie: event.movie));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });
  }
}
