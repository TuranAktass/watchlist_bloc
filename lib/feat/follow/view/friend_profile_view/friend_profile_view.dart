import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/app_bar/watchlist_appbar.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/components/padding/vertical_padding.dart';
import 'package:watchlist/components/profile_components/avatar_view.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/fav/repository/model/movie_basic_model.dart';
import 'package:watchlist/feat/follow/bloc/follow_bloc.dart';
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';
import 'package:watchlist/feat/movie/movie_details/view/movie_details_view.dart';

class FriendProfileView extends StatelessWidget {
  const FriendProfileView({Key? key, required this.model}) : super(key: key);

  final FollowUserModel model;
  @override
  Widget build(BuildContext context) {
    print('model is ${model.uid}');
    return BlocProvider<FollowBloc>(
      create: (context) =>
          FollowBloc()..add(GetUserDetails(uid: model.uid ?? '')),
      child: Scaffold(
          appBar: WatchlistAppBar(
              backgroundColor: WatchlistColors.white,
              title: Text(model.displayName ?? '',
                  style: const TextStyle(color: WatchlistColors.cork))),
          body: BlocBuilder<FollowBloc, FollowState>(builder: (context, state) {
            if (state is UserDetailsLoading) {
              return const LoadingWidget();
            } else if (state is UserDetailsFetched) {
              return CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const VerticalPadding(),
                          const CircleAvatar(radius: 70),
                          const VerticalPadding(),
                          Text(state.user.displayName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: WatchlistColors.ebonyClay)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FollowersButton(followers: state.user.followers),
                              FollowingsButton(
                                  followings: state.user.followings)
                            ],
                          ),
                          SizedBox(
                              height: 400,
                              child: FavoritesList(movies: state.user.favs)),
                        ],
                      ))
                ],
              );
            } else {
              return Text(WatchlistErrorStrings.email);
            }
          })),
    );
  }
}

class FollowersButton extends StatelessWidget {
  const FollowersButton({Key? key, required this.followers}) : super(key: key);
  final List<FollowUserModel> followers;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('${WatchlistStrings.followers} : ${followers.length}'),
      onPressed: () => _buildFollowers(context),
    );
  }

  _buildFollowers(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: followers.length,
                itemBuilder: (context, index) {
                  var model = followers[index];
                  return ListTile(
                      leading:
                          AvatarView(radius: 30, url: model.displayName ?? ''),
                      title: Text(model.displayName ?? ''));
                }),
          );
        });
  }
}

class FollowingsButton extends StatelessWidget {
  const FollowingsButton({Key? key, required this.followings})
      : super(key: key);
  final List<FollowUserModel> followings;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('${WatchlistStrings.followings} : ${followings.length}'),
      onPressed: () => _buildFollowings(context),
    );
  }

  _buildFollowings(context) {
    showModalBottomSheet(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: ListView.builder(
                itemCount: followings.length,
                itemBuilder: (context, index) {
                  var model = followings[index];
                  return ListTile(
                      leading:
                          AvatarView(radius: 30, url: model.displayName ?? ''));
                }),
          );
        });
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key, required this.movies}) : super(key: key);
  final List<MovieBasicModel> movies;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Text(WatchlistStrings.favorites,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: WatchlistColors.ebonyClay))),
        Expanded(
            flex: 9,
            child: movies.isEmpty
                ? const Text('no favs yet')
                : ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 4.0),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsView(
                                  id: movie.imdbID!,
                                ),
                              )),
                          leading: Image.network(movie.poster ?? ''),
                          title: Text(movie.title ?? ''),
                        ),
                      );
                    },
                  ))
      ],
    );
  }
}
