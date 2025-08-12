import 'package:cloud_firestore/cloud_firestore.dart';
class StepData {
  String? id; // Firebase ডকুমেন্ট আইডি
  String? userId; // ব্যবহারকারীর আইডি
  int? stepsCount; // দৈনিক স্টেপ সংখ্যা
  double? caloriesBurned; // পোড়ানো ক্যালোরি
  double? distance; // দূরত্ব (কিলোমিটারে)
  DateTime? timestamp; // ডাটা রেকর্ডের সময়

  StepData({
    this.id,
    this.userId,
    this.stepsCount,
    this.caloriesBurned,
    this.distance,
    this.timestamp,
  });

  factory StepData.fromMap(Map<String, dynamic> data, String documentId) {
    return StepData(
      id: documentId,
      userId: data['user_id'],
      stepsCount: data['steps_count'],
      caloriesBurned: (data['calories_burned'] as num?)?.toDouble(),
      distance: (data['distance'] as num?)?.toDouble(),
      timestamp: data['timestamp']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'steps_count': stepsCount,
      'calories_burned': caloriesBurned,
      'distance': distance,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}