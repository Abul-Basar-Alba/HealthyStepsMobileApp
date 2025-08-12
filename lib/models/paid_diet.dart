class PaidDiet {
  String? id;
  String? userId;
  String? dietPlan; // ডায়েট পরিকল্পনা (JSON বা স্ট্রিং)
  double? subscriptionFee; // পেইড ফি
  DateTime? subscriptionStart;
  DateTime? subscriptionEnd;
  List<String>? foodSuggestions; // সাজেশন করা খাবার
  String? category; // ক্যাটাগরি (বেবি, প্রেগন্যান্ট, হার্ট)

  PaidDiet({
    this.id,
    this.userId,
    this.dietPlan,
    this.subscriptionFee,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.foodSuggestions,
    this.category,
  });

  factory PaidDiet.fromMap(Map<String, dynamic> data, String documentId) {
    return PaidDiet(
      id: documentId,
      userId: data['user_id'],
      dietPlan: data['diet_plan'],
      subscriptionFee: (data['subscription_fee'] as num?)?.toDouble(),
      subscriptionStart: data['subscription_start']?.toDate(),
      subscriptionEnd: data['subscription_end']?.toDate(),
      foodSuggestions: List<String>.from(data['food_suggestions'] ?? []),
      category: data['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'diet_plan': dietPlan,
      'subscription_fee': subscriptionFee,
      'subscription_start': subscriptionStart,
      'subscription_end': subscriptionEnd,
      'food_suggestions': foodSuggestions ?? [],
      'category': category,
    };
  }
}