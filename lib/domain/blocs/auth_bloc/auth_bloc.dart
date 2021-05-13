import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_sorter/domain/repositories/user_repository.dart';
import 'package:waste_sorter/domain/validation/email_validation.dart';
import 'package:waste_sorter/domain/validation/password_validation.dart';
import 'package:waste_sorter/domain/validation/validation.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _repository;
  final Validation _emailValidation = EmailValidation();
  final Validation _passwordValidation = PasswordValidation();

  AuthBloc(this._repository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignUp) {
      yield* _mapSignUp(event);
    } else if (event is SignIn) {
      yield* _mapSignIn(event);
    } else if (event is EmailOnChanged) {
      yield* _mapEmailOnChanged(event);
    } else if (event is PasswordOnChanged) {
      yield* _mapPasswordOnChanged(event);
    }
  }

  Stream<AuthState> _mapSignUp(SignUp event) async* {
    final user = await _repository.signUp(
      email: event.email,
      password: event.password,
    );
    if (user != null) {
      yield AuthSignedIn(user);
    }
  }

  Stream<AuthState> _mapSignIn(SignIn event) async* {
    final user = await _repository.signIn(
      email: event.email,
      password: event.password,
    );
    if (user != null) {
      yield AuthSignedIn(user);
    }
  }

  Stream<AuthState> _mapEmailOnChanged(EmailOnChanged event) async* {
    final currentState = state;
    if (currentState is AuthInitial) {
      final message = _emailValidation.validate(event.email).errorMessage;
      yield AuthInitial(
        emailErrorMessage: message,
        passwordErrorMessage: currentState.passwordErrorMessage,
      );
    }
  }

  Stream<AuthState> _mapPasswordOnChanged(PasswordOnChanged event) async* {
    final currentState = state;
    if (currentState is AuthInitial) {
      final message = _passwordValidation.validate(event.password).errorMessage;
      yield AuthInitial(
        emailErrorMessage: currentState.emailErrorMessage,
        passwordErrorMessage: message,
      );
    }
  }
}
