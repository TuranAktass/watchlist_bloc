import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/auth/repository/auth_repository.dart';
import 'package:watchlist/feat/auth/view/welcome_view/welcome_view.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/fav/view/favorites_view.dart';
import 'package:watchlist/feat/home/bloc/search_bloc.dart';
import 'package:watchlist/feat/home/repository/model/movie_model/movie_response_model.dart';
import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';

class WatchlistHomeView extends StatefulWidget {
  const WatchlistHomeView({Key? key}) : super(key: key);

  @override
  State<WatchlistHomeView> createState() => _WatchlistHomeViewState();
}

class _WatchlistHomeViewState extends State<WatchlistHomeView> {
  final SearchBloc _searchBloc = SearchBloc();

  @override
  @override
  void initState() {
    super.initState();

    _searchBloc.add(const GetSearchResult(query: 'batman'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WatchlistAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.favorite, color: WatchlistColors.punch),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesView())),
              )
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
            title:
                const Text('Watchlist', style: TextStyle(color: Colors.black))),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => IconButton(
                      icon: const Icon(Icons.exit_to_app, color: Colors.black),
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthenticationSignedOut());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomeView()),
                            (route) => true);
                      }),
                )),

            //context.read<AuthBloc>().add(AuthenticationStarted());
            //context.read<AuthBloc>().add(AuthenticationStarted());
            Expanded(
              flex: 1,
              child: BlocProvider(
                create: (_) => _searchBloc,
                child: const SearchField(),
              ),
            ),
            Expanded(flex: 9, child: _buildSearchResult())
          ],
        ));
  }

  _buildSearchResult() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
            create: (_) => _searchBloc,
            child: BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
              if (state is SearchError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              }
            }, child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetSearchResult) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  return _buildSearchResultList(state.searchResponse);
                } else if (state is SearchError) {
                  return Center(child: Text(state.message.toString()));
                } else {
                  return Container();
                }
              },
            ))));
  }

  _buildSearchResultList(SearchResponseModel searchResponse) {
    return ListView.builder(
        itemCount: searchResponse.search!.length,
        itemBuilder: (context, index) {
          return MovieListItem(model: searchResponse.search![index]);
        });
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        bloc: context.read<SearchBloc>(),
        builder: (context, val) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (query) {
                  context.read<SearchBloc>().add(GetSearchResult(query: query));
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search)),
              ),
            ));
  }
}

class MovieListItem extends StatelessWidget {
  final MovieResponseModel model;

  const MovieListItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsView(id: model.imdbID!))),
        title: Text(model.title!),
        subtitle: Text(model.year!),
        trailing: BlocProvider(
          create: (context) => FavoritesBloc(),
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
            return IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () async {
                  var uid = FirebaseAuth.instance.currentUser!.uid;

                  context
                      .read<FavoritesBloc>()
                      .add(FavoritesAdd(uid: uid, id: model.imdbID!));
                });
          }),
        ),
        leading: SizedBox(
          width: 50,
          height: 200,
          child: Image.network(
            model.poster!,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, object, _) =>
                Image.asset('assets/images/no_image.png'),
          ),
        ));
  }
}
