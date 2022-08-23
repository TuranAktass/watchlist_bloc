import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';
import 'package:watchlist/feat/fav/repository/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    final FavoritesRepository favoritesRepository = FavoritesRepository();
    on<FavoritesLoad>((event, emit) async {
      try {
        emit(FavoritesLoading());
        final fList = await favoritesRepository.getFavorites(event.userData);
        emit(FavoritesLoaded(favorites: fList));

        if (fList.error != null) {
          emit(FavoritesError(error: fList.error));
        }
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });

    on<FavoritesAdd>((event, emit) async {
      try {
        emit(FavoritesLoading());
        await favoritesRepository.addFavorite(event.uid, event.id);
        emit(FavoritesLoaded(favorites: [event.id]));
      } catch (e) {
        emit(FavoritesError(error: e.toString()));
      }
    });
  }
}
