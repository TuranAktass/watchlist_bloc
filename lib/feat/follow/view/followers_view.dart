import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/feat/follow/bloc/follow_bloc.dart';

class FollowersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FollowBloc()..add(GetFollowData()),
        child: BlocBuilder<FollowBloc, FollowState>(builder: (context, state) {
          if (state is FollowLoading) {
            return const LoadingWidget();
          } else if (state is FollowPageLoaded) {
            return TextButton(
              onPressed: () {
                showModalBottomSheet(
                    elevation: 4,
                    constraints: const BoxConstraints(maxHeight: 400),
                    context: context,
                    builder: (context) => _buildFollowers(state.followers));
              },
              child: Text('Followers: ${state.followers.length}'),
            );
          } else if (state is FollowPageError) {
            return Text(state.message);
          } else {
            log(state.toString());
            return const LoadingWidget();
          }
        }));
  }

  _buildFollowers(followers) {
    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(),
        title: Text(followers[index].displayName),
        subtitle: Text(followers[index].email),
      ),
    );
  }
}
