import 'package:flutter/material.dart';
import 'package:watchlist/feat/auth/view/sign_in_view/sign_in_view.dart';
import 'package:watchlist/feat/auth/view/sign_up_view/sign_up_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('WELCOME'),
            _NavigateToSignUpButton(),
            _NavigateToSignInButton(),
          ],
        ));
  }
}

class _NavigateToSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpView(),
            )),
        child: Text('Kayıt Ol'));
  }
}

class _NavigateToSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInView(),
            )),
        child: Text('Giriş Yap'));
  }
}
