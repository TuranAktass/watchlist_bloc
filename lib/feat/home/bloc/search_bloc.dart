import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';
import 'package:watchlist/feat/home/repository/search_repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final SearchRepository searchRepository = SearchRepository();
    on<GetSearchResult>((e, emit) async {
      try {
        emit(SearchLoading());
        final mList = await searchRepository.fetchSearchResult('');

        emit(SearchLoaded(mList));
        if (mList.error != null) {
          emit(SearchError(mList.error));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
