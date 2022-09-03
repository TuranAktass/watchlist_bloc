import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/components/custom/scaffold_body_padding.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WatchlistAppBar(
        backgroundColor: WatchlistColors.white,
        title: const Text(WatchlistStrings.watchlist,
            style: TextStyle(color: WatchlistColors.cork)),
        centerTitle: true,
      ),
      body: BodyPadding(
        child: Column(
          children: [
            _FavoritesView(),
          ],
        ),
      ),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  final FavoritesBloc _favoritesBloc = FavoritesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _favoritesBloc..add(const FavoritesLoad()),
      child:
          BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
        if (state is FavoritesLoading) {
          return const LoadingWidget();
        } else if (state is FavoritesLoaded) {
          return state.favorites.isNotEmpty
              ? _buildFavList(state, context)
              : const SizedBox.shrink();
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildFavList(FavoritesLoaded state, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(WatchlistStrings.favorites,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: WatchlistColors.cork)),
        SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                var movie = state.favorites[index];
                return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: Image.network(movie.poster!).image,
                            fit: BoxFit.cover)));
              }),
        ),
      ],
    );
  }
}
