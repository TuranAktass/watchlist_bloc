import 'package:flutter/material.dart';
import 'package:watchlist/constants/watchlist_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(color: WatchlistColors.deYork));
  }
}
