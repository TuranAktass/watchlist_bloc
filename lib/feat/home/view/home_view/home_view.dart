import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/home/bloc/search_bloc.dart';
import 'package:watchlist/feat/home/repository/model/search_model/search_response_model.dart';

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

    _searchBloc.add(GetSearchResult());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white, title: const Text('Watchlist')),
        body: _buildSearchResult());
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
          return ListTile(
              title: Text(searchResponse.search![index].title!),
              subtitle: Text(searchResponse.search![index].year!),
              leading: Image.network(searchResponse.search![index].poster!));
        });
  }
}
