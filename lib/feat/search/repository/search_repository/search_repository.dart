import 'dart:developer';

import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';
import 'package:watchlist/feat/search/repository/model/search_model/search_response_model.dart';
import 'package:watchlist/feat/search/resources/search_provider.dart';

class SearchRepository {
  final _searchProvider = SearchProvider();

  Future<SearchResponseModel> fetchSearchResult({String? query}) async {
    log('DATA: $query');
    var data = await _searchProvider.fetchSearchResult(query: query);
    return data;
  }

  Future<List<FollowUserModel>> fetchUserSearchResult({String? query}) async {
    log('DATA: $query');
    var data = await _searchProvider.fetchUserSearchResult(query: query);
    return data;
  }
}
