import 'package:meta/meta.dart';
import 'package:waste_sorter/data/api/auth/auth_service.dart';
import 'package:waste_sorter/data/models/models.dart';

class UserRepository {
  final AuthService _service;

  UserRepository(this._service);

  Future<User> signUp({@required String email, @required String password}) =>
      _service.signUp(email: email, password: password);

  Future<User> signIn({@required String email, @required String password}) =>
      _service.signIn(email: email, password: password);

  Future<bool> isSignedIn() => _service.isSignedIn();

  Future<void> signOut() => _service.signOut();
}
