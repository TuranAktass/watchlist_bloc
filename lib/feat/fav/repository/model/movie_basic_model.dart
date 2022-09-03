import 'package:equatable/equatable.dart';
import 'package:watchlist/feat/search/repository/model/movie_model/movie_response_model.dart';

class MovieBasicModel extends Equatable {
  String? year;
  String? imdbID;
  String? type;
  String? title;
  String? poster;

  MovieBasicModel.fromSearchResponse({required MovieResponseModel model}) {
    imdbID = model.imdbID;
    title = model.title;
    poster = model.poster;
    type = model.type;
    year = model.year;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['imdbID'] = imdbID!;
    data['title'] = title!;
    data['poster'] = poster!;
    data['type'] = type!;
    data['year'] = year!;
    return data;
  }

  MovieBasicModel.fromJson({required Map<String, dynamic> json}) {
    imdbID = json['imdbID'];
    title = json['title'];
    poster = json['poster'];
    type = json['type'];
    year = json['year'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [imdbID];
}
