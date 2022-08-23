import 'package:flutter/material.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/auth/view/sign_in_view/sign_in_view.dart';
import 'package:watchlist/feat/auth/view/sign_up_view/sign_up_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WatchlistColors.ebonyClay,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              Text(
                'Watchlist',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 64),
              _NavigateToLoginButton(),
              const SizedBox(height: 16),
              _NavigateToRegisterButton(),
              const SizedBox(height: 64),
            ],
          ),
        ));
  }
}

class _NavigateToLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width - 100,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: WatchlistColors.deYork,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInView(),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(WatchlistStrings.login,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
            )),
      ),
    );
  }
}

class _NavigateToRegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width - 100,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpView(),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(WatchlistStrings.register,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: WatchlistColors.deYork)),
            )),
      ),
    );
  }
}
