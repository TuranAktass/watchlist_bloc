import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({Key? key, required this.url, required this.radius})
      : super(key: key);
  final String url;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundImage: Image.network(
          url,
          errorBuilder: (context, error, stackTrace) =>
              CircleAvatar(radius: radius),
        ).image);
  }
}
