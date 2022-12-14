import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';
import 'package:watchlist/feat/search/repository/model/search_model/search_response_model.dart';
import 'package:watchlist/feat/search/repository/search_repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final SearchRepository searchRepository = SearchRepository();
    on<GetSearchResult>((e, emit) async {
      try {
        emit(const SearchLoading());
        final mList = await searchRepository.fetchSearchResult(query: e.query);

        emit(SearchLoaded(mList));
        if (mList.error != null) {
          emit(SearchError(mList.error));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    on<GetUserSearchResult>((event, emit) async {
      try {
        emit(const SearchLoading());
        final userList =
            await searchRepository.fetchUserSearchResult(query: event.query);
        emit(UserSearchLoaded(userList));
        if (userList.isEmpty) {
          emit(const SearchError("No user found"));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
