import 'package:cloud_firestore/cloud_firestore.dart';
class DietLog {
  String? id;
  String? userId;
  String? foodItem; // খাবারের নাম
  int? calories; // ক্যালোরি
  double? protein; // প্রোটিন (গ্রামে)
  double? fat; // চর্বি
  double? carbs; // কার্বোহাইড্রেট
  DateTime? date; // খাওয়ার তারিখ

  DietLog({
    this.id,
    this.userId,
    this.foodItem,
    this.calories,
    this.protein,
    this.fat,
    this.carbs,
    this.date,
  });

  factory DietLog.fromMap(Map<String, dynamic> data, String documentId) {
    return DietLog(
      id: documentId,
      userId: data['user_id'],
      foodItem: data['food_item'],
      calories: data['calories'],
      protein: (data['protein'] as num?)?.toDouble(),
      fat: (data['fat'] as num?)?.toDouble(),
      carbs: (data['carbs'] as num?)?.toDouble(),
      date: data['date']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'food_item': foodItem,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
      'date': date ?? FieldValue.serverTimestamp(),
    };
  }
}