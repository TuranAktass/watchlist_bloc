import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailsProvider {
  final String url = 'http://www.omdbapi.com/?apikey=cebce6&i=';

  Future<MovieDetailsModel> fetchDetails({String? id}) async {
    final response = await http.get(Uri.parse(url + id.toString()));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
