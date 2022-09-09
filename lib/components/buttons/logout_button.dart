import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';

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
