import 'package:flutter/material.dart';

class WatchlistAppBar extends AppBar {
  WatchlistAppBar({
    Key? key,
    Widget? title,
    List<Widget>? actions,
    Widget? leading,
    bool? automaticallyImplyLeading = true,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? backgroundColor,
    Brightness? brightness,
    IconThemeData? iconTheme,
    TextTheme? textTheme,
    bool? primary = true,
    bool? centerTitle = false,
    double? titleSpacing = NavigationToolbar.kMiddleSpacing,
    double? toolbarOpacity = 1.0,
    double? bottomOpacity = 1.0,
  }) : super(
          key: key,
          title: title,
          actions: actions,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading ?? true,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          backgroundColor: backgroundColor,
          iconTheme: iconTheme,
          primary: primary ?? false,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity ?? 0.0,
          bottomOpacity: bottomOpacity ?? 0.0,
        );
}
