import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoaded extends AppState {
  final bool isSignedIn;

  AppLoaded({this.isSignedIn = false});

  @override
  List<Object> get props => [isSignedIn];
}
