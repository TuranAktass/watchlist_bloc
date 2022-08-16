import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';
import 'package:watchlist/feat/home/resources/search_provider.dart';

class SearchRepository {
  final _searchProvider = SearchProvider();

  Future<SearchResponseModel> fetchSearchResult(String search) {
    return _searchProvider.fetchSearchResult(search);
  }
}
