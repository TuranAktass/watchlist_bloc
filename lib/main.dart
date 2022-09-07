import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/loading/loading.dart';
import 'package:watchlist/components/loading/loading_dialog.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/auth/bloc/bloc_observer.dart';
import 'package:watchlist/feat/auth/repository/auth_repository.dart';
import 'package:watchlist/feat/auth/view/sign_in_view/sign_in_view.dart';
import 'package:watchlist/feat/auth/view/welcome_view/welcome_view.dart';
import 'package:watchlist/feat/database/bloc/database_bloc.dart';
import 'package:watchlist/feat/database/repository/database_repository.dart';
import 'package:watchlist/feat/fav/bloc/favorites_bloc.dart';
import 'package:watchlist/feat/form/bloc/form_bloc.dart';
import 'package:watchlist/feat/navigation/view/navbar_view.dart';
import 'package:watchlist/firebase_options.dart';
import 'package:watchlist/theme/main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = AppBlocObserver();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => FormBloc()),
      BlocProvider(create: (context) => DatabaseBloc(DatabaseRepositoryImpl())),
      BlocProvider(
          create: (context) =>
              AuthBloc(AuthRepository())..add(const AuthenticationStarted())),
      BlocProvider(
          create: (context) => FavoritesBloc()..add(const FavoritesLoad()))
    ], child: const WatchlistApp()),
  );
}

class WatchlistApp extends StatelessWidget {
  const WatchlistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: WatchlistTheme.mainTheme,
      home: const BlocNavigate(),
    );
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Loading) {
          return const LoadingWidget();
        } else if (state is Authenticated) {
          return const WatchlistNavBar();
        } else if (state is Unauthenticated) {
          return const WelcomeView();
        } else {
          return const SignInView();
        }
      },
    );
  }
}
