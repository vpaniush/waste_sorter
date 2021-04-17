import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_sorter/domain/repositories/user_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignUp) {
      yield* _mapSignUp(event);
    } else if (event is SignIn) {
      yield* _mapSignIn(event);
    } else if (event is SignOut) {
      yield* _mapSignOut(event);
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

  Stream<AuthState> _mapSignOut(SignOut event) async* {
    final currentState = state;
    if (currentState is AuthSignedIn) {
      yield AuthInitial();
    }
  }
}
