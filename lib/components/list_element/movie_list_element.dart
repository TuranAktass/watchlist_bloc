import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';

class MovieListElement extends StatelessWidget {
  const MovieListElement({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieBasicModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailsView(
                          id: movie.imdbID!,
                        ))),
            leading: Image.network(movie.poster!),
            title: Text(movie.title!),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => context.read<FavoritesBloc>().add(
                  FavoritesRemove(
                      uid: FirebaseAuth.instance.currentUser!.uid.toString(),
                      movie: movie)),
            ),
            subtitle: Text(movie.year!),
          ),
        ),
      ],
    );
  }
}
