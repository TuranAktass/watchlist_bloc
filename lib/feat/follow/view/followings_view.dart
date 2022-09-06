import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/feat/follow/bloc/follow_bloc.dart';

class FollowingsView extends StatelessWidget {
  const FollowingsView({Key? key}) : super(key: key);

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
                    builder: (context) => _buildFollowers(state.followings));
              },
              child: Text('Followings: ${state.followings.length}'),
            );
          } else if (state is FollowPageError) {
            return Text(state.message);
          } else {
            log(state.toString());
            return const LoadingWidget();
          }
        }));
  }

  _buildFollowers(followings) {
    return ListView.builder(
        itemCount: followings.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(radius: 40),
            title: Text(followings[index].displayName),
            subtitle: Text(followings[index].email),
          );
        });
  }
}
