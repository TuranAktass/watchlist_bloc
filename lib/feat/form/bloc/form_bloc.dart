import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/feat/auth/repository/firebase_auth/auth_repository.dart';
import 'package:watchlist/feat/auth/repository/firebase_auth/model/user_model.dart';
import 'package:watchlist/feat/database/repository/database_repository.dart';
import 'package:watchlist/feat/form/validation_constants/validation_constants.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormValidate> {
  final AuthRepository _authRepository = AuthRepository();
  final DatabaseRepository _databaseRepository = DatabaseRepositoryImpl();
  FormBloc()
      : super(const FormValidate(
            email: "example@gmail.com",
            password: "",
            isEmailValid: true,
            isPasswordValid: true,
            isFormValid: false,
            isLoading: false,
            isNameValid: true,
            age: 0,
            isAgeValid: true,
            isFormValidateFailed: false)) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSucceeded>(_onFormSucceeded);
  }

  _onEmailChanged(EmailChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }

  _onNameChanged(NameChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      displayName: event.name,
      isNameValid: _isNameValid(event.name),
    ));
  }

  _onAgeChanged(AgeChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      age: event.age,
      isAgeValid: _isAgeValid(event.age),
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<FormValidate> emit) async {
    UserModel user = UserModel(
        email: state.email,
        password: state.password,
        age: state.age,
        displayName: state.displayName);

    if (event.value == Status.register) {
      await _updateUIAndSignUp(event, emit, user);
    } else if (event.value == Status.login) {
      await _authenticateUser(event, emit, user);
    }
  }

  _onFormSucceeded(FormSucceeded event, Emitter<FormValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }

  bool _isEmailValid(String email) {
    return ValidationConstants.emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length > 5;
  }

  bool _isNameValid(String name) {
    return name.length > 3;
  }

  bool _isAgeValid(int age) {
    return age > 7;
  }

  _updateUIAndSignUp(
      FormSubmitted event, Emitter<FormValidate> emit, UserModel user) async {
    emit(state.copyWith(
        errorMessage: "",
        isFormValid: _isPasswordValid(state.password) &&
            _isEmailValid(state.email) &&
            _isAgeValid(state.age) &&
            _isNameValid(state.displayName ?? ''),
        isLoading: true));
    if (state.isFormValid) {
      try {
        UserCredential? authUser = await _authRepository.signUp(user);
        UserModel updatedUser = user.copyWith(
            uid: authUser!.user!.uid, isVerified: authUser.user!.emailVerified);

        await _databaseRepository.saveUserData(updatedUser);
        if (updatedUser.isVerified!) {
          emit(state.copyWith(isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(
              isFormValid: false,
              errorMessage:
                  "Please Verify your email, by clicking the link sent to you by mail.",
              isLoading: false));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _authenticateUser(
      FormSubmitted event, Emitter<FormValidate> emit, UserModel user) async {
    emit(state.copyWith(
        errorMessage: "",
        isFormValid:
            _isPasswordValid(state.password) && _isEmailValid(state.email),
        isLoading: true));
    if (state.isFormValid) {
      try {
        await _authRepository.signIn(user);
        UserModel updatedUser = user.copyWith(isVerified: true);
        if (updatedUser.isVerified!) {
          emit(state.copyWith(
              isFormValid: true, isLoading: false, errorMessage: ""));
        } else {
          emit(state.copyWith(
              isFormValid: false,
              errorMessage:
                  "Please Verify your email, by clicking the link sent to you by mail.",
              isLoading: false));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }
}
