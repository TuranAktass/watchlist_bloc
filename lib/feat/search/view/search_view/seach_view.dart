import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/constants/enums.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/auth/view/welcome_view/welcome_view.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/follow/bloc/follow_bloc.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';
import 'package:watchlist/feat/search/bloc/search_bloc.dart';
import 'package:watchlist/feat/search/repository/model/movie_model/movie_response_model.dart';
import 'package:watchlist/feat/search/repository/model/search_model/search_response_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
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
            centerTitle: true,
            backgroundColor: Colors.white,
            title:
                const Text('Watchlist', style: TextStyle(color: Colors.black))),
        body: Column(
          children: [
            Expanded(
              flex: 2,
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
                } else if (state is UserSearchLoaded) {
                  return _buildUserSearchResultList(state.users);
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

  _buildUserSearchResultList(users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(users[index].displayName.toString()),
            subtitle: Text(users[index].email.toString()),
            trailing: SizedBox(
              width: 44,
              height: 44,
              child: BlocProvider(
                  create: (context) => FollowBloc(),
                  child: BlocBuilder<FollowBloc, FollowState>(
                      builder: (context, state) {
                    return IconButton(
                        icon: const Icon(CupertinoIcons.person_add),
                        onPressed: () {
                          context
                              .read<FollowBloc>()
                              .add(FollowRequest(uid: users[index].uid));
                        });
                  } /* else if (state is FollowError) {
                        return _buildFollowButton(false);
                      }  */

                      )),
            ),
          );
        });
  }
}

/**/

//TODO refactor :D
class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  SearchType _searchType = SearchType.movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SearchBloc, SearchState>(
            bloc: context.read<SearchBloc>(),
            builder: (context, val) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (query) {
                      if (_searchType == SearchType.movie) {
                        context
                            .read<SearchBloc>()
                            .add(GetSearchResult(query: query));
                      } else if (_searchType == SearchType.user) {
                        context
                            .read<SearchBloc>()
                            .add(GetUserSearchResult(query: query));
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search)),
                  ),
                )),
        Wrap(
          spacing: 16,
          children: _buildSearchTypeChips(),
        )
      ],
    );
  }

  List<Widget> _buildSearchTypeChips() {
    return [
      ChoiceChip(
          selectedColor: WatchlistColors.deYork,
          avatar: const Icon(Icons.movie),
          label: const Text(EnumTitles.movie),
          selected: (_searchType == SearchType.movie),
          onSelected: (val) {
            setState(() {
              _searchType = SearchType.movie;
            });
          }),
      ChoiceChip(
          selectedColor: WatchlistColors.deYork,
          avatar: const Icon(Icons.person),
          label: const Text(EnumTitles.user),
          selected: (_searchType == SearchType.user),
          onSelected: (val) {
            setState(() {
              _searchType = SearchType.user;
            });
          }),
    ];
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
        trailing: SizedBox(
          width: 50,
          height: 50,
          child: _FavoriteButton(
              model: MovieBasicModel.fromSearchResponse(model: model)),
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

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({Key? key, required this.model}) : super(key: key);
  final MovieBasicModel model;
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  @override
  initState() {
    super.initState();
  }

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoad) {
          return const Text('fav load');
        }
        /* if (state is FavoritesLoading) {
          return const LoadingWidget();
        } */
        if (state is FavoritesLoaded) {
          if (state.favorites.contains(widget.model)) {
            return _buildRemoveFavButton();
          } else {
            return _buildAddFavButton();
          }
        }
        if (state is FavoritesRemove) {
          return const Text('fav remove');
        }
        if (state is FavoritesLoading || state is FavoritesInitial) {
          return const LoadingWidget();
        }
        if (state is FavoritesAdd) {
          return const Text('fav add');
        } else {
          return Text('fav error: ${state.toString()}');
        }
      },
    );
  }

  String _getUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  _buildAddFavButton() {
    return IconButton(
      icon: const Icon(Icons.favorite_border),
      onPressed: () {
        context
            .read<FavoritesBloc>()
            .add(FavoritesAdd(uid: _getUID(), movie: widget.model));
      },
    );
  }

  _buildRemoveFavButton() {
    return IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () {
          context
              .read<FavoritesBloc>()
              .add(FavoritesRemove(uid: _getUID(), movie: widget.model));
        });
  }
}
