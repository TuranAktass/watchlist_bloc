import 'dart:convert';

import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';
import 'package:http/http.dart' as http;

class SearchProvider {
  final String url = 'http://www.omdbapi.com/?apikey=cebce6&s=';

  Future<SearchResponseModel> fetchSearchResult({String? query}) async {
    print('PROVIDER : $query');
    final response = await http.get(Uri.parse(url + query.toString()));
    if (response.statusCode == 200) {
      print(response.body);
      return SearchResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
