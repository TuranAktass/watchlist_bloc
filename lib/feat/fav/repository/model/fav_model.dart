import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';

class FavResponseModel {
  List<MovieBasicModel> favList = [];
  String? error;

  FavResponseModel.withError(this.error);

  FavResponseModel({required List<Map<String, dynamic>> data}) {
    for (var element in data) {
      favList.add(MovieBasicModel.fromJson(json: element));
    }
  }

  List<MovieBasicModel> get list => favList;
}
