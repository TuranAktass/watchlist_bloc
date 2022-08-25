part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final UserModel user;
  final String? displayName;
  const DatabaseSuccess(this.user, this.displayName);

  @override
  List<Object?> get props => [user, displayName];
}

class DatabaseError extends DatabaseState {
  @override
  List<Object?> get props => [];
}
