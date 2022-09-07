import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/custom/scaffold_body_padding.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/form/bloc/form_bloc.dart';
import 'package:watchlist/feat/navigation/view/navbar_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormValidate>(
            listener: (context, state) {
              if (state.isFormValid && !state.isLoading) {
                context.read<AuthBloc>().add(const AuthenticationStarted());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is not valid')));
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const WatchlistNavBar()),
                    (Route<dynamic> route) => false);
              }
            },
          )
        ],
        child: const Scaffold(
            backgroundColor: WatchlistColors.ebonyClay,
            body: BodyPadding(
              child: _SignInContainer(),
            )));
  }
}

class _SignInContainer extends StatelessWidget {
  const _SignInContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(WatchlistStrings.login,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: WatchlistColors.white)),
            const SizedBox(height: 64),
            _EmailField(),
            const SizedBox(height: 16),
            _PasswordField(),
            const SizedBox(height: 32),
            _SubmitButton(),
            //_SignInNavigate()
          ],
        ));
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          hintText: WatchlistStrings.email,
          suffixIcon: Icon(Icons.email),
        ),
        onChanged: (value) => context.read<FormBloc>().add(EmailChanged(value)),
      );
    });
  }
}

class _PasswordField extends StatefulWidget {
  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(builder: ((context, state) {
      return TextFormField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: WatchlistStrings.password,
          suffixIcon: InkWell(
              onTap: () => changePasswordVisibility(),
              child: const Icon(Icons.lock)),
        ),
        onChanged: (value) =>
            context.read<FormBloc>().add(PasswordChanged(value)),
      );
    }));
  }

  void changePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width / 1.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: WatchlistColors.deYork),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(WatchlistStrings.login,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: WatchlistColors.white)),
            ),
            onPressed: () {
              context.read<FormBloc>().add(const FormSubmitted(Status.login));
            },
          ),
        );
      },
    );
  }
}
