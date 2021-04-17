import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends AuthEvent {
  final String email;
  final String password;

  SignUp({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  SignIn({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {}
