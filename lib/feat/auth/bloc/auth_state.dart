part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final String? displayName;
  const AuthSuccess({this.displayName});

  @override
  List<Object> get props => [displayName ?? ''];
}

class AuthenticationFailure extends AuthState {
  const AuthenticationFailure();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthState {
  @override
  List<Object> get props => [];
}

class LogoutCompleted extends AuthState {
  @override
  List<Object> get props => [];
}
