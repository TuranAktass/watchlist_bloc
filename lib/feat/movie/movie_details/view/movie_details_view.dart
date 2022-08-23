import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/custom/rating_starts.dart';
import 'package:watchlist/feat/movie/movie_details/bloc/movie_details_bloc.dart';
import 'package:watchlist/feat/movie/movie_details/repository/model/movie_details_model.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  final MovieDetailsBloc _detailsBloc = MovieDetailsBloc();
  @override
  void initState() {
    _detailsBloc.add(GetDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (_) => _detailsBloc,
              child: BlocListener<MovieDetailsBloc, DetailsState>(
                  listener: (context, state) {
                if (state is DetailsError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message!)));
                }
              }, child: BlocBuilder<MovieDetailsBloc, DetailsState>(
                      builder: (context, state) {
                if (state is DetailsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DetailsLoaded) {
                  return _buildDetails(state.props.first);
                } else if (state is DetailsError) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox.shrink();
                }
              })),
            ),
          ),
        ));
  }

  _buildDetails(MovieDetailsModel details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _NetworkPosterView(poster: details.poster!)),
        const SizedBox(height: 16),
        Text('${details.title!}, ${details.year!}',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white)),
        const SizedBox(height: 16),
        RateStars(rating: details.imdbRating!),
        const SizedBox(height: 16),
        GenreRow(genres: details.genre!),
        const SizedBox(height: 16),
        Text(details.plot!,
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
        Text('Director: ${details.director!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
        Text('Actors: ${details.actors!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
        Text('Writer: ${details.writer!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
        Text('Awards: ${details.awards!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
        Text('Released: ${details.released!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 16),
      ],
    );
  }
}

class GenreRow extends StatelessWidget {
  const GenreRow({Key? key, required this.genres}) : super(key: key);
  final String genres;

  @override
  Widget build(BuildContext context) {
    List<String> genreList = genres.split(',');
    return Row(
      children: List.generate(genreList.length, (index) {
        return _buildGenreCard(genreList[index]);
      }),
    );
  }

  _buildGenreCard(String genre) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(genre, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _NetworkPosterView extends StatelessWidget {
  const _NetworkPosterView({Key? key, required this.poster}) : super(key: key);
  final String poster;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.black.withOpacity(1.0),
            Colors.black.withOpacity(0.9),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.7),

            // Colors.transparent // <-- you might need this if you want full transparency at the edge
          ],
          stops: const [
            0.0,
            0.5,
            0.55,
            1.0,
          ], //<-- the gradient is interpolated, and these are where the colors above go into effect (that's why there are two colors repeated)
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Image.network(poster,
          width: size.width, height: size.height * 0.56, fit: BoxFit.cover),
    );
  }
}
