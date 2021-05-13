import 'package:waste_sorter/data/models/models.dart';

abstract class AuthService {
  Future<User> signUp({String email, String password});

  Future<User> signIn({String email, String password});

  Future<bool> isSignedIn();

  Future<void> signOut();
}
