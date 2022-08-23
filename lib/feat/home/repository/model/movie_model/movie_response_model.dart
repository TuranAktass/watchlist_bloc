class MovieResponseModel {
  String? year;
  String? imdbID;
  String? type;
  String? title;
  String? poster;

  MovieResponseModel(
      {this.title, this.year, this.imdbID, this.type, this.poster});

  MovieResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Year'] = year;
    data['imdbID'] = imdbID;
    data['Type'] = type;
    data['Poster'] = poster;
    return data;
  }
}
