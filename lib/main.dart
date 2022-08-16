import 'package:flutter/material.dart';
import 'package:watchlist/feat/home/view/home_view/home_view.dart';

void main() => runApp(WatchlistApp());

class WatchlistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WatchlistHomeView(),
    );
  }
}
