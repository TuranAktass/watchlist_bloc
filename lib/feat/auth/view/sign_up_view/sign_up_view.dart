import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/dialog/error_dialog.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/form/bloc/form_bloc.dart';
import 'package:watchlist/feat/home/view/home_view/home_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormValidate>(listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(errorMessage: state.errorMessage));
          } else if (state.isFormValid && !state.isLoading) {
            context.read<AuthBloc>().add(AuthenticationStarted());
            context.read<FormBloc>().add(const FormSucceeded());
          } else if (state.isFormValidateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form is not valid')));
          }
        }),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const WatchlistHomeView()),
                  (Route<dynamic> route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              _EmailField(),
              _PasswordField(),
              _AgeField(),
              _DisplayNameField(),
              _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(builder: (context, state) {
      return SizedBox(
        width: size.width * 0.8,
        child: TextFormField(
            onChanged: (value) =>
                context.read<FormBloc>().add(EmailChanged(value)),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: 'A complete, valid email e.g. joe@gmail.com',
              errorText: !state.isEmailValid
                  ? 'Please ensure the email entered is valid'
                  : null,
              hintText: 'Email',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(),
            )),
      );
    });
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(),
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _DisplayNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(builder: (context, state) {
      return SizedBox(
        width: size.width * 0.8,
        child: TextFormField(
            onChanged: (value) =>
                context.read<FormBloc>().add(NameChanged(value)),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nickname',
              helperText: 'Nickname',
              errorText: !state.isNameValid
                  ? 'Please ensure the nickname entered is valid'
                  : null,
              hintText: 'Name',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: const OutlineInputBorder(),
            )),
      );
    });
  }
}

class _AgeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(builder: (context, state) {
      return SizedBox(
        width: size.width * 0.8,
        child: TextFormField(
            onChanged: (value) =>
                context.read<FormBloc>().add(AgeChanged(int.parse(value))),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Age',
              helperText: 'At least 13',
              errorText: !state.isAgeValid
                  ? 'Please ensure the age entered is valid'
                  : null,
              hintText: 'Age',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: const OutlineInputBorder(),
            )),
      );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormValidate>(
        builder: (context, state) => state.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('SUBMIT'),
                onPressed: () => !state.isFormValid
                    ? context
                        .read<FormBloc>()
                        .add(const FormSubmitted(Status.signUp))
                    : null,
              ));
  }
}
