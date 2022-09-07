import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/feat/auth/repository/auth_repository.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthenticationStarted>(_onAuthStarted);
    on<AuthenticationSignedOut>(_onSignOut);
  }

  _onAuthStarted(AuthenticationStarted event, Emitter<AuthState> emit) async {
    UserModel user = await authRepository.getCurrentUser().first;
    if (user.uid != "uid") {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  _onSignOut(AuthenticationSignedOut event, Emitter<AuthState> emit) async {
    authRepository.signOut();
    emit(Unauthenticated());
  }
}
