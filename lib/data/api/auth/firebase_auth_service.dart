import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:waste_sorter/data/api/waste_sorting/waste_labels.dart';
import 'package:waste_sorter/data/models/user.dart' as models;

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;
  final DatabaseReference _db;

  FirebaseAuthService()
      : _auth = FirebaseAuth.instance,
        _db = FirebaseDatabase.instance.reference();

  @override
  Future<models.User> signUp({String email, String password}) async {
    final userCred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCred != null) {
      _db.child('${userCred.user.uid}/stats').update(WasteLabels.labelsMap());
    }
    return models.User(
      id: userCred.user.uid,
      email: userCred.user.email,
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
