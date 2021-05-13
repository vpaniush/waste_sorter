import 'package:equatable/equatable.dart';
import 'package:waste_sorter/data/models/models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  final String emailErrorMessage;
  final String passwordErrorMessage;

  AuthInitial({this.emailErrorMessage, this.passwordErrorMessage});

  @override
  List<Object> get props => [emailErrorMessage, passwordErrorMessage];
}

class AuthSignedIn extends AuthState {
  final User user;

  AuthSignedIn(this.user);

  @override
  List<Object> get props => [user];
}
