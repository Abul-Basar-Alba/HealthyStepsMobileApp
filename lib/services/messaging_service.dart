import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService {
  final HttpsCallable _sendMessage = FirebaseFunctions.instance.httpsCallable('sendMessage');

  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    try {
      await _sendMessage.call({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getMessages(String userId, String otherId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', whereIn: [userId, otherId])
        .where('receiverId', whereIn: [userId, otherId])
        .orderBy('timestamp')
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.data()).toList());
  }
}