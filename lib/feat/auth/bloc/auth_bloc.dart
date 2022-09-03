import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:watchlist/feat/auth/repository/auth_repository.dart';
import 'package:watchlist/feat/auth/repository/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    {
      on<AuthEvent>((event, emit) async {
        if (event is AuthenticationStarted) {
          UserModel user = await authRepository.getCurrentUser().first;
          if (user.uid != "uid") {
            String? displayName = await authRepository.retrieveUserName(user);
            emit(AuthSuccess(displayName: displayName));
          } else {
            emit(AuthenticationFailure());
          }
        } else if (event is AuthenticationSignedOut) {
          await authRepository.signOut();
          
        }
      });
    }
  }
}
