part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  SearchLoading() {
    print('SEARCH LOADING');
  }
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final SearchResponseModel searchResponse;

  @override
  List<SearchResponseModel> get props => [searchResponse];
  SearchLoaded(this.searchResponse) {
    print('RESPONSE is => ${searchResponse.search!.first.title}');
  }
}

class SearchError extends SearchState {
  final String? message;
  const SearchError(this.message);

  @override
  List<Object> get props => [];
}
