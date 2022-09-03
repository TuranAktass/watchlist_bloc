import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/components/custom/scaffold_body_padding.dart';
import 'package:watchlist/components/dialog/error_dialog.dart';
import 'package:watchlist/constants/watchlist_colors.dart';
import 'package:watchlist/constants/watchlist_strings.dart';
import 'package:watchlist/feat/auth/bloc/auth_bloc.dart';
import 'package:watchlist/feat/form/bloc/form_bloc.dart';
import 'package:watchlist/feat/search/view/search_view/seach_view.dart';

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
                  MaterialPageRoute(builder: (context) => const SearchView()),
                  (Route<dynamic> route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: WatchlistColors.ebonyClay,
        body: BodyPadding(
          child: _RegisterFormContainer(),
        ),
      ),
    );
  }
}

class _RegisterFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: WatchlistColors.white.withOpacity(0.3),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 8.0,
          children: [
            Text(WatchlistStrings.register,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white)),
            const SizedBox(height: 8.0),
            const _EmailField(),
            const _PasswordField(),
            const _AgeField(),
            const _DisplayNameField(),
            const _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);
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
              labelText: WatchlistStrings.email,
              helperText: WatchlistInfoStrings.emailInformation,
              errorText:
                  !state.isEmailValid ? WatchlistErrorStrings.email : null,
              hintText: WatchlistStrings.email,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
              helperText: WatchlistInfoStrings.passwordInformation,
              helperMaxLines: 2,
              labelText: WatchlistStrings.password,
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? WatchlistErrorStrings.password
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
  const _DisplayNameField({Key? key}) : super(key: key);
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
              labelText: WatchlistStrings.nickname,
              helperText: WatchlistInfoStrings.nicknameInformation,
              errorText:
                  !state.isNameValid ? WatchlistErrorStrings.nickname : null,
              hintText: WatchlistStrings.nickname,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            )),
      );
    });
  }
}

class _AgeField extends StatelessWidget {
  const _AgeField({Key? key}) : super(key: key);
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
              labelText: WatchlistStrings.age,
              helperText: WatchlistInfoStrings.ageInformation,
              errorText: !state.isAgeValid ? WatchlistErrorStrings.age : null,
              hintText: WatchlistStrings.age,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            )),
      );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormValidate>(
        builder: (context, state) => state.isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
                width: 200,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: WatchlistColors.deYork),
                  child: const Text(WatchlistStrings.register),
                  onPressed: () => !state.isFormValid
                      ? context
                          .read<FormBloc>()
                          .add(const FormSubmitted(Status.register))
                      : null,
                ),
              ));
  }
}
