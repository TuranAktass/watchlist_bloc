import 'package:flutter/material.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';

class MoviePosterView extends StatelessWidget {
  const MoviePosterView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieBasicModel movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsView(id: movie.imdbID!))),
      child: Container(
          margin: const EdgeInsets.all(8.0),
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: Image.network(movie.poster!).image,
                  fit: BoxFit.cover))),
    );
  }
}
