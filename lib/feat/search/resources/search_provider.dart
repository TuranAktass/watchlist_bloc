import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watchlist/feat/search/repository/model/search_model/search_response_model.dart';

class SearchProvider {
  final String url = 'http://www.omdbapi.com/?apikey=cebce6&s=';

  Future<SearchResponseModel> fetchSearchResult({String? query}) async {
    final response = await http.get(Uri.parse(url + query.toString()));
    if (response.statusCode == 200) {
      return SearchResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
