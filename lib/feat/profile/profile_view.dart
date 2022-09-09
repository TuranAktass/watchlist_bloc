import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/components/custom/scaffold_body_padding.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/database/bloc/database_bloc.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/follow/view/followers_view.dart';
import 'package:watchlist/feat/follow/view/followings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WatchlistAppBar(
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(color: WatchlistColors.cork)),
        backgroundColor: Colors.white,
      ),
      body: BodyPadding(
        child: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            if (state is DatabaseInitial) {
              context.read<DatabaseBloc>().add(FetchUserDate());
            }
            if (state is DatabaseSuccess) {
              return _buildUserInformation(state);
            } else {
              log('state is ${state.runtimeType}');
              return const LoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserInformation(DatabaseSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* const CircleAvatar(radius: 70),
        const _VerticalPadding(),
        _DisplayNameView(name: state.displayName ?? ''),
        const _VerticalPadding(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [FollowersView(), FollowingsView()],
        ),
        const _VerticalPadding(),

        ///_UserLists(),
        _FavList(), */
        const LogoutButton()
      ],
    );
  }
}

class _UserLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Lists',
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: WatchlistColors.ebonyClay),
      ),
    );
  }
}

class _DisplayNameView extends StatelessWidget {
  const _DisplayNameView({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: WatchlistColors.ebonyClay));
  }
}

class _FavList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const LoadingWidget();
        } else if (state is FavoritesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(WatchlistStrings.favorites,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: WatchlistColors.ebonyClay)),
              SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: state.favorites.length > 5
                          ? 5
                          : state.favorites.length,
                      itemBuilder: (context, index) {
                        var movie = state.favorites[index];
                        return ListTile(
                          leading: Image.network(movie.poster!),
                          title: Text(movie.title!),
                          subtitle: Text(movie.year!),
                        );
                      })),
            ],
          );
        } else {
          return ErrorWidget(state);
        }
      },
    );
  }
}

class _VerticalPadding extends StatelessWidget {
  const _VerticalPadding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 16);
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.exit_to_app, color: Colors.black),
        onPressed: () {
          context.read<AuthBloc>().add(AuthenticationSignedOut());
        });
  }
}
