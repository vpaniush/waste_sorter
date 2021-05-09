import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'stats_service.dart';

class FirebaseStatsService implements StatsService {
  final DatabaseReference _db;
  final FirebaseAuth _auth;

  FirebaseStatsService()
      : _db = FirebaseDatabase.instance.reference(),
        _auth = FirebaseAuth.instance;

  @override
  Future<Map<String, int>> getStats() async {
    final userId = _auth.currentUser.uid;
    final path = '$userId/stats';
    final snapshotValue =
        (await _db.child(path).once()).value as Map<dynamic, dynamic>;
    final sortedKeys = snapshotValue.keys.toList()..sort();
    return Map<String, int>.fromIterable(
      sortedKeys,
      key: (key) => key,
      value: (key) => snapshotValue[key],
    );
  }

  @override
  Future<void> updateStats(String wasteType) async {
    final userId = _auth.currentUser.uid;
    final path = '$userId/stats/$wasteType';
    int currentValue = (await _db.child(path).once()).value as int;
    currentValue++;
    _db.child(path).set(currentValue);
  }
}
