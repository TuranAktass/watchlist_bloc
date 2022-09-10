import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/custom/genre_row_view.dart';
import 'package:watchlist/components/custom/rating_starts.dart';
import 'package:watchlist/components/padding/vertical_padding.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
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
        backgroundColor: Colors.white,
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
        const VerticalPadding(),
        const VerticalPadding(),
        Center(child: _NetworkPosterView(poster: details.poster!)),
        const VerticalPadding(),
        Text('${details.title!}, ${details.year!}',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: WatchlistColors.ebonyClay)),
        const VerticalPadding(),
        RateStars(rating: details.imdbRating!),
        const VerticalPadding(),
        GenreRow(genres: details.genre!),
        const VerticalPadding(),
        Text(details.plot!,
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding(),
        Text('${WatchlistFeatStrings.director}: ${details.director!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding(),
        Text('${WatchlistFeatStrings.actors}: ${details.actors!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding(),
        Text('${WatchlistFeatStrings.writer}: ${details.writer!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding(),
        Text('${WatchlistFeatStrings.awards}: ${details.awards!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding(),
        Text('${WatchlistFeatStrings.released}: ${details.released!}',
            style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const VerticalPadding()
      ],
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
            1,
            1,
            1,
            1
            /* 0.0,
            0.5,
            0.55,
            1.0, */
          ], //<-- the gradient is interpolated, and these are where the colors above go into effect (that's why there are two colors repeated)
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.network(poster, fit: BoxFit.fitWidth).image)),
      ),
    );
  }
}
