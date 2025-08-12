import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/step_data.dart';
import '../models/diet_log.dart';
import '../models/challenge.dart';
import '../models/paid_diet.dart';

class FirestoreService {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final CollectionReference _challenges = FirebaseFirestore.instance.collection('challenges');

  // User Management
  Future<void> addUser(User user) {
    return _users.doc(user.id).set(user.toMap());
  }

  Stream<User> getUser(String userId) {
    return _users.doc(userId).snapshots().map((snap) => User.fromMap(snap.data() as Map<String, dynamic>, snap.id));
  }

  Stream<List<User>> getAllUsers() {
    return _users.snapshots().map((snap) => snap.docs.map((doc) => User.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> deleteUser(String userId) {
    return _users.doc(userId).delete();
  }

  // Step Data
  Stream<List<StepData>> getStepData(String userId) {
    return _users.doc(userId).collection('step_data').snapshots().map((snap) =>
        snap.docs.map((doc) => StepData.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addStepData(String userId, StepData stepData) {
    return _users.doc(userId).collection('step_data').add(stepData.toMap());
  }

  // Diet Log
  Stream<List<DietLog>> getDietLogs(String userId) {
    return _users.doc(userId).collection('diet_logs').snapshots().map((snap) =>
        snap.docs.map((doc) => DietLog.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addDietLog(String userId, DietLog dietLog) {
    return _users.doc(userId).collection('diet_logs').add(dietLog.toMap());
  }

  Future<void> deleteDietLog(String userId, String logId) {
    return _users.doc(userId).collection('diet_logs').doc(logId).delete();
  }

  // Challenges
  Stream<List<Challenge>> getChallenges() {
    return _challenges.snapshots().map((snap) =>
        snap.docs.map((doc) => Challenge.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addChallenge(Challenge challenge) {
    return _challenges.add(challenge.toMap());
  }

  Future<void> joinChallenge(String userId, String challengeId) {
    return _challenges.doc(challengeId).update({
      'participants': FieldValue.arrayUnion([userId]),
    });
  }

  // Paid Diet
  Stream<List<PaidDiet>> getPaidDiets(String userId) {
    return _users.doc(userId).collection('paid_diets').snapshots().map((snap) =>
        snap.docs.map((doc) => PaidDiet.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addPaidDiet(String userId, PaidDiet paidDiet) {
    return _users.doc(userId).collection('paid_diets').add(paidDiet.toMap());
  }
}