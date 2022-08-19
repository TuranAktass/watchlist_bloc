part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
