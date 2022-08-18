import 'dart:convert';

import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';

class MovieDetailsProvider {
  final String url = 'http://www.omdbapi.com/?apikey=cebce6&i=';

  Future<MovieDetailsModel> fetchDetails({String? id}) async {
    print('PROVIDER : $id');
    final response = await http.get(Uri.parse(url + id.toString()));
    if (response.statusCode == 200) {
      print(response.body);
      return MovieDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
