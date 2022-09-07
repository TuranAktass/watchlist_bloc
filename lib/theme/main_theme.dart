import 'package:flutter/material.dart';
import 'package:watchlist/constants/watchlist_colors.dart';

class WatchlistTheme {
  static ThemeData get mainTheme => ThemeData(
        primaryColor: WatchlistColors.greenPea,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: WatchlistColors.cork),
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: WatchlistColors.white,
            iconColor: WatchlistColors.cork,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: WatchlistColors.greenPea)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: WatchlistColors.grey))),
      );
}
