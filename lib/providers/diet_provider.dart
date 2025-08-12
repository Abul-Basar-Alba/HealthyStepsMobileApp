import 'package:flutter_riverpod/flutter_riverpod.dart'; // Added import for StreamProvider
import '../models/diet_log.dart';
import '../services/firestore_service.dart';
import 'user_provider.dart';

final dietProvider = StreamProvider<List<DietLog>>((ref) {
  final user = ref.watch(userProvider);
  final userId = user?.userId;
  if (userId == null) return Stream.value([]);
  return ref.watch(firestoreServiceProvider).getDietLogs(userId);
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});