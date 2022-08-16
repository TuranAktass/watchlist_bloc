part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResult extends SearchEvent {}

class SearchInputSubmit extends SearchEvent {
  final String searchText;

  const SearchInputSubmit({required this.searchText});
}
