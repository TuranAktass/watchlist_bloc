part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  const SearchLoading();
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final SearchResponseModel searchResponse;

  @override
  List<SearchResponseModel> get props => [searchResponse];
  const SearchLoaded(this.searchResponse);
}

class SearchError extends SearchState {
  final String? message;
  const SearchError(this.message);

  @override
  List<Object> get props => [];
}
