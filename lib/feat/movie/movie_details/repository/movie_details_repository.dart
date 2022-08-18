import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';
import 'package:watchlist/feat/movie/movie_details/resources/details_provider.dart';

class MovieDetailsRepository {
  final _detailsProvider = MovieDetailsProvider();

  Future<MovieDetailsModel> fetchDetails({String? id}) async {
    var data = await _detailsProvider.fetchDetails(id: id);
    return data;
  }
}
