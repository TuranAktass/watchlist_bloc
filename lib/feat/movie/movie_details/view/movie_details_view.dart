import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(),
        body: BlocProvider(
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
        ));
  }

  _buildDetails(MovieDetailsModel details) {
    return Column(
      children: [Image.network(details.poster!)],
    );
  }
}
