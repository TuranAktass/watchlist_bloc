import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/feat/database/repository/database_repository.dart';
import 'package:watchlist/feat/fav/repository/favorites_repository.dart';
import 'package:watchlist/feat/fav/repository/model/fav_model.dart';

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
        final fList = await favoritesRepository.getFavorites(user);
        emit(FavoritesLoaded(favorites: fList));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });

    on<FavoritesAdd>((event, emit) async {
      try {
        emit(FavoritesLoading());
        await favoritesRepository.addFavorite(event.uid, event.id);
        //emit(FavoritesLoaded(favorites: [event.id]));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });
  }
}
