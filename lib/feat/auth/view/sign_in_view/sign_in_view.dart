import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/auth/view/sign_up_view/sign_up_view.dart';
import 'package:watchlist/feat/form/bloc/form_bloc.dart';
import 'package:watchlist/feat/home/view/home_view/home_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormValidate>(
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(errorMessage: state.errorMessage));
              } else if (state.isFormValid && !state.isLoading) {
                context.read<AuthBloc>().add(AuthenticationStarted());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Form is not valid')));
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const WatchlistHomeView()),
                    (Route<dynamic> route) => false);
              }
            },
          )
        ],
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.white),
            ),
            body: Column(
              children: [
                _EmailField(),
                _PasswordField(),
                _SubmitButton(),
                //_SignInNavigate()
              ],
            )));
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(builder: (context, state) {
      return TextFormField(
        onChanged: (value) => context.read<FormBloc>().add(EmailChanged(value)),
      );
    });
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(builder: ((context, state) {
      return TextFormField(
        onChanged: (value) =>
            context.read<FormBloc>().add(PasswordChanged(value)),
      );
    }));
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(
      builder: (context, state) {
        return ElevatedButton(
          child: Text('Sign In'),
          onPressed: () =>
              context.read<FormBloc>().add(FormSubmitted(Status.signIn)),
        );
      },
    );
  }
}
