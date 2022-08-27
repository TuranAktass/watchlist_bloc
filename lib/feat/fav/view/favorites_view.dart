import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/components/custom/scaffold_body_padding.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final FavoritesBloc _favoritesBloc = FavoritesBloc();
  @override
  initState() {
    super.initState();
    _favoritesBloc.add(const FavoritesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WatchlistAppBar(
          backgroundColor: WatchlistColors.white,
          title: const Text(WatchlistStrings.favorites,
              style: TextStyle(color: WatchlistColors.cork)),
        ),
        body: BodyPadding(
            child: BlocProvider(
                create: (context) => _favoritesBloc,
                child: BlocListener<FavoritesBloc, FavoritesState>(
                    listener: ((context, state) {
                  if (state is FavoritesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occured')));
                  }
                }), child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                  if (state is FavoritesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is FavoritesLoaded) {
                    return ListView.builder(
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          var fav = state.favorites[index];
                          return ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetailsView(
                                          id: fav.imdbID!,
                                        ))),
                            leading: Image.network(fav.poster!),
                            title: Text(fav.title!),
                            subtitle: Text(fav.year!),
                          );
                        });
                  } else if (state is FavoritesError) {
                    return Text('Favorites Error');
                  } else {
                    return Text('Favorites Unknown: ${state.toString()}');
                  }
                })))));
  }
}
