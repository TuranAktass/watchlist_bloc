import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
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
            centerTitle: true,
            backgroundColor: Colors.white,
            title:
                const Text('Watchlist', style: TextStyle(color: Colors.black))),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: BlocProvider(
                create: (_) => _searchBloc,
                child: SearchField(),
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
                print('BUILDER CALLED WITH ${state.toString()}');
                if (state is SearchInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetSearchResult) {
                  print('get search result');

                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoading) {
                  print('SEARCH LOADING VIEW');
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
