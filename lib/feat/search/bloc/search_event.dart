part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResult extends SearchEvent {
  final String? query;
  const GetSearchResult({this.query});

  @override
  List<Object> get props => query != null ? [query!] : [];
}

class GetUserSearchResult extends SearchEvent {
  final String? query;
  const GetUserSearchResult({this.query});

  @override
  List<Object> get props => query != null ? [query!] : [];
}
