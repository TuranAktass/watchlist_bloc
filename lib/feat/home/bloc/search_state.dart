part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchInputSubmitted extends SearchState {
  final String searchText;
  const SearchInputSubmitted({required this.searchText});
  @override
  List<String> get props => [searchText];
}

class SearchLoaded extends SearchState {
  final SearchResponseModel searchResponse;
  const SearchLoaded(this.searchResponse);
}

class SearchError extends SearchState {
  final String? message;
  const SearchError(this.message);
}
