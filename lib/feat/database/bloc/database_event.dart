part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseFetched extends DatabaseEvent {
  final String? displayName;
  const DatabaseFetched(this.displayName);
  @override
  List<Object?> get props => [displayName];
}

class FetchUserDate extends DatabaseEvent {
  final UserModel? user;

  const FetchUserDate(this.user);
  @override
  List<Object?> get props => [user];
}
