import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Added import for StateNotifierProvider and Provider
import '../models/user.dart' as app_model;
import '../services/firestore_service.dart';

final userProvider = StateNotifierProvider<UserProvider, app_model.User?>((ref) {
  return UserProvider(ref.watch(firestoreServiceProvider));
});

class UserProvider extends StateNotifier<app_model.User?> {
  final FirestoreService _firestoreService;

  UserProvider(this._firestoreService) : super(null);

  String? get userId => state?.id;

  app_model.User? get user => state;

  Future<void> login(String email, String password) async {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    state = await _firestoreService.getUser(userCredential.user!.uid).first;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    state = null;
  }
}

final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());