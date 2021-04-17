import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_sorter/data/models/user.dart' as models;

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService() : _auth = FirebaseAuth.instance;

  @override
  Future<models.User> signUp({String email, String password}) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return models.User(
      id: userCredential.user.uid,
      email: userCredential.user.email,
    );
  }

  @override
  Future<models.User> signIn({String email, String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return models.User(
      id: userCredential.user.uid,
      email: userCredential.user.email,
    );
  }

  @override
  Future<bool> isSignedIn() async => _auth.currentUser != null;

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
