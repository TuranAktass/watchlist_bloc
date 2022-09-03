import 'package:watchlist/feat/search/repository/model/movie_model/movie_response_model.dart';

class SearchResponseModel {
  List<MovieResponseModel>? search;
  String? totalResults;
  String? response;
  String? error;

  SearchResponseModel.withError(String errorMessage) {
    error = errorMessage;
  }

  SearchResponseModel({this.search, this.totalResults, this.response});

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      search = <MovieResponseModel>[];
      json['Search'].forEach((v) {
        search!.add(MovieResponseModel.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (search != null) {
      data['Search'] = search!.map((v) => v.toJson()).toList();
    }
    data['totalResults'] = totalResults;
    data['Response'] = response;
    return data;
  }
}
